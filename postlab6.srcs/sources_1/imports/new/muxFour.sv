`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2026 01:24:48 PM
// Design Name: 
// Module Name: mux4
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


module muxFour (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [7:0] C,
    input  logic [7:0] D,
    input  logic [1:0] SEL,
    output logic [7:0] Y
    );
    
    always_comb begin
        case(SEL)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = D;
            default: Y = A;
        endcase
    end
endmodule

