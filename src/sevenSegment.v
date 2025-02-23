`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seiba 
// 
// Create Date: 14.02.2025 14:28:04
// Design Name: 
// Module Name: sevenSegment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
/*
    This module drives a **7-segment display** to show the stopwatch count in decimal format.

    Features
        - Converts **BCD input** into **7-segment display encoding**
        - Controls digit multiplexing for multi-digit display
        - Ensures proper visualization of the stopwatch count
*/ 
// Dependencies: 
    // Receives input from `bcdCtrl.v` (Binary to BCD Converter)
    // Used by `topModule.v` (Top-level module)
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenSegment #(parameter integer N = 100_000)(
    input clk,
    input clr,
    input [14:0] number,
    output reg [7:0] seg_7_display,
    output reg [7:0] active_low_anode
    );
    
    reg [$clog2(N)-1:0] digit_count;
    reg [2:0] digit_for_display;
    reg [7:0] tmp_val;
    
    // Refresh display digits at 1KHz
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            digit_count <= 0;
            digit_for_display <= 0;
        end
        else if (digit_count == N-1) begin
            digit_for_display <= digit_for_display + 1;
            digit_count <= 0;
        end
        else digit_count <= digit_count + 1;
    end
    
    // Pick the digit to turn on (Multiplexing)
    always @ (*) begin
        case (digit_for_display)
            3'b000 : active_low_anode = 8'b1111_1110; // Display first digit (Ones place)
            3'b001 : active_low_anode = 8'b1111_1101; // Display second digit (Tens place)
            default : active_low_anode = 8'b1111_1111; // All digits off
        endcase
    end
    
    // Assign the corresponding digit to `tmp_val`
    always @ (*) begin
        case (digit_for_display)
            3'b000 : tmp_val = {4'b0000, number[10:7]};  // Ones place
            3'b001 : tmp_val = {4'b0000, number[14:11]}; // Tens place
            default: tmp_val = 8'b0000_0000;             // Default to zero
        endcase
    end
    
    // Assign the segments of the digit (active low segments)
    always @ (posedge clk or posedge clr) begin
        if (clr) 
            seg_7_display <= 8'b1111_1111; // Clear display
        else 
            seg_7_display <= seg_7(tmp_val[3:0]); // Pass only the lower 4 bits
    end 
    
    // Function to convert 4-bit BCD to 7-segment display encoding
    function [7:0] seg_7;
    input [3:0] digit;  // Change input to 4-bit
    begin  
        case (digit)
            4'b0000 : seg_7 = 8'b1100_0000; // 0
            4'b0001 : seg_7 = 8'b1111_1001; // 1
            4'b0010 : seg_7 = 8'b1010_0100; // 2
            4'b0011 : seg_7 = 8'b1011_0000; // 3
            4'b0100 : seg_7 = 8'b1001_1001; // 4
            4'b0101 : seg_7 = 8'b1001_0010; // 5
            4'b0110 : seg_7 = 8'b1000_0010; // 6
            4'b0111 : seg_7 = 8'b1111_1000; // 7
            4'b1000 : seg_7 = 8'b1000_0000; // 8
            4'b1001 : seg_7 = 8'b1001_0000; // 9
            default : seg_7 = 8'b1100_0000; // Default to 0
        endcase
    end
    endfunction
    
endmodule
