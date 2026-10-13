`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2026 08:16:17 AM
// Design Name: 
// Module Name: q2
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


module q2(
    input logic clk100MHz,
    input logic S,
    input logic [7:0] A, 
    input logic [7:0] B,
    input logic [1:0] SEL,
           
    output logic [7:0] Q,
    output logic [6:0] seg,
    output logic [3:0] an
    );
    
    logic [7:0] sd; //represents selected_data
    
    muxTwo m0 (
        .A(A),
        .B(B),
        .SEL(Q[0]),
        .Y(sd)
    );
    
    logic [3:0][7:0] arr;
    
    dataProcessor dp (
        .I_0(sd),
        .I_1(Q),
        .A(arr[0]),
        .B(arr[1]),
        .C(arr[2]),
        .D(arr[3])
    );
    
    logic [7:0] data;
    
    muxFour m1 (
        .A(arr[0]),
        .B(arr[1]),
        .C(arr[2]),
        .D(arr[3]),
        .SEL(SEL),
        .Y(data)
    );
   
   
   dFlipFlop ff0 (
      .clk100MHz(clk100MHz),
      .A(data),
      .S(S),
      .Q(Q)
   );   
   
   logic [3:0] q_0;
   logic [3:0] q_1;
   
   
   localparam int unsigned DISPLAY_SCAN_BIT = 16;
   logic [DISPLAY_SCAN_BIT:0] displayCounter;
   
   assign q_0 = Q[3:0];
   assign q_1 = Q[7:4];
   logic [6:0] disp0;
   logic [6:0] disp1;
   
   ssdmodule ssd0 (
        .sum(q_0),
        .seg(disp0)
   );
   
   ssdmodule ssd1 (
        .sum(q_1),
        .seg(disp1)
   );
   
   
   always_ff @(posedge clk100MHz or posedge S) begin
        if (S)
            displayCounter <= '0;
        else
            displayCounter <= displayCounter + 1'b1;
   end   
   
   always_comb begin 
        an = 4'b1111;
        seg = 7'b1111111;
        
        if (displayCounter[DISPLAY_SCAN_BIT]) 
            begin
                an = 4'b1101;
                seg = disp1;
            end
        else 
            begin
                an = 4'b1110;
                seg = disp0;
            end
    end
             
endmodule
