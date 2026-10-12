`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2026 08:13:10 AM
// Design Name: 
// Module Name: q1
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


module q1 #(
    // Hardware divider value; testbenches may override this for fast runs
    parameter int unsigned HALF_PERIOD = 5 * 10 ** 7
) (
    input logic clk100MHz,
    input logic [6:0] A, 
    input logic S, 
    output logic [6:0] Q
    );
    
    logic slowClk;
    
    slowClock #(
        .HALF_PERIOD(HALF_PERIOD)
    ) clockGen (
        .clk100MHz  (clk100MHz),
        .rst        (S),
        .slowClk    (slowClk)
    );
   
    always_ff @(posedge slowClk or posedge S) begin 
        if(S)
            Q <= '0;
        else
            Q <= A;
    end
endmodule
