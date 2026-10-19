`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 11:38:15 AM
// Design Name: 
// Module Name: q2_tb
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

module q2_tb;

    logic clk100MHz;
    logic S;
    logic [7:0] A;
    logic [7:0] B;
    logic [1:0] SEL;

    logic [7:0] Q;
    logic [6:0] seg;
    logic [3:0] an;

    q2 UUT (
        .clk100MHz(clk100MHz),
        .S(S),
        .A(A),
        .B(B),
        .SEL(SEL),
        .Q(Q),
        .seg(seg),
        .an(an)
    );

    initial begin
        clk100MHz = 1'b0;
        forever #5 clk100MHz = ~clk100MHz;
    end

    task automatic test_operation(
        input logic [1:0] operation,
        input logic [7:0] input_A,
        input logic [7:0] input_B
    );
        logic [7:0] old_Q;
        logic [7:0] selected_data;
        logic [7:0] expected_Q;

        begin
            @(negedge clk100MHz);

            old_Q = Q;
            A = input_A;
            B = input_B;
            SEL = operation;

            if (old_Q[0] == 1'b0)
                selected_data = input_A;
            else
                selected_data = input_B;

            case (operation)
                2'b00: expected_Q = old_Q + selected_data;
                2'b01: expected_Q = selected_data - old_Q;
                2'b10: expected_Q = old_Q;
                2'b11: expected_Q = 8'h00;
                default: expected_Q = 8'hxx;
            endcase

            @(posedge UUT.ff0.slowClk);
            #1;

            if (Q !== expected_Q)
                $fatal(1, "Failed: SEL=%b expected Q=%02h, got Q=%02h",
                       operation, expected_Q, Q);

            $display("Passed: SEL=%b, Q=%02h", operation, Q);
        end
    endtask

    initial begin
        force UUT.ff0.slowClk = clk100MHz;

        S = 1'b1;
        A = 8'h00;
        B = 8'h00;
        SEL = 2'b00;

        @(posedge UUT.ff0.slowClk);
        #1;

        if (Q !== 8'h00)
            $fatal(1, "Reset failed: Q=%02h", Q);

        @(negedge clk100MHz);
        S = 1'b0;

        test_operation(2'b00, 8'h05, 8'h33);
        test_operation(2'b00, 8'h22, 8'h03);
        test_operation(2'b01, 8'h02, 8'h17);
        test_operation(2'b10, 8'hFF, 8'hFF);
        test_operation(2'b11, 8'hAA, 8'h55);
        test_operation(2'b00, 8'h01, 8'h00);
        test_operation(2'b01, 8'h20, 8'h03);

        $display("All q2 test cases passed.");
        $finish;
    end

endmodule