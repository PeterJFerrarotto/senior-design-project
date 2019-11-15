`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2018 01:34:53 PM
// Design Name: 
// Module Name: PAMSearcher
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


module PAMSearcher(
    input clk,
    input rst,
    input start,
    input [1999:0] bigSeq,
    input [11:0] PAMSeq,
    input [10:0] startIndex,
    output [10:0] location,
    output done,
    output found,
    output [6 : 0] state
    );
    
    DNASearcher # (
        .BIG_SEQ_SIZE(2000),
        .SMALL_SEQ_SIZE(12),
        .OUTER_LOCATION_NUM_SIZE(11),
        .INNER_LOCATION_NUM_SIZE(3)
        )
    pSearch(
        .CLK(clk),
        .RST(rst),
        .START(start),
        .bigSeq(bigSeq),
        .smallSeq(PAMSeq),
        .startIndex(startIndex),
        .currState(state),
        .location(location),
        .found(found),
        .DONE(done)
    );
        
endmodule
