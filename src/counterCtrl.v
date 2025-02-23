`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seiba
// 
// Create Date: 14.02.2025 14:30:04
// Design Name: 
// Module Name: counterCtrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
/*
    This module implements the **counting logic** for the stopwatch. It increments every second and wraps around at 99.

    Features
    - Supports **enable (`go`)** and **reset (`clr`)** signals
    - Increments from 00 to 99 and wraps around

    Usage
      Instantiate this module within a higher-level design and provide the appropriate clock and control signals.

*/
// Dependencies: 
    // Used by `topModule.v` (Top-level module)
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counterCtrl #(parameter integer n = 100_000_000)(
    input clk, // 100MHz 
    input go,
    input clr,
    output reg [6:0] cnt_out
);

    // 1st == 1khz -- 99m, 2nd == 10hz -- 9.9s
    // 1 min == 60s -- 6
    reg [$clog2(n/2)-1:0] cnt_tmp;
    reg slw_clk;
    
    // Generate 1sec slow clock for counting
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            cnt_tmp <= 0;
            slw_clk <= 0;
        end
        else if (cnt_tmp == (n/2)-1) begin
            slw_clk <= ~slw_clk;
            cnt_tmp <= 0;
        end
        else cnt_tmp <= cnt_tmp + 1;
    end
    
    // Increment count on slow clock
    always @(posedge slw_clk or posedge clr) begin
        if (clr)
            cnt_out <= 0;
        else if (go)
            cnt_out <= (cnt_out == 99) ? 0 : cnt_out + 1; // Reset after 99 (BCD limit)
    end

endmodule 
