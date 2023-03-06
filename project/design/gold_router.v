module gold_router #(
    parameter PACKET_SIZE = 64;
) (
    input clk, reset, polarity,

    input cwsi,                             // Clockwise input send 
    output reg cwri,                        // Clockwise input receive
    input [PACKET_SIZE-1:0] cwd,            // Clockwise input data 

    input ccwsi,                            // Counter-clockwise input send
    output reg ccwri,                       // Counter-clockwise input receive
    input [PACKET_SIZE-1:0] ccwd,           // Counter-clockwise input data

    input pesi,                             // Processing element input send
    output reg peri,                        // Processing element input receive
    input [PACKET_SIZE-1:0] ped,            // Processing element input data

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
    
endmodule