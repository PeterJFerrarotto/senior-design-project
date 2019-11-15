`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2018 12:55:58 PM
// Design Name: 
// Module Name: BasePairComparator
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


module BasePairComparator(
    input [3:0] bp1,
    input [3:0] bp2,
    output reg exactMatch,
    output reg equal
    );
    
    always @*
    begin
        if (bp1 == bp2)
        begin
            exactMatch <= 1;
            equal <= 1;
        end else if ((bp1[3] && bp2[3]) || (bp1[2] && bp2[2]) || (bp1[1] && bp2[1]) || (bp1[0] && bp2[0])) begin
            exactMatch <= 0;
            equal <= 1;
        end else
        begin
            exactMatch <= 0;
            equal <= 0;
        end
    end
endmodule
