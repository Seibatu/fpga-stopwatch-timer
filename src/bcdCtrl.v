`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seiba
// 
// Create Date: 14.02.2025 14:39:24
// Design Name: 
// Module Name: bcdCtrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
/*
    This module converts the **binary counter value** into **BCD format** for compatibility with the 7-segment display.

    Features
        - Converts binary input into two-digit BCD output
        - Supports up to 99 decimal conversion
        - Essential for displaying the numeric values

    Usage
        Connect the binary counter output to this module to get a BCD representation for display.
*/ 
// Dependencies: 
    // Used by `topModule.v` (Top-level module)
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcdCtrl(
    input [6:0] cnt_out,
    output reg [14:0] number
    );
    
    integer i;
    
    // Convert count value to BCD using shift-and-add-3 algorithm
    always @(*) begin
        number = 15'b0;
        number[6:0] = cnt_out; // Load binary count
    
        for (i = 0; i < 7; i = i + 1) begin
            // Adjust BCD digits if needed
            if (number[10:7] >= 5) 
                number[10:7] = number[10:7] + 3;
            if (number[14:11] >= 5) 
                number[14:11] = number[14:11] + 3;
            
            // Shift left
            number = number << 1;
        end
    end

endmodule
