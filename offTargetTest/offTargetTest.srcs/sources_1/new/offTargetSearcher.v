`timescale 1ns / 1ps

module offTargetSearcher #(
    parameter BIG_SEQ_SIZE = 4000,
    parameter OUTER_LOCATION_NUM_SIZE = 12,
    parameter SMALL_SEQ_SIZE = 80,
    parameter INNER_LOCATION_NUM_SIZE = 7,
    parameter OFF_TARGET_LIMIT = 4,
//    parameter PAM_SEQUENCE = 8'b00100010, //PAM Sequence - binary of GG
    parameter   IDLE = 7'b0000001,
                INPUT = 7'b0000010,
                START_SEARCH = 7'b0000100,
                CHECK_CHUNK = 7'b0001000,
                HANDLE_CHUNK_RES = 7'b0010000,
                GET_CHUNK = 7'b0100000,
                COMPLETE = 7'b1000000
)
(
    input CLK,
    input RST,
    input START,
    
    input [BIG_SEQ_SIZE - 1 : 0] bigSeq,
    input [OUTER_LOCATION_NUM_SIZE - 1 : 0] startIndex,
    input [SMALL_SEQ_SIZE - 1 : 0] smallSeq,
    
    output reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] location,
    output reg found,
    output reg DONE

    );

                
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] indexStart;
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] pos;
    reg [OUTER_LOCATION_NUM_SIZE - 1 : 0] foundSeqPosStart;
    reg [INNER_LOCATION_NUM_SIZE - 1 : 0] innerChunkPos;
    reg [BIG_SEQ_SIZE-1 : 0] seqBig;
    reg [SMALL_SEQ_SIZE - 1 : 0] seqSmall;
    reg [6 : 0] state;
    reg [5 : 0] offTargetCount;
    
    reg matchFound;
    
    reg [15 : 0] outerChunk;
    reg [15 : 0] firstInnerChunk;
    reg [15 : 0] innerChunk;
    
    always @ (*)
    begin
        location <= foundSeqPosStart;
        found <= matchFound;
    end
    
    task compareChunks;
        input [15 : 0] chunk1, chunk2;
        output chunksMatch;
        reg [3 : 0] bpl1, bpl2, bpl3, bpl4, bpr1, bpr2, bpr3, bpr4;
        reg bp1Match, bp2Match, bp3Match, bp4Match;
        reg [2 : 0] tmpOffTargetCount;
        begin
            tmpOffTargetCount = 0;
            bpl1 = {chunk1[15], chunk1[14], chunk1[13], chunk1[12]};
            bpl2 = {chunk1[11], chunk1[10], chunk1[9], chunk1[8]};
            bpl3 = {chunk1[7], chunk1[6], chunk1[5], chunk1[4]};
            bpl4 = {chunk1[3], chunk1[2], chunk1[1], chunk1[0]};
            
            bpr1 = {chunk2[15], chunk2[14], chunk2[13], chunk2[12]};
            bpr2 = {chunk2[11], chunk2[10], chunk2[9], chunk2[8]};
            bpr3 = {chunk2[7], chunk2[6], chunk2[5], chunk2[4]};
            bpr4 = {chunk2[3], chunk2[2], chunk2[1], chunk2[0]};
            
            bp1Match = (((bpl1[3] & bpr1[3]) | (bpl1[2] & bpr1[2]) | (bpl1[1] & bpr1[1]) | (bpl1[0] & bpr1[0])) | bpl1 == bpr1);
            bp2Match = (((bpl2[3] & bpr2[3]) | (bpl2[2] & bpr2[2]) | (bpl2[1] & bpr2[1]) | (bpl2[0] & bpr2[0])) | bpl2 == bpr2);
            bp3Match = (((bpl3[3] & bpr3[3]) | (bpl3[2] & bpr3[2]) | (bpl3[1] & bpr3[1]) | (bpl3[0] & bpr3[0])) | bpl3 == bpr3);
            bp4Match = (((bpl4[3] & bpr4[3]) | (bpl4[2] & bpr4[2]) | (bpl4[1] & bpr4[1]) | (bpl4[0] & bpr4[0])) | bpl4 == bpr4);
            tmpOffTargetCount = (bp1Match == 1'b0) + (bp2Match == 1'b0) + (bp3Match == 1'b0) + (bp4Match == 1'b0);
            
            if (tmpOffTargetCount == 4)begin
                chunksMatch = 1'b0;            
            end
            else begin
                if (offTargetCount + tmpOffTargetCount >= 10) begin
                    chunksMatch = 1'b0;
                end
                else begin
                    offTargetCount = offTargetCount + tmpOffTargetCount;
                    chunksMatch = 1'b1;
                end
            end
        end
    endtask
    
    always @ (posedge CLK) 
    begin
        if (RST == 1'b0) begin
            pos <= 0;
            foundSeqPosStart <= 0;
            DONE <= 1'b0;
            state <= IDLE;
            matchFound <= 1'b0;
            innerChunkPos <= 79;
            offTargetCount <= 0;
        end else begin
            case (state)
                IDLE : begin
                        pos <= 0;
                        innerChunkPos <= 79;
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        if (START == 1'b0) begin
                            state <= INPUT;
                        end
                    end
                INPUT : begin
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        indexStart <=  startIndex;
                        seqBig <= bigSeq;
                        seqSmall <= smallSeq;
                        innerChunkPos <= 79;
                        firstInnerChunk <= {smallSeq[79], smallSeq[78], smallSeq[77], smallSeq[76], smallSeq[75], smallSeq[74], smallSeq[73], smallSeq[72], smallSeq[71], smallSeq[70], smallSeq[69], smallSeq[68], smallSeq[67], smallSeq[66], smallSeq[65], smallSeq[64]};
                        pos <= startIndex;
                        state <= START_SEARCH;
                    end
                START_SEARCH : begin
                        DONE <= 1'b0;
                        matchFound <= 1'b0;
                        offTargetCount <= 0;
                        if (pos >= 79) begin
                            foundSeqPosStart <= pos;
                            outerChunk <= {seqBig[pos], seqBig[pos-1], seqBig[pos-2], seqBig[pos-3], seqBig[pos-4], seqBig[pos-5], seqBig[pos-6], seqBig[pos-7], seqBig[pos-8], seqBig[pos-9], seqBig[pos-10], seqBig[pos-11], seqBig[pos-12], seqBig[pos-13], seqBig[pos-14], seqBig[pos-15]};
                            innerChunk <= firstInnerChunk;
                            innerChunkPos <= 79;
                            state <= CHECK_CHUNK;
                        end else begin
                            state <= COMPLETE;
                        end
                    end
                CHECK_CHUNK : begin
                        DONE <= 1'b0;
                        compareChunks(outerChunk, innerChunk, matchFound);
                        state <= HANDLE_CHUNK_RES;
                    end
                HANDLE_CHUNK_RES : begin
                    DONE <= 1'b0;
                    if (matchFound == 1'b1) begin
                        if (innerChunkPos == 15) begin
                            state <= COMPLETE;
                        end 
                        else begin
                            pos <= pos - 16;
                            innerChunkPos <= innerChunkPos - 16;
                            state <= GET_CHUNK;
                        end
                    end
                    else
                    begin
                        pos <= foundSeqPosStart - 4;
                        state <= START_SEARCH;
                    end
                end
                GET_CHUNK : begin
                        DONE <= 1'b0;
                        outerChunk <= {seqBig[pos], seqBig[pos-1], seqBig[pos-2], seqBig[pos-3], seqBig[pos-4], seqBig[pos-5], seqBig[pos-6], seqBig[pos-7], seqBig[pos-8], seqBig[pos-9], seqBig[pos-10], seqBig[pos-11], seqBig[pos-12], seqBig[pos-13], seqBig[pos-14], seqBig[pos-15]};
                        innerChunk <= {seqSmall[innerChunkPos], seqSmall[innerChunkPos-1], seqSmall[innerChunkPos-2], seqSmall[innerChunkPos-3], seqSmall[innerChunkPos-4], seqSmall[innerChunkPos-5], seqSmall[innerChunkPos-6], seqSmall[innerChunkPos-7], seqSmall[innerChunkPos-8], seqSmall[innerChunkPos-9], seqSmall[innerChunkPos-10], seqSmall[innerChunkPos-11], seqSmall[innerChunkPos-12], seqSmall[innerChunkPos-13], seqSmall[innerChunkPos-14], seqSmall[innerChunkPos-15]};
                        state <= CHECK_CHUNK;
                    end
                COMPLETE : begin
                        DONE <= 1'b1;
                        if (START == 1'b0) begin
                            state <= INPUT;
                        end
                    end
                default : state <= #1 IDLE;
            endcase
        end
    end
endmodule