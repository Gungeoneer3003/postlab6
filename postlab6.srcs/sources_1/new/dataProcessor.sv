`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2026 04:24:02 PM
// Design Name: 
// Module Name: dataProcessor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dataProcessor(
    input logic [7:0] I_0, I_1,
    output logic [7:0] A, B, C, D
    );
    
    assign A = I_0 + I_1;
    assign B = I_0 - I_1;
    assign C = I_1;
    assign D = 8'b00000000;
    
endmodule
