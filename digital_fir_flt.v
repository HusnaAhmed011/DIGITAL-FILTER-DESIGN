// Design Program for Digital Finite Impulse Response (Dual) Low pass and High Pass Filters

module digital_fir_flt(
    input clk,
    input reset,
    input mode,        // 0 = low-pass, 1 = high-pass
    input signed [15:0] x_in,
    output reg signed [31:0] y_out
);

    // Delay samples
    reg signed [15:0] x_reg [0:7];

    // LP coefficients
    wire signed [15:0] lp [0:7];
    assign lp[0] = 16'sd1475;  assign lp[1] = 16'sd2950;
    assign lp[2] = 16'sd4915;  assign lp[3] = 16'sd7032;
    assign lp[4] = 16'sd7032;  assign lp[5] = 16'sd4915;
    assign lp[6] = 16'sd2950;  assign lp[7] = 16'sd1475;

    // HP coefficients
    wire signed [15:0] hp [0:7];
    assign hp[0] = -16'sd1475; assign hp[1] = -16'sd2950;
    assign hp[2] = -16'sd4915; assign hp[3] =  16'sd25742;
    assign hp[4] =  16'sd25742; assign hp[5] = -16'sd4915;
    assign hp[6] = -16'sd2950; assign hp[7] = -16'sd1475;

    // Multipliers
    wire signed [31:0] mult [0:7];
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : mul_block
            assign mult[i] = x_reg[i] * (mode ? hp[i] : lp[i]);
        end
    endgenerate

    reg signed [31:0] acc;
    integer k;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (k = 0; k < 8; k = k + 1)
                x_reg[k] <= 0;
            y_out <= 0;
            acc <= 0;
        end 
        else begin
            // shift register
            for (k = 7; k > 0; k = k-1)
                x_reg[k] <= x_reg[k-1];
            x_reg[0] <= x_in;

            // sum products
            acc <= mult[0] + mult[1] + mult[2] + mult[3] + mult[4] + mult[5] + mult[6] + mult[7];

            // scale back to Q15
            y_out <= acc >>> 15;
        end
    end

endmodule
