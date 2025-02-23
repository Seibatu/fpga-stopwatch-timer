`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seiba
// 
// Create Date: 09.02.2025 11:22:55
// Design Name: 
// Module Name: topModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:   
/*
       This is the top-level module for the Stopwatch Timer. It integrates all sub-modules, 
       including the counter, binary-to-BCD conversion, and 7-segment display driver.
    
       Usage
       Ensure all required modules are included in your Verilog project before simulating or synthesizing.
*/
// Dependencies: 
/*
      - `counterCtrl.v` (Counter logic)
      - `bcdCtrl.v` (Binary to BCD conversion)
      - `sevenSegment.v` (7-segment display driver)
*/
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cheggQ20 (
    input clk,
    input go,
    input clr,
    output wire [7:0] seg_7_display,
    output wire [7:0] active_low_anode
);

    wire [6:0] cnt_out;
    wire [14:0] number; 

    // Instantiation of counter control unit 
    counterCtrl ctrl_unit (
                            .clk(clk), 
                            .go(go),
                            .clr(clr),
                            .cnt_out(cnt_out)
                           );

    // Instantiation of BCD control unit 
    bcdCtrl bcd_ctrl_unit (
                            .cnt_out(cnt_out),
                            .number(number)
                           );
    
    // Instantiation of seven segment control unit 
    sevenSegment dsp_unit (
                            .clk(clk),
                            .clr(clr),
                            .number(number),
                            .seg_7_display(seg_7_display),
                            .active_low_anode(active_low_anode)
                           );

endmodule
