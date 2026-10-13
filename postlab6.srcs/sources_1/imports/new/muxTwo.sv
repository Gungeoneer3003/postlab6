`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2026 01:24:48 PM
// Design Name: 
// Module Name: mux2
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


module muxTwo ( 
    input logic [7:0] A,
    input  logic [7:0] B,

    input  logic SEL,
    output logic [7:0] Y
    );
    
    always_comb begin
        case(SEL)
            2'b00: Y = A;
            2'b01: Y = B;
            default: Y = A;
        endcase
    end
endmodule
