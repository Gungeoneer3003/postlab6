`timescale 1ns / 1ps

module main_tb;
    // These values make the divider fast enough for behavioral simulation
    localparam int unsigned INPUT_WIDTH = 7;
    localparam int unsigned SIM_HALF_PERIOD = 2;
    localparam int unsigned RESET_CLOCK_EDGES = 2;
    localparam time CLOCK_HALF_PERIOD = 5ns;
    localparam time CHECK_DELAY = 1ns;
    localparam int unsigned INPUT_COUNT = 2 ** INPUT_WIDTH;

    logic [INPUT_WIDTH - 1:0] sA;
    logic sS;
    logic [INPUT_WIDTH - 1:0] sQ;
    logic clk100MHz;

    // Generates a 100 MHz input clock from the 1 ns simulation timescale
    initial begin
        clk100MHz = 1'b0;

        forever #CLOCK_HALF_PERIOD clk100MHz = ~clk100MHz;
    end

    // Uses a short divided-clock period so each input can be checked quickly
    q1 #(
        .HALF_PERIOD(SIM_HALF_PERIOD)
    ) UUT (
        .A(sA),
        .S(sS),
        .Q(sQ),
        .clk100MHz(clk100MHz)
    );

    // Resets the design, then verifies every possible seven-bit input value
    initial begin
        sS = 1'b1;
        sA = '0;

        #CHECK_DELAY;
        if (sQ !== '0) begin
            $fatal(1, "Reset failed: Q is %0h instead of 0", sQ);
        end

        // Keep reset active across input-clock edges for the divider
        repeat (RESET_CLOCK_EDGES) @(posedge clk100MHz);
        #CHECK_DELAY;
        sS = 1'b0;

        for (int i = 0; i < INPUT_COUNT; i++) begin
            sA = i[INPUT_WIDTH - 1:0];

            // Q updates only at the rising edge of the divided clock
            @(posedge UUT.slowClk);
            #CHECK_DELAY;

            if (sQ !== sA) begin
                $fatal(1, "Capture failed: A=%0h, Q=%0h", sA, sQ);
            end
        end

        $display("PASS: verified %0d input values", INPUT_COUNT);
        $finish;
    end
endmodule
