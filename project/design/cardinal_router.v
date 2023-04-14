// `include "./design/buffer.v"
`include "./design/rotating_prioritizer.v"

module cardinal_router 
#(
    parameter PACKET_SIZE = 64
)
(
    input clk, reset,                    // synchronous active high reset
    output reg polarity,

    input cwsi,                         // clockwise input channel send signal
    output reg cwri,                        // clockwise input ready signal
    input [PACKET_SIZE - 1:0] cwdi,     // clockwise input channel dataIn 

    input ccwsi,                        // counter clockwise input channel send signal
    output reg ccwri,                       // counter clockwise input ready signal
    input [PACKET_SIZE - 1:0] ccwdi,    // counter clockwise input channel dataIn

    input pesi,                         // processing element input channel send signal
    output reg peri,                        // processing element input channel ready signal
    input [PACKET_SIZE - 1:0] pedi,     // processing element input channel dataIn 

    output cwso,                        // clockwise output channel send signal
    input cwro,                         // clockwise output channel ready signal
    output [PACKET_SIZE - 1:0] cwdo,    // clockwise output channel dataOut

    output ccwso,                       // counter clockwise output channel send signal
    input ccwro,                        // counter clockwise output channel ready signal
    output [PACKET_SIZE - 1:0] ccwdo,   // counter clockwise output channel dataOut

    output peso,                        // processing element output channel send signal
    input pero,                         // processing element output channel ready signal
    output [PACKET_SIZE - 1:0] pedo     // processing element output channel dataOut
);

//--------------------------------------------Sub-module Instatiations---------------------------------------------------
    // Six input buffers
    wire fullCwi0, fullCwi1, fullCcwi0, fullCcwi1, fullPei0, fullPei1;
    wire emptyCwi0, emptyCwi1, emptyCcwi0, emptyCcwi1, emptyPei0, emptyPei1;
    reg rdEnableCwi0, rdEnableCwi1, rdEnableCcwi0, rdEnableCcwi1, rdEnablePei0, rdEnablePei1;
    reg wrEnableCwi0, wrEnableCwi1, wrEnableCcwi0, wrEnableCcwi1, wrEnablePei0, wrEnablePei1;
    wire [PACKET_SIZE - 1:0] dataCwi0, dataCwi1, dataCcwi0, dataCcwi1, dataPei0, dataPei1;

    bufferDepth1 bufCwi0
    (
        .clk(clk),
        .reset(reset),
        .full(fullCwi0),
        .empty(emptyCwi0),
        .rdEnable(rdEnableCwi0),
        .wrEnable(wrEnableCwi0),
        .dataIn(cwdi),
        .dataOut(dataCwi0)
    );

    bufferDepth1 bufCwi1
    (
        .clk(clk),
        .reset(reset),
        .full(fullCwi1),
        .empty(emptyCwi1),
        .rdEnable(rdEnableCwi1),
        .wrEnable(wrEnableCwi1),
        .dataIn(cwdi),
        .dataOut(dataCwi1)
    );

    bufferDepth1 bufCcwi0
    (
        .clk(clk),
        .reset(reset),
        .full(fullCcwi0),
        .empty(emptyCcwi0),
        .rdEnable(rdEnableCcwi0),
        .wrEnable(wrEnableCcwi0),
        .dataIn(ccwdi),
        .dataOut(dataCcwi0)
    );

    bufferDepth1 bufCcwi1
    (
        .clk(clk),
        .reset(reset),
        .full(fullCcwi1),
        .empty(emptyCcwi1),
        .rdEnable(rdEnableCcwi1),
        .wrEnable(wrEnableCcwi1),
        .dataIn(ccwdi),
        .dataOut(dataCcwi1)
    );

    bufferDepth1 bufPei0
    (
        .clk(clk),
        .reset(reset),
        .full(fullPei0),
        .empty(emptyPei0),
        .rdEnable(rdEnablePei0),
        .wrEnable(wrEnablePei0),
        .dataIn(pedi),
        .dataOut(dataPei0)
    );   

    bufferDepth1 bufPei1
    (
        .clk(clk),
        .reset(reset),
        .full(fullPei1),
        .empty(emptyPei1),
        .rdEnable(rdEnablePei1),
        .wrEnable(wrEnablePei1),
        .dataIn(pedi),
        .dataOut(dataPei1)
    ); 

    // Six output buffers
    wire fullCwo0, fullCwo1, fullCcwo0, fullCcwo1, fullPeo0, fullPeo1;
    wire emptyCwo0, emptyCwo1, emptyCcwo0, emptyCcwo1, emptyPeo0, emptyPeo1;
    wire rdEnableCwo0, rdEnableCwo1, rdEnableCcwo0, rdEnableCcwo1, rdEnablePeo0, rdEnablePeo1;
    reg wrEnableCwo0, wrEnableCwo1, wrEnableCcwo0, wrEnableCcwo1, wrEnablePeo0, wrEnablePeo1;
    reg [PACKET_SIZE - 1:0] dataInCwo0, dataInCwo1, dataInCcwo0, dataInCcwo1, dataInPeo0, dataInPeo1;
    wire [PACKET_SIZE - 1:0] dataOutCwo0, dataOutCwo1, dataOutCcwo0, dataOutCcwo1, dataOutPeo0, dataOutPeo1;

    bufferDepth1 bufCwo0
    (
        .clk(clk),
        .reset(reset),
        .full(fullCwo0),
        .empty(emptyCwo0),
        .rdEnable(rdEnableCwo0),
        .wrEnable(wrEnableCwo0),
        .dataIn(dataInCwo0),
        .dataOut(dataOutCwo0)
    );

    bufferDepth1 bufCwo1
    (
        .clk(clk),
        .reset(reset),
        .full(fullCwo1),
        .empty(emptyCwo1),
        .rdEnable(rdEnableCwo1),
        .wrEnable(wrEnableCwo1),
        .dataIn(dataInCwo1),
        .dataOut(dataOutCwo1)
    );

    bufferDepth1 bufCcwo0
    (
        .clk(clk),
        .reset(reset),
        .full(fullCcwo0),
        .empty(emptyCcwo0),
        .rdEnable(rdEnableCcwo0),
        .wrEnable(wrEnableCcwo0),
        .dataIn(dataInCcwo0),
        .dataOut(dataOutCcwo0)
    );

    bufferDepth1 bufCcwo1
    (
        .clk(clk),
        .reset(reset),
        .full(fullCcwo1),
        .empty(emptyCcwo1),
        .rdEnable(rdEnableCcwo1),
        .wrEnable(wrEnableCcwo1),
        .dataIn(dataInCcwo1),
        .dataOut(dataOutCcwo1)
    );

    bufferDepth1 bufPeo0
    (
        .clk(clk),
        .reset(reset),
        .full(fullPeo0),
        .empty(emptyPeo0),
        .rdEnable(rdEnablePeo0),
        .wrEnable(wrEnablePeo0),
        .dataIn(dataInPeo0),
        .dataOut(dataOutPeo0)
    );   

    bufferDepth1 bufPeo1
    (
        .clk(clk),
        .reset(reset),
        .full(fullPeo1),
        .empty(emptyPeo1),
        .rdEnable(rdEnablePeo1),
        .wrEnable(wrEnablePeo1),
        .dataIn(dataInPeo1),
        .dataOut(dataOutPeo1)
    );  

    // Three rotating prioritizers (arbiters) for three output buffers
    reg reqCwiCwo, reqCwiPeo;
    reg reqCcwiCcwo, reqCcwiPeo;
    reg reqPeiCwo, reqPeiCcwo;
    wire grantCwiCwo, grantCwiPeo; 
    wire grantCcwiCcwo, grantCcwiPeo;
    wire grantPeiCwo, grantPeiCcwo;

    rotating_prioritizer arbiterCwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(polarity),
        .req0(reqCwiCwo),
        .req1(reqPeiCwo),
        .grant0(grantCwiCwo),
        .grant1(grantPeiCwo)
    );

    rotating_prioritizer arbiterCcwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(polarity),
        .req0(reqCcwiCcwo),
        .req1(reqPeiCcwo),
        .grant0(grantCcwiCcwo),
        .grant1(grantPeiCcwo)
    );

    rotating_prioritizer arbiterPeo
    (
        .clk(clk),
        .reset(reset),
        .polarity(polarity),
        .req0(reqCwiPeo),
        .req1(reqCcwiPeo),
        .grant0(grantCwiPeo),
        .grant1(grantCcwiPeo)
    );
//--------------------------------------------End Sub-module Instatiations-----------------------------------------------

//--------------------------------------------------Continuous statements------------------------------------------------
    // Logic for dataOut port of router
    assign cwdo     = (!polarity)   ? dataOutCwo1   : dataOutCwo0;
    assign ccwdo    = (!polarity)   ? dataOutCcwo1  : dataOutCcwo0;  
    assign pedo     = (!polarity)   ? dataOutPeo1   : dataOutPeo0;

    /* 
        Logic for send singal at output channel
        The assertion of send signal depends on ready signal
    */
    assign cwso     = (!polarity) ? (fullCwo1 & cwro)   : (fullCwo0 & cwro);
    assign ccwso    = (!polarity) ? (fullCcwo1 & ccwro) : (fullCcwo0 & ccwro);  
    assign peso     = (!polarity) ? (fullPeo1 & pero)   : (fullPeo0 & pero);    

    // Logic for read enable of output buffer
    assign rdEnableCwo0     = (polarity)       ? (cwso & cwro)      : 0;
    assign rdEnableCwo1     = (!polarity)      ? (cwso & cwro)      : 0;
    assign rdEnableCcwo0    = (polarity)       ? (ccwso & ccwro)    : 0;  
    assign rdEnableCcwo1    = (!polarity)      ? (ccwso & ccwro)    : 0;  
    assign rdEnablePeo0     = (polarity)       ? (peso & pero)      : 0;
    assign rdEnablePeo1     = (!polarity)      ? (peso & pero)      : 0;
//--------------------------------------------------End Continuous statements--------------------------------------------

//--------------------------------------------------Procedural Blocks----------------------------------------------------

    /*
        Polarity
    */
    always @(posedge clk) begin
        if (reset) begin
            polarity <= 0;
        end
        else begin
            polarity <= ~polarity;
        end
    end

    /*
        Logic for ready signal at input channel
        Once the input buffer is empty, ready is asserted at the corresponding channel
        hop = 0 is ilegal when entering the router
        wrEnable must assume the hop value must be greater than 1 when entering the router
    */
    always @(*) begin
        if(polarity == 0) begin
            if(emptyCwi1) begin 
                cwri = 1;
            end
            else begin 
                cwri = 0;
            end
            
            if(emptyCcwi1) begin 
                ccwri = 1;
            end
            else begin 
                ccwri = 0;
            end
            
            if(emptyPei1) begin 
                peri = 1; 
            end
            else begin 
                peri = 0;
            end
        end
        else begin // if polarity == 1
            if(emptyCwi0) begin 
                cwri = 1;
            end
            else begin 
                cwri = 0;
            end
            
            if(emptyCcwi0) begin 
                ccwri = 1;
            end
            else begin 
                ccwri = 0;
            end
            
            if(emptyPei0) begin 
                peri = 1;
            end
            else begin 
                peri = 0;
            end
        end
    end
    
    /* 
        Logic for write enable signal at input channel buffer
        only when both send and ready are asserted, data can be loaded into input buffer
    */
    always @(*) begin
        if(polarity == 0) begin
            wrEnableCwi0 = 0;
            wrEnableCcwi0 = 0;
            wrEnablePei0 = 0;

            if(cwsi && cwri) begin 
                wrEnableCwi1 = 1;
            end
            else begin 
                wrEnableCwi1 = 0;
            end

            if(ccwsi && ccwri) begin
                wrEnableCcwi1 = 1;
            end
            else begin 
                wrEnableCcwi1 = 0; 
            end

            if(pesi && peri) begin 
                wrEnablePei1 = 1;
            end
            else begin 
                wrEnablePei1 = 0;   
            end
        end
        else begin
            wrEnableCwi1 = 0;
            wrEnableCcwi1 = 0;
            wrEnablePei1 = 0;

            if(cwsi && cwri) begin 
                wrEnableCwi0 = 1;
            end
            else begin 
                wrEnableCwi0 = 0;
            end

            if(ccwsi && ccwri) begin 
                wrEnableCcwi0 = 1;
            end
            else begin 
                wrEnableCcwi0 = 0; 
            end

            if(pesi && peri) begin 
                wrEnablePei0 = 1;
            end
            else begin 
                wrEnablePei0 = 0; 
            end
        end 
    end

    /* 
        Logic for request signals
        If possible, each input buffer will send requests to the arbiter of one of output buffer
        If the input buffer is full and target output buffer is empty, the input buffer will send request to that output buffer
        Based on value of hop counter or dir bit, each input buffer will send requests to the corresponding output buffer
    */
    always @(*) begin
        reqCwiCwo = 0;
        reqCwiPeo = 0;
        reqCcwiCcwo = 0;
        reqCcwiPeo = 0;
        reqPeiCwo = 0;
        reqPeiCcwo = 0;

        if(polarity == 0) begin // if polarity == 0, data in vitual channel 0 will be served internally
            // bit 48 is LSB of hop counter
            if(fullCwi0 && (dataCwi0[48] == 1) && emptyCwo0) begin 
                reqCwiCwo = 1;
            end
            if(fullCwi0 && (dataCwi0[48] == 0) && emptyPeo0) begin 
                reqCwiPeo = 1;
            end
            
            if(fullCcwi0 && (dataCcwi0[48] == 1) && emptyCcwo0) begin 
                reqCcwiCcwo = 1;
            end
            if(fullCcwi0 && (dataCcwi0[48] == 0) && emptyPeo0) begin 
                reqCcwiPeo = 1;
            end

            // if dir = 0, go along clockwise direction, vice versa
            // bit 62 is dir bit
            if(fullPei0 && (dataPei0[62] == 0) && emptyCwo0) begin 
                reqPeiCwo = 1;
            end
            if(fullPei0 && (dataPei0[62] == 1) && emptyCcwo0) begin 
                reqPeiCcwo = 1;
            end
        end
        else begin // if polarity == 1, deal with virtual channel 1
            if(fullCwi1 && (dataCwi1[48] == 1) && emptyCwo1) begin 
                reqCwiCwo = 1;
            end
            if(fullCwi1 && (dataCwi1[48] == 0) && emptyPeo1) begin 
                reqCwiPeo = 1;
            end
            
            if(fullCcwi1 && (dataCcwi1[48] == 1) && emptyCcwo1) begin 
                reqCcwiCcwo = 1;
            end
            if(fullCcwi1 && (dataCcwi1[48] == 0) && emptyPeo1) begin 
                reqCcwiPeo = 1;
            end

            if(fullPei1 && (dataPei1[62] == 0) && emptyCwo1) begin 
                reqPeiCwo = 1;
            end
            if(fullPei1 && (dataPei1[62] == 1) && emptyCcwo1) begin 
                reqPeiCcwo = 1;
            end
        end
    end

    /* 
        Logic for data transferring
        Based on which requests are granted by arbiter
        Once arbiter grants permission for one request, the data can be loaded into output buffer
    */
    always @(*) begin
        rdEnableCwi0 = 0;
        rdEnableCwi1 = 0;
        rdEnableCcwi0 = 0;
        rdEnableCcwi1 = 0;
        rdEnablePei0 = 0;
        rdEnablePei1 = 0;
        
        wrEnableCwo0 = 0;
        wrEnableCwo1 = 0;
        wrEnableCcwo0 = 0;
        wrEnableCcwo1 = 0;
        wrEnablePeo0 = 0;
        wrEnablePeo1 = 0;

        dataInCwo0 = 64'bx;
        dataInCwo1 = 64'bx;
        dataInCcwo0 = 64'bx;
        dataInCcwo1 = 64'bx;
        dataInPeo0 = 64'bx;
        dataInPeo1 = 64'bx;

        if(polarity == 0) // polarity == 0
        begin
            if(grantCwiCwo) begin                           // if transfer from cwi to cwo was permitted
                rdEnableCwi0 = 1;
                wrEnableCwo0 = 1;
                dataInCwo0 = dataCwi0;                      // carry data from input buffer to output buffer
                dataInCwo0[55-:8] = dataCwi0[55-:8] >> 1;   // right shift hop counter by 1 bit
            end

            if(grantCwiPeo) begin
                rdEnableCwi0 = 1;
                wrEnablePeo0 = 1;
                dataInPeo0 = dataCwi0;
                dataInPeo0[55-:8] = dataCwi0[55-:8] >> 1;
            end

            if(grantCcwiCcwo) begin
                rdEnableCcwi0 = 1;
                wrEnableCcwo0 = 1;
                dataInCcwo0 = dataCcwi0;
                dataInCcwo0[55-:8] = dataCcwi0[55-:8] >> 1;
            end

            if(grantCcwiPeo) begin
                rdEnableCcwi0 = 1;
                wrEnablePeo0 = 1;
                dataInPeo0 = dataCcwi0;
                dataInPeo0[55-:8] = dataCcwi0[55-:8] >> 1;
            end

            if(grantPeiCwo) begin
                rdEnablePei0 = 1;
                wrEnableCwo0 = 1;
                dataInCwo0 = dataPei0;
                dataInCwo0[55-:8] = dataPei0[55-:8] >> 1;
            end

            if(grantPeiCcwo) begin
                rdEnablePei0 = 1;
                wrEnableCcwo0 = 1;
                dataInCcwo0 = dataPei0;
                dataInCcwo0[55-:8] = dataPei0[55-:8] >> 1;
            end
        end
        else // polarity == 1
        begin
            if(grantCwiCwo) begin
                rdEnableCwi1 = 1;
                wrEnableCwo1 = 1;
                dataInCwo1 = dataCwi1;
                dataInCwo1[55-:8] = dataCwi1[55-:8] >> 1;
            end

            if(grantCwiPeo) begin
                rdEnableCwi1 = 1;
                wrEnablePeo1 = 1;
                dataInPeo1 = dataCwi1;
                dataInPeo1[55-:8] = dataCwi1[55-:8] >> 1;
            end

            if(grantCcwiCcwo) begin
                rdEnableCcwi1 = 1;
                wrEnableCcwo1 = 1;
                dataInCcwo1 = dataCcwi1;
                dataInCcwo1[55-:8] = dataCcwi1[55-:8] >> 1;
            end

            if(grantCcwiPeo) begin
                rdEnableCcwi1 = 1;
                wrEnablePeo1 = 1;
                dataInPeo1 = dataCcwi1;
                dataInPeo1[55-:8] = dataCcwi1[55-:8] >> 1;
            end

            if(grantPeiCwo) begin
                rdEnablePei1 = 1;
                wrEnableCwo1 = 1;
                dataInCwo1 = dataPei1;
                dataInCwo1[55-:8] = dataPei1[55-:8] >> 1;
            end

            if(grantPeiCcwo) begin
                rdEnablePei1 = 1;
                wrEnableCcwo1 = 1;
                dataInCcwo1 = dataPei1;
                dataInCcwo1[55-:8] = dataPei1[55-:8] >> 1;
            end
        end
    end 
//------------------------------------------------End Procedural Blocks--------------------------------------------------
endmodule 