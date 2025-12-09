// Testbench Program for Digital Finite Impulse Response (Dual) Low pass and High Pass Filters

`timescale 1ns/1ps

module digital_fir_flt_tb;

    reg clk, reset, mode;             // mode=0 LP, mode=1 HP
    reg  signed [15:0] x_in;
    wire signed [31:0] y_out;

    // Instantiate
    digital_fir_flt dut (.clk(clk), .reset(reset), .mode(mode), .x_in(x_in), .y_out(y_out));

    always #5 clk = ~clk; // clock

    initial begin
        $dumpfile("digital_fir_flt_tb.vcd");
        $dumpvars(0, digital_fir_flt_tb);

        clk = 0;
        reset = 1;
        mode = 0;
        x_in = 0;

        #20 reset = 0;

        // LOW PASS TEST
        mode = 0;
        $display("");
        $display("LOW PASS RESPONSE:");

        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 0;    #10;
        x_in = 0;    #50;

        // HIGH PASS TEST
        mode = 1;
        $display("");
        $display("HIGH PASS RESPONSE: ");

        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 2000; #10;
        x_in = 0;    #10;
        x_in = 0;    #50;

        $stop;
    end

    always @(posedge clk)
        $display("t=%0t mode=%0d x_in=%d y_out=%d", $time, mode, x_in, y_out);

endmodule
