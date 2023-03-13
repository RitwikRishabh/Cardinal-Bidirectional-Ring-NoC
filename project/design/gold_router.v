`include "buffer.sv"
`include "rotating_prioritizer.sv"

module gold_router #(
    parameter PACKET_SIZE = 64
) (
    input clk, reset,
    output polarity,

    input cwsi,                             // Clockwise input send 
    output reg cwri,                        // Clockwise input receive
    input [PACKET_SIZE-1:0] cwdi,           // Clockwise input data 

    input ccwsi,                            // Counter-clockwise input send
    output reg ccwri,                       // Counter-clockwise input receive
    input [PACKET_SIZE-1:0] ccwdi,          // Counter-clockwise input data

    input pesi,                             // Processing element input send
    output reg peri,                        // Processing element input receive
    input [PACKET_SIZE-1:0] pedi,           // Processing element input data

    output reg cwso,                        // Clockwise output send
    input cwro,                             // Clockwise output receive
    output reg [PACKET_SIZE-1:0] cwdo,      // Clockwise output data

    output reg ccwso,                       // Counter-clockwise output send
    input ccwro,                            // Counter-clockwise output receive
    output reg [PACKET_SIZE-1:0] ccwdo,     // Counter-clockwise output data

    output reg peso,                        // Processing element output send                 
    input pero,                             // Processing element output receive
    output reg [PACKET_SIZE-1:0] pedo       // Processing element output data
);

    // Wires for polarity
    reg evenOdd;
    /*  Polarity logic
        Every clock cycle, not the polarity signal
    */
    always @(posedge clk) begin
        if (reset) begin
            evenOdd <= 0;
        end
        else begin
            evenOdd <= ~evenOdd;
        end
    end
    assign polarity = evenOdd;

    // Create wires for input side
    reg wrEnableCwi [0:1], wrEnableCcwi [0:1], wrEnablePei [0:1];
    reg rdEnableCwi [0:1], rdEnableCcwi [0:1], rdEnablePei [0:1];
    wire emptyCwi [0:1], emptyCcwi [0:1], emptyPei [0:1];
    wire fullCwi [0:1], fullCcwi [0:1], fullPei [0:1];
    wire [PACKET_SIZE-1:0] dataCwi [0:1], dataCcwi [0:1], dataPei [0:1];


    // Create 6 single-location input buffers (3 input channels each having 2 virtual channels each)  
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwi[0]),
        .rdEnable(rdEnableCwi[0]),
        .dataIn(cwdi),
        .dataOut(dataCwi[0]),
        .full(fullCwi[0]),
        .empty(emptyCwi[0])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwi[1]),
        .rdEnable(rdEnableCwi[1]),
        .dataIn(cwdi),
        .dataOut(dataCwi[1]),
        .full(fullCwi[1]),
        .empty(emptyCwi[1])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwi[0]),
        .rdEnable(rdEnableCcwi[0]),
        .dataIn(ccwdi),
        .dataOut(dataCcwi[0]),
        .full(fullCcwi[0]),
        .empty(emptyCcwi[0])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwi[1]),
        .rdEnable(rdEnableCcwi[1]),
        .dataIn(ccwdi),
        .dataOut(dataCcwi[1]),
        .full(fullCcwi[1]),
        .empty(emptyCcwi[1])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePei[0]),
        .rdEnable(rdEnablePei[0]),
        .dataIn(pedi),
        .dataOut(dataPei[0]),
        .full(fullPei[0]),
        .empty(emptyPei[0])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePei[1]),
        .rdEnable(rdEnablePei[1]),
        .dataIn(pedi),
        .dataOut(dataPei[1]),
        .full(fullPei[1]),
        .empty(emptyPei[1])
    );
    
    // Decode header information
    // Virtual Channel -- 1 bit
    // wire vcCwi, vcCCwi, vcPei;
    // assign vcCwi = cwdi[63];
    // assign vcCCwi = ccwdi[63];
    // assign vcPei = pedi[63];
    // // Direction -- 1 bit
    // wire dirCwi, dirCcwi, dirPei;
    // assign dirCwi = cwdi[62];
    // assign dirCcwi = ccwdi[62];
    // assign dirPei = pedi[62];
    // // Hop Value -- 8 bits
    // wire [7:0] hopCwi, hopCcwi, hopPei;
    // assign hopCwi = cwdi[55:48];
    // assign hopCcwi = ccwdi[55:48];
    // assign hopPei = pedi[55:48];

    /*  Write enable logic
        Only enable write once handshaking is complete
    */
    always @(*) begin
        wrEnableCwi = '{default:0};
        wrEnableCcwi = '{default:0};
        wrEnablePei = '{default:0};

        // Clockwise
        if (cwsi && cwri) begin
            wrEnableCwi[evenOdd] = 1;
        end
        // Counter-clockwise
        if (ccwsi && ccwri) begin
            wrEnableCcwi[evenOdd] = 1;
        end
        // Processing element
        if (pesi && peri) begin
            wrEnablePei[evenOdd] = 1;
        end
    end

    /*  Ready signal logic for input buffers
        When empty signal is asserted, buffer is ready
    */ 
    always @(*) begin
        // Clockwise
        if (emptyCwi[evenOdd]) begin
            cwri = 1;
        end
        else begin
            cwri = 0;
        end
        // Counter-clockwise
        if (emptyCcwi[evenOdd]) begin
            ccwri = 1;
        end
        else begin
            ccwri = 0;
        end
        // Processing element
        if (emptyPei[evenOdd]) begin
            peri = 1;
        end
        else begin
            peri = 0;
        end
    end
    
    // Create wires for output side
    reg wrEnableCwo [0:1], wrEnableCcwo [0:1], wrEnablePeo [0:1];
    wire rdEnableCwo [0:1], rdEnableCcwo [0:1], rdEnablePeo [0:1];
    wire emptyCwo [0:1], emptyCcwo [0:1], emptyPeo [0:1];
    wire fullCwo [0:1], fullCcwo [0:1], fullPeo [0:1];    
    reg [PACKET_SIZE-1:0] dataInCwo [0:1], dataInCcwo [0:1], dataInPeo [0:1];
    wire [PACKET_SIZE-1:0] dataOutCwo [0:1], dataOutCcwo [0:1], dataOutPeo [0:1];

    // Create 6 single-location output buffers (3 output channels each having 2 virtual channels each)

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwo[0]),
        .rdEnable(rdEnableCwo[0]),
        .dataIn(dataInCwo[0]),
        .dataOut(dataOutCwo[0]),
        .full(fullCwo[0]),
        .empty(emptyCwo[0])
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwo[1]),
        .rdEnable(rdEnableCwo[1]),
        .dataIn(dataInCwo[1]),
        .dataOut(dataOutCwo[1]),
        .full(fullCwo[1]),
        .empty(emptyCwo[1])
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwo[0]),
        .rdEnable(rdEnableCcwo[0]),
        .dataIn(dataInCcwo[0]),
        .dataOut(dataOutCcwo[0]),
        .full(fullCcwo[0]),
        .empty(emptyCcwo[0])
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwo[1]),
        .rdEnable(rdEnableCcwo[1]),
        .dataIn(dataInCcwo[1]),
        .dataOut(dataOutCcwo[1]),
        .full(fullCcwo[1]),
        .empty(emptyCcwo[1])
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeo[0]),
        .rdEnable(rdEnablePeo[0]),
        .dataIn(dataInPeo[0]),
        .dataOut(dataOutPeo[0]),
        .full(fullPeo[0]),
        .empty(emptyPeo[0])
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeo[1]),
        .rdEnable(rdEnablePeo[1]),
        .dataIn(dataInPeo[1]),
        .dataOut(dataOutPeo[1]),
        .full(fullPeo[1]),
        .empty(emptyPeo[1])
    );

    //Wires for sending requests from input buffer to output buffer
    reg reqCwiCwo, reqCwiPeo;
    reg reqCcwiCcwo, reqCcwiPeo;
    reg reqPeiCwo, reqPeiCcwo;

    /*  Request Signal Logic
        Every input buffer will send requests to the arbiter of one of the output buffers
        If input buffer is full and the output buffer is empty, then it will send a request to the output buffer
        The target output buffer is determined by direction and hop-value
    */
    always @(*) begin
        {reqCwiCwo, reqCwiPeo, reqCcwiCcwo, reqCcwiPeo, reqPeiCwo, reqPeiCcwo} = 6'b0;

        if (fullCwo[~evenOdd] && dataCwi[~evenOdd][48] && emptyCwo[~evenOdd]) begin // Bit 48 is the LSB of hop value, Internally service the other channel
            reqCwiCwo = 1;
        end
        if (fullCwi[~evenOdd] && !dataCwi[~evenOdd][48] && emptyPeo[~evenOdd]) begin
            reqCwiPeo = 1;
        end
        if (fullCcwi[~evenOdd] && dataCcwi[~evenOdd][48] && emptyCcwo[~evenOdd]) begin
            reqCcwiCcwo = 1;
        end
        if (fullCcwi[~evenOdd] && !dataCcwi[~evenOdd][48] && emptyPeo[~evenOdd]) begin
            reqCcwiPeo = 1;
        end

        // Check dir bit for processing element
        if (fullPei[~evenOdd] && dataPei[~evenOdd][62] && emptyCwo[~evenOdd]) begin // Bit 62 is dir
            reqPeiCwo = 1;
        end
        if (fullPei[~evenOdd] && !dataCcwi[~evenOdd][62] && emptyCcwo[~evenOdd]) begin
            reqPeiCcwo = 1;
        end
    end

    // Wires for the 3 arbiters which are made using rotating prioritizers
    wire grantCwiCwo, grantCwiPeo;
    wire grantCcwiCcwo, grantCcwiPeo;
    wire grantPeiCwo, grantPeiCcwo;

    rotating_prioritizer arbiterCwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCwiCwo),
        .req1(reqPeiCwo),
        .grant0(grantCwiCwo),
        .grant1(grantCwiPeo)
    );

    rotating_prioritizer arbiterCcwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCcwiCcwo),
        .req1(reqPeiCcwo),
        .grant0(grantCcwiCcwo),
        .grant1(grantCcwiPeo)
    );

    rotating_prioritizer arbiterPeo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCwiPeo),
        .req1(reqCcwiPeo),
        .grant0(grantPeiCwo),
        .grant1(grantPeiCcwo)
    );

    /* Data transfer logic
        Once arbiter grants permission to any request, the data can be loaded into the subsequent output buffer
    */
    always @(*) begin
        if (grantCwiCwo) begin
            rdEnableCwi[evenOdd] = 1;
            wrEnableCwo[evenOdd] = 1;
            dataInCwo[evenOdd] = dataCwi[evenOdd]; // Pass data from input buffer to output buffer
            dataInCwo[evenOdd][55:48] = dataCwi[evenOdd][55:48] >> 1; // Right shift hop counter by 1 
        end
        if (grantCwiPeo) begin
            rdEnableCwi[evenOdd] = 1;
            wrEnablePeo[evenOdd] = 1;
            dataInPeo[evenOdd] = dataCwi[evenOdd];
            dataInPeo[evenOdd][55:48] = dataCwi[evenOdd][55:48] >> 1;
        end
        if (grantCcwiCcwo) begin
            rdEnableCcwi[evenOdd] = 1;
            wrEnableCcwo[evenOdd] = 1;
            dataInCcwo[evenOdd] = dataCcwi[evenOdd];
            dataInCcwo[evenOdd][55:48] = dataCcwi[evenOdd][55:48] >> 1;
        end
        if (grantCcwiPeo) begin
            rdEnableCcwi[evenOdd] = 1;
            wrEnablePeo[evenOdd] = 1;
            dataInPeo[evenOdd] = dataCcwi[evenOdd];
            dataInPeo[evenOdd][55:48] = dataCcwi[evenOdd][55:48] >> 1;
        end
        if (grantPeiCwo) begin
            rdEnablePei[evenOdd] = 1;
            wrEnableCwo[evenOdd] = 1;
            dataInCwo[evenOdd] = dataPei[evenOdd];
            dataInCwo[evenOdd][55:48] = dataPei[evenOdd][55:48] >> 1;
        end
        if (grantPeiCcwo) begin
            rdEnablePei[evenOdd] = 1;
            wrEnableCcwo[evenOdd] = 1;
            dataInCcwo[evenOdd] = dataPei[evenOdd];
            dataInCcwo[evenOdd][55:48] = dataPei[evenOdd][55:48] >> 1;
        end
    end

    /* Router output data port logic */
    assign cwdo = dataOutCwo[~evenOdd];
    assign ccwdo = dataOutCcwo[~evenOdd];
    assign pedo = dataOutPeo[~evenOdd];

    /* Router output send port logic 
     * Need ready signal to also be asserted
    */
   assign cwso = fullCwo[~evenOdd] & cwro;
   assign ccwso = fullCcwo[~evenOdd] & ccwro;
   assign peso = fullPeo[~evenOdd] & pero;

   /* Router output read enable logic */
   assign rdEnableCwo[0] = evenOdd ? cwso & cwro : 0;
   assign rdEnableCwo[1] = ~evenOdd ? cwso & cwro : 0;
   assign rdEnableCcwo[0] = evenOdd ? ccwso & ccwro : 0;
   assign rdEnableCcwo[1] = ~evenOdd ? ccwso & ccwro : 0;
   assign rdEnablePeo[0] = evenOdd ? peso & pero : 0;
   assign rdEnablePeo[1] = ~evenOdd ? peso & pero : 0;
endmodule