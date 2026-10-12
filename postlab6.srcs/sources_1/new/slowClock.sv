`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2026 08:48:50 AM
// Design Name: 
// Module Name: slowClock
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


module slowClock#(
        parameter int unsigned HALF_PERIOD = 5 * 10 ** 7
    ) (
        input logic clk100MHz,
        input logic rst,
        output logic slowClk
    );
    
    localparam int unsigned COUNT_WIDTH = $clog2(HALF_PERIOD);
    logic [COUNT_WIDTH - 1:0] count;
    
    always_ff @(posedge clk100MHz or posedge rst) begin 
        if (rst) 
            begin 
                count <= '0;
                slowClk <= 1'b0;
            end 
        else if (count == HALF_PERIOD - 1)
            begin
                count <= '0;
                slowClk <= ~slowClk;
            end
        else 
            begin
                count <= count + 1'b1;
            end
    end
        
endmodule
