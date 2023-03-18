module cardinal_ring 
#(
    parameter PACKET_SIZE = 64
)
(
    input clk, reset, // sync hign active reset

    // Ports with device 0
    input node0Pesi, node0Pero,
    output node0Peri, node0Peso,
    input [PACKET_SIZE - 1:0] node0Pedi,
    output [PACKET_SIZE - 1:0] node0Pedo,

    // Ports with device 1
    input node1Pesi, node1Pero,
    output node1Peri, node1Peso,
    input [PACKET_SIZE - 1:0] node1Pedi,
    output [PACKET_SIZE - 1:0] node1Pedo, 

    // Ports with device 2
    input node2Pesi, node2Pero,
    output node2Peri, node2Peso,
    input [PACKET_SIZE - 1:0] node2Pedi,
    output [PACKET_SIZE - 1:0] node2Pedo,

    // Ports with device 3
    input node3Pesi, node3Pero,
    output node3Peri, node3Peso,
    input [PACKET_SIZE - 1:0] node3Pedi,
    output [PACKET_SIZE - 1:0] node3Pedo,

    // Polarity output
    output node0Polarity, node1Polarity, node2Polarity, node3Polarity
);

    // Generate the polarity of clock
    reg polarity;
    always @(posedge clk)
    begin
        if(reset) polarity <= 0; // reset to even polarity
        else polarity <= ~ polarity;
    end
    
    // Output polarity used by NiC
    assign node0Polarity = polarity;
    assign node1Polarity = polarity;
    assign node2Polarity = polarity;
    assign node3Polarity = polarity;

    // Intermediate wires used to connect each two routers
    wire cwr0, cwr1, cwr2, cwr3;
    wire cws0, cws1, cws2, cws3;
    wire [PACKET_SIZE-1:0] cwd0, cwd1, cwd2, cwd3;
    wire ccwr0, ccwr1, ccwr2, ccwr3;
    wire ccws0, ccws1, ccws2, ccws3;
    wire [PACKET_SIZE-1:0] ccwd0, ccwd1, ccwd2, ccwd3;

//-----------------------------------------------------------------------------------------------------------------------
    //Instantiate four routers and connect them
    cardinal_router #(
        .PACKET_SIZE(PACKET_SIZE)
    )
    router_0
    (
        .clk(clk), .reset(reset), .polarity(node0Polarity),
        .cwsi(cws3), .cwri(cwr3), .cwdi(cwd3),
        .ccwsi(ccws1), .ccwri(ccwr1), .ccwdi(ccwd1),
        .pesi(node0Pesi), .peri(node0Peri), .pedi(node0Pedi),
        .cwso(cws0), .cwro(cwr0), .cwdo(cwd0),
        .ccwso(ccws0), .ccwro(ccwr0), .ccwdo(ccwd0),
        .peso(node0Peso), .pero(node0Pero), .pedo(node0Pedo)
    );

    cardinal_router #(
        .PACKET_SIZE(PACKET_SIZE)
    )
    router_1
    (
        .clk(clk), .reset(reset), .polarity(node1Polarity),
        .cwsi(cws0), .cwri(cwr0), .cwdi(cwd0),
        .ccwsi(ccws2), .ccwri(ccwr2), .ccwdi(ccwd2),
        .pesi(node1Pesi), .peri(node1Peri), .pedi(node1Pedi),
        .cwso(cws1), .cwro(cwr1), .cwdo(cwd1),
        .ccwso(ccws1), .ccwro(ccwr1), .ccwdo(ccwd1),
        .peso(node1Peso), .pero(node1Pero), .pedo(node1Pedo)
    );

    cardinal_router #(
        .PACKET_SIZE(PACKET_SIZE)
    )
    router_2
    (
        .clk(clk), .reset(reset), .polarity(node2Polarity),
        .cwsi(cws1), .cwri(cwr1), .cwdi(cwd1),
        .ccwsi(ccws3), .ccwri(ccwr3), .ccwdi(ccwd3),
        .pesi(node2Pesi), .peri(node2Peri), .pedi(node2Pedi),
        .cwso(cws2), .cwro(cwr2), .cwdo(cwd2),
        .ccwso(ccws2), .ccwro(ccwr2), .ccwdo(ccwd2),
        .peso(node2Peso), .pero(node2Pero), .pedo(node2Pedo)
    );

    cardinal_router #(
        .PACKET_SIZE(PACKET_SIZE)
    )
    router_3
    (
        .clk(clk), .reset(reset), .polarity(node3Polarity),
        .cwsi(cws2), .cwri(cwr2), .cwdi(cwd2),
        .ccwsi(ccws0), .ccwri(ccwr0), .ccwdi(ccwd0),
        .pesi(node3Pesi), .peri(node3Peri), .pedi(node3Pedi),
        .cwso(cws3), .cwro(cwr3), .cwdo(cwd3),
        .ccwso(ccws3), .ccwro(ccwr3), .ccwdo(ccwd3),
        .peso(node3Peso), .pero(node3Pero), .pedo(node3Pedo)
    );
//----------------------------------------------------------------------------------------------------------------------- 

endmodule