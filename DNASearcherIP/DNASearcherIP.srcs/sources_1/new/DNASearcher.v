`timescale 1ns / 1ps

module DNASearcher(
    input CLK,
    input RST,
    input START,
    input [1999 : 0] bigSeq,
    input [11 : 0] smallSeq,
    input [10 : 0] startIndex,
    output reg [10 : 0] location,
    output reg found,
    output reg DONE

    );
    parameter   IDLE = 5'b00001,
                INPUT = 5'b00010,
                SEARCH = 5'b00100,
                CHECK_SEQ = 5'b01000,
                COMPLETE = 5'b10000;
                
    reg [10 : 0] indexStart;
    reg [1999 : 0] seqBig;
    reg [11 : 0] seqSmall;
    reg [4 : 0] state;
    reg [3 : 0] firstBP;
    
    reg matchFound;
    
    reg [3 : 0] currOuterBP;
    
    reg [3:0] bp1;
    reg [3:0] bp2;
    
    reg [10 : 0] pos;
    reg [10 : 0] outerPos;
    reg [3 : 0] innerPos;
    always @ (posedge CLK) begin : finder
        if (RST == 1'b0) begin
            DONE <= 1'b0;
            state <= #1 IDLE;
            matchFound <= 1'b0;
        end else begin
            case (state)
                IDLE : begin
                    DONE <= 1'b0;
                        matchFound <= 1'b0;
                        if (START == 1'b1) begin
                            state <= #1 INPUT;
                        end
                    end
                INPUT : begin
                    DONE <= 1'b0;
                        matchFound <= 1'b0;
                        indexStart <=  startIndex;
                        seqSmall <= smallSeq;
                        seqBig <= bigSeq;
                        firstBP <= smallSeq[11 : 8];
                        pos <= indexStart;
                        
                        state <= #1 SEARCH;
                    end
                SEARCH : begin
                        DONE <= 1'b0;
                        if (pos < 9) begin
                            matchFound <= 1'b0;
                            state <= #1 COMPLETE;
                        end else begin
                            currOuterBP <= seqBig[pos -:3];
                            if (currOuterBP == firstBP || ((currOuterBP[3] == firstBP[3]) || (currOuterBP[2] == firstBP[2]) || (currOuterBP[1] == firstBP[1]) || (currOuterBP[0] == firstBP[0]))) begin
                                matchFound <= 1'b1;
                                outerPos <= pos - 4;
                                innerPos <= 7;
                                state <= #1 CHECK_SEQ;
                            end else begin
                                pos <= pos - 4;
                            end
                        end
                    end
                CHECK_SEQ : begin
                        if (matchFound == 1'b1) begin
                            if (innerPos > 0) begin
                                bp1 <= seqBig[outerPos -:3];
                                bp2  <= seqSmall[innerPos -:3];
                                if (bp1 == bp2 || ((bp1[3] == bp2[3]) || (bp1[2] == bp2[2]) || (bp1[1] == bp2[1]) || (bp1[0] == bp2[0]))) begin
                                    outerPos <= outerPos - 4;
                                    innerPos <= innerPos - 4;
                                end else begin
                                    matchFound <= 1'b0;
                                end
                            end else begin
                                state <= #1 COMPLETE;
                            end
                        end else begin
                            pos <= pos - 4;
                            state <= #1 SEARCH;
                        end
                    end
                COMPLETE : begin
                        DONE <= #1 1'b1;
                        found <= matchFound;
                        location <= pos;
                        if (START == 1'b1) begin
                            state <= #1 INPUT;
                        end
                    end
                default : state <= #1 IDLE;
            endcase
        end
    end
endmodule
