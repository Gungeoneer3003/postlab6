`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 11:34:16 AM
// Design Name: 
// Module Name: main
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


module main(
    input logic [7:0] A, 
    input logic [7:0] B,
    input logic SEL,        //Note: this should be replaced with Q[0]
    input logic [1:0] CONTROL,
    output logic [7:0] Q
    );
    
    assign Q = A & B;
    
endmodule
