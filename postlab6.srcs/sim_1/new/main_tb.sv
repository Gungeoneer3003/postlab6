`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 11:43:38 AM
// Design Name: 
// Module Name: main_tb
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


module main_tb();
    logic [7:0] sA;
    logic [7:0] sB;
    logic [1:0] sCONTROL;
    logic [7:0] sQ;
    
    main UUT (
        .A(sA),
        .B(sB),
        .CONTROL(sCONTROL),
        .Q(sQ)
    );
    
    task simulate(
        input logic [7:0] inA,
        input logic [7:0] inB,
        input logic [1:0] inCONTROL
     );
        sA = inA;
        sB = inB;
        sCONTROL = inCONTROL;
        
        #10;
    endtask
    
    
    int max = 2**8;    
    
    initial begin 
        for(int i = 0; i < max; i++) begin 
            for(int j = 0; j < max; j++) begin
                for(int k = 0; k < 4; k++) begin
                    simulate(i[7:0], j[7:0], k[1:0]);
                end
            end
        end
    end     
endmodule
