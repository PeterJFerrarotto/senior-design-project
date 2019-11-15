`timescale 1ns / 1ps

module DNASearcher #(
    parameter BIG_SEQ_SIZE = 32,
    parameter SMALL_SEQ_SIZE = 8,
    parameter OUTER_LOCATION_NUM_SIZE = 5,
    parameter INNER_LOCATION_NUM_SIZE = 3,
    parameter   IDLE = 7'b0000001,
                INPUT = 7'b0000010,
                START_SEARCH = 7'b0000100,
                SEARCH = 7'b0001000,
                START_CHECK_SEQ = 7'b0010000,
                CHECK_SEQ = 7'b0100000,
                COMPLETE = 7'b1000000
)
(
    input CLK,
    input RST,
    input START,
    
    input [BIG_SEQ_SIZE - 1 : 0] bigSeq,
    input [SMALL_SEQ_SIZE - 1 : 0] smallSeq,
    input [OUTER_LOCATION_NUM_SIZE - 1 : 0] startIndex,
    
    output reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] location,
    output reg found,
    output reg DONE

    );

                
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] indexStart;
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] pos;
    reg [INNER_LOCATION_NUM_SIZE - 1 : 0] innerPos;
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] outerPos;
    reg [BIG_SEQ_SIZE-1 : 0] seqBig;
    reg [SMALL_SEQ_SIZE-1 : 0] seqSmall;
    reg [7 : 0] state;
    reg [3 : 0] firstBP;
    
    reg matchFound;
    
    reg [3 : 0] currOuterBP;
    
    reg [3:0] bp1;
    reg [3:0] bp2;
    
    always @ (posedge CLK) begin : finder
        location <= pos;
        found <= matchFound;
        if (RST == 1'b0) begin
            DONE <= 1'b0;
            state <= IDLE;
            matchFound <= 1'b0;
        end else begin
            case (state)
                IDLE : begin
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        if (START == 1'b1) begin
                            state <= INPUT;
                        end
                    end
                INPUT : begin
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        indexStart <=  startIndex;
                        seqSmall <= smallSeq;
                        seqBig <= bigSeq;
                        firstBP <= {smallSeq[SMALL_SEQ_SIZE - 1] , smallSeq[SMALL_SEQ_SIZE - 2], smallSeq[SMALL_SEQ_SIZE - 3], smallSeq[SMALL_SEQ_SIZE - 4]};
                        pos <= startIndex;
                        state <= START_SEARCH;
                    end
                START_SEARCH : begin
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        if (pos >= SMALL_SEQ_SIZE - 1) begin
                            currOuterBP <= {seqBig[pos], seqBig[pos-1], seqBig[pos-2], seqBig[pos-3]};
                            state <= SEARCH;
                        end else begin
                            state <= COMPLETE;
                        end
                    end
                SEARCH : begin
                        DONE <= 1'b0;
                        if (currOuterBP == firstBP || ((currOuterBP[3] && firstBP[3]) || (currOuterBP[2] && firstBP[2]) || (currOuterBP[1] && firstBP[1]) || (currOuterBP[0] && firstBP[0]))) begin
                            matchFound <= 1'b1;
                            outerPos <= pos - 4;
                            innerPos <= SMALL_SEQ_SIZE - 5;
                            state <= START_CHECK_SEQ;
                        end else begin
                            matchFound <= 1'b0;
                            pos <= pos - 4;
                            state <= START_SEARCH;
                        end
                    end
                START_CHECK_SEQ : begin
                        DONE <= 1'b0;
                        if (matchFound == 1'b1) begin
                            if (innerPos >= 3) begin
                                bp1 <= {seqBig[outerPos], seqBig[outerPos-1], seqBig[outerPos-2], seqBig[outerPos-3]};
                                bp2 <= {seqSmall[innerPos], seqSmall[innerPos-1], seqSmall[innerPos-2], seqSmall[innerPos-3]};
                                state <= CHECK_SEQ;
                            end else begin
                                state <= COMPLETE;
                            end
                        end else begin
                            pos <= pos - 4;
                            state <= START_SEARCH;
                        end
                    end
                CHECK_SEQ : begin
                        DONE <= 1'b0;
                        if (bp1 == bp2 || ((bp1[3] && bp2[3]) || (bp1[2] && bp2[2]) || (bp1[1] && bp2[1]) || (bp1[0] && bp2[0]))) begin
                            outerPos <= outerPos - 4;
                            innerPos <= innerPos - 4;
                        end else begin
                            matchFound <= 1'b0;
                        end
                        state <= START_CHECK_SEQ;
                    end
                COMPLETE : begin
                        DONE <= #1 1'b1;
                        if (START == 1'b1) begin
                            state <= INPUT;
                        end
                    end
                default : state <= #1 IDLE;
            endcase
        end
    end
endmodule
