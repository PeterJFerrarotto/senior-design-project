//AXI GPIO driver
#include "xgpio.h"
//send data over UART
#include "xil_printf.h"
#include "xil_types.h"
//information about AXI peripherals
#include "xparameters.h"
#include "PmodSD.h"
#include <stdio.h>
#include <stdlib.h>

//
//        .START(slv_reg129[0]),
//        .bigSeq({slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16, slv_reg17, slv_reg18, slv_reg19, slv_reg20, slv_reg21, slv_reg22, slv_reg23, slv_reg24, slv_reg25, slv_reg26, slv_reg27, slv_reg28, slv_reg29, slv_reg30, slv_reg31, slv_reg32, slv_reg33, slv_reg34, slv_reg35, slv_reg36, slv_reg37, slv_reg38, slv_reg39, slv_reg40, slv_reg41, slv_reg42, slv_reg43, slv_reg44, slv_reg45, slv_reg46, slv_reg47, slv_reg48, slv_reg49, slv_reg50, slv_reg51, slv_reg52, slv_reg53, slv_reg54, slv_reg55, slv_reg56, slv_reg57, slv_reg58, slv_reg59, slv_reg60, slv_reg61, slv_reg62, slv_reg63, slv_reg64, slv_reg65, slv_reg66, slv_reg67, slv_reg68, slv_reg69, slv_reg70, slv_reg71, slv_reg72, slv_reg73, slv_reg74, slv_reg75, slv_reg76, slv_reg77, slv_reg78, slv_reg79, slv_reg80, slv_reg81, slv_reg82, slv_reg83, slv_reg84, slv_reg85, slv_reg86, slv_reg87, slv_reg88, slv_reg89, slv_reg90, slv_reg91, slv_reg92, slv_reg93, slv_reg94, slv_reg95, slv_reg96, slv_reg97, slv_reg98, slv_reg99, slv_reg100, slv_reg101, slv_reg102, slv_reg103, slv_reg104, slv_reg105, slv_reg106, slv_reg107, slv_reg108, slv_reg109, slv_reg110, slv_reg111, slv_reg112, slv_reg113, slv_reg114, slv_reg115, slv_reg116, slv_reg117, slv_reg118, slv_reg119, slv_reg120, slv_reg121, slv_reg122, slv_reg123, slv_reg124}),
//        .startIndex(slv_reg128[11 : 0]),
//        .smallSeq({slv_reg125, slv_reg126, slv_reg127[15 : 0]}),
//        .location(LOCATION),
//        .DONE(DONE),
//        .found(FOUND),
//        .finalScore(SCORE)

bool ReadMainSequence(u8 seq[1001], uint segNum);

void ReadBigSequence(u8 seq[501]);

bool ExtractGuide(int index, unsigned count, u8 seq[501], u8 guide[24]);

bool ExtractOffTarget(int index, u8 seq[1001], u8 offTarget[24]);

bool compareNucleotides(u8 n1, u8 n2);

float scoreOffTarget(u8 offTarget[24], u8 guide[24]);

void WriteBigSequence(unsigned long bigSeq, unsigned offset);

void WriteMainSequence(unsigned long mainSeq, unsigned offset);

void WriteGuideSequence(unsigned long guide, unsigned offset);

unsigned TranslateNucleotide(u8 nucleotide);

unsigned long TranslateSequence(u8* sequence, unsigned offset);

int searchDNA(unsigned long startIndex);

int findOffTarget(unsigned long startIndex);

bool inputNextSequenceSegment(u8 seq[1001], uint sequenceNum);

int getOffTargetPosToWrite(u8 seq[1001], uint sequenceNum, int offTargetPos);

int main()
{
	DXSPISDVOL disk(XPAR_PMODSD_0_AXI_LITE_SPI_BASEADDR, XPAR_PMODSD_0_AXI_LITE_SDCS_BASEADDR);


	// the drive to mount the SD volume to.
	// options are: "0:", "1:", "2:", "3:", "4:"
	static const char szDriveNbr[] = "0:";

	//Mount the disk
	DFATFS::fsmount(disk, szDriveNbr, 1);

	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + 129 * 4, 0x1);
	Xil_Out32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + 64 * 4, 0x1);
	xil_printf("Starting...\r\n");

	u8* allSequences[178];
	for (uint i = 0; i < 178; i++)
	{
		printf("Reading main sequence %d\n", i + 1);
		allSequences[i] = (u8*)malloc(1001);
		ReadMainSequence(allSequences[i], i+1);
	}
	u8 seq[501];
	ReadBigSequence(seq);
	unsigned guideCount = 0;
	int pos = 1999 - (21 * 4);
	int nextPos = pos;
//	unsigned mainOffset = 0;
//	do
//	{
//		unsigned long translatedMainSeq = TranslateSequence(mainSeq, mainOffset * 8);
//		printf("0x%32lx", translatedMainSeq);
//		WriteMainSequence(translatedMainSeq, mainOffset);
//		mainOffset++;
//	}while (mainOffset <= 124);

//	xil_printf("Wrote main sequence to registers\r\n");

	unsigned offset = 0;
	do
	{
		unsigned long translatedBigSeq = TranslateSequence(seq, offset * 8);
		WriteBigSequence(translatedBigSeq, offset);
		offset++;
	} while (offset <= 62);

//	xil_printf("Wrote big sequence to registers\r\n");
	u8 guide[24];
	bool viableGuide = false;
	do
	{
		printf("Looking for guide #%d\n", guideCount + 1);
		uint mainSeqSegNum = 0;
		bool writeSuccesful = true;
		unsigned mainOffset = 0;
		do
		{
			unsigned long translatedMainSeq = TranslateSequence(allSequences[0], mainOffset * 8);
//			printf("0x%32lx", translatedMainSeq);
			WriteMainSequence(translatedMainSeq, mainOffset);
			mainOffset++;
		}while (mainOffset <= 124);
		pos = searchDNA(nextPos);
		nextPos = pos - 8;
		viableGuide = ExtractGuide(pos, guideCount, seq, guide);
		if (viableGuide)
		{
			FRESULT fr;
			u32 bytesWritten=0;
			DFILE currFile;
			char fileName[14] = "guide_";
			fileName[6] = (((guideCount + 1) / 100) % 10) + 48;
			fileName[7] = (((guideCount + 1) / 10) % 10) + 48;
			fileName[8] = ((guideCount + 1) % 10) + 48;
			fileName[9] = '.';
			fileName[10] = 't';
			fileName[11] = 'x';
			fileName[12] = 't';
			fileName[13] = '\0';
			xil_printf("%s\r\n", fileName);
			if ((fr = currFile.fsopen(fileName, FA_WRITE | FA_CREATE_ALWAYS)) == FR_OK) {
				xil_printf("Opened %s\r\n", fileName);
				fr = currFile.fswrite(guide, 23, &bytesWritten);
				if (fr == FR_OK)
					xil_printf("Write successful\r\n");
				else
				{
					xil_printf("Write failed\r\n");
					break;
				}
			}
			else
			{
				xil_printf("Failed to open file to write to\r\n");
				break;
			}

			u8 guideForOffTarget[21];
			u8 offTarget[24];
			for (int i = 0; i < 20; i++)
			{
				guideForOffTarget[i] = guide[i];
			}
			guideForOffTarget[20] = '\0';
			for (unsigned guideOffset = 0; guideOffset < 3; guideOffset++)
			{
				unsigned long translatedGuideSeq = TranslateSequence(guideForOffTarget, guideOffset * 8);
				WriteGuideSequence(translatedGuideSeq, guideOffset);
			}
			currFile.fsputs("\r\n");
			int offTargetPos = 3999;
			int offTargetPosToWrite = 0;
			int nextOffTargetPos = offTargetPos;
			float score = 0;
			float scoreSum = 0;
			while (true)
			{
				offTargetPos = findOffTarget(nextOffTargetPos);
				if (offTargetPos == -1)
				{
					mainSeqSegNum++;
					if (mainSeqSegNum >= 178)
						break;
					else
					{
						writeSuccesful = true;
						unsigned mainOffset = 0;
						do
						{
							unsigned long translatedMainSeq = TranslateSequence(allSequences[mainSeqSegNum], mainOffset * 8);
//							printf("0x%32lx", translatedMainSeq);
							WriteMainSequence(translatedMainSeq, mainOffset);
							mainOffset++;
						}while (mainOffset <= 124);
					}
					nextOffTargetPos = 3999;
				}
				else
				{
					nextOffTargetPos = offTargetPos - 4;
					if (ExtractOffTarget(offTargetPos, allSequences[mainSeqSegNum], offTarget))
					{
						score = scoreOffTarget(offTarget, guide);
						scoreSum += score;
						offTargetPosToWrite = getOffTargetPosToWrite(allSequences[mainSeqSegNum], mainSeqSegNum, offTargetPos);
						printf("Loci %d : %s, %0.2f\r\n", offTargetPosToWrite, offTarget, score);
						currFile.fsputs("Loci ");
						currFile.fsputc((char)((offTargetPosToWrite / 100000) % 10) + 48);
						currFile.fsputc((char)((offTargetPosToWrite / 10000 ) % 10) + 48);
						currFile.fsputc((char)((offTargetPosToWrite / 1000  ) % 10) + 48);
						currFile.fsputc((char)((offTargetPosToWrite / 100   ) % 10) + 48);
						currFile.fsputc((char)((offTargetPosToWrite / 10    ) % 10) + 48);
						currFile.fsputc((char)((offTargetPosToWrite / 1     ) % 10) + 48);
						currFile.fsputs(" : ");
						const char * offTStr = (char*) offTarget;
						currFile.fsputs(offTStr);
						currFile.fsputs(", ");
						currFile.fsputc((char)(((int)(score / 100) % 10) + 48));
						currFile.fsputc((char)(((int)(score / 10) % 10 ) + 48));
						currFile.fsputc((char)(((int)score % 10) + 48));
						currFile.fsputc('.');
						currFile.fsputc((char)(((int)(score * 10) % 10) + 48));
						currFile.fsputc((char)(((int)(score * 100) % 10) + 48));
						currFile.fsputs("\r\n");
					}
				}
			}
			float guideScore = (100.0f/(100 + scoreSum)) * 100;
			currFile.fsputs("Guide Score: ");
			currFile.fsputc((char)(((int)(guideScore / 100) % 10) + 48));
			currFile.fsputc((char)(((int)(guideScore / 10) % 10) + 48));
			currFile.fsputc((char)(((int)(guideScore) % 10) + 48));
			currFile.fsputc('.');
			currFile.fsputc((char)(((int)(guideScore * 10) % 10) + 48));
			currFile.fsputc((char)(((int)(guideScore * 100) % 10) + 48));
			currFile.fsputs("\r\n");

			guideCount++;
			fr = currFile.fsclose();
			if (fr == FR_OK)
				printf("Successfully closed file\n");
			else
			{
				printf("Failed to close file!");
				break;
			}
		}
	} while (pos != -1);

	printf("Done with guides! There are %d guides.\r\n\n", guideCount);
	while (1){}
}

int getOffTargetPosToWrite(u8 seq[1001], uint sequenceNum, int offTargetPos)
{
	int offTargetPosToWrite = offTargetPos;
	uint uCount = 0;
	char nucleotide = ' ';
	int index = 0;
	do
	{
		nucleotide = seq[index];
		if (nucleotide == 'U')
			uCount++;
		index++;
	} while (nucleotide == 'U' && index < 1001);

	offTargetPosToWrite = offTargetPos + (977 * (sequenceNum - 1)) - uCount;

	return offTargetPosToWrite;
}

bool inputNextSequenceSegment(u8 seq[1001], uint sequenceNum)
{
	if(ReadMainSequence(seq, sequenceNum))
	{
		unsigned mainOffset = 0;
		do
		{
			unsigned long translatedMainSeq = TranslateSequence(seq, mainOffset * 8);
			WriteMainSequence(translatedMainSeq, mainOffset);
			mainOffset++;
		}while (mainOffset <= 124);
	}
	else
		return false;
	return true;
}

bool compareNucleotides(u8 n1, u8 n2)
{
	if (n1 == n2)
		return true;
	else if (n1 == '\0' || n2 == '\0')
		return false;
	else
	{
		unsigned tn1 = TranslateNucleotide(n1);
		unsigned tn2 = TranslateNucleotide(n2);
		return (tn1 & tn2) != 0;
	}
}

float scoreOffTarget(u8 offTarget[24], u8 guide[24])
{
//	xil_printf("Scoring %s\r\n", offTarget);
	const static float vars[20] = {0, 0, 0.014f, 0, 0, 0.395f, 0.317f, 0, 0.389f, 0.079f, 0.445f, 0.508f, 0.613f, 0.851f, 0.732f, 0.828f, 0.615f, 0.804f, 0.685f, 0.583f};
	float score = 0;
	int offTargetPositions[20] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
	int minOffTarget = -1;
	int maxOffTarget = -1;
	float d;
	int offTargetCount = 0;
	float term1, term2, term3;
	for (int pos = 0; pos < 20; pos++)
	{
		if(!compareNucleotides(offTarget[pos], guide[pos]))
		{
//			printf("MisMatch at %d!\r\n", pos);
			offTargetPositions[offTargetCount] = pos;
			if (minOffTarget == -1)
				minOffTarget = pos + 1;
			if (maxOffTarget == -1 || (pos + 1) > maxOffTarget)
			{
				maxOffTarget = pos + 1;
			}
			offTargetCount++;
		}
	}
	if (offTargetCount == 0)
	{
		return 0;
	}
	else if (offTargetCount == 1)
	{
		d = 19;
		term1 = 1 - vars[offTargetPositions[0]];
	}
	else
	{
		d = (maxOffTarget - minOffTarget) / (offTargetCount - 1);
//		printf("d = %0.2f\r\n", d);
		term1 = 1 - vars[offTargetPositions[0]];
		for (int i = 1; i < offTargetCount; i++)
		{
			term1 *= (1 - vars[offTargetPositions[i]]);
		}
	}
	term2 = 1.0f / ((((float)(19 - d)/19) * 4) + 1);
	term3 = 1.0f / (offTargetCount * offTargetCount);
	score = term1 * term2 * term3;
	score *= 100;

	return score;
}

void WriteBigSequence(unsigned long bigSeq, unsigned offset)
{
	Xil_Out32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + offset * 4, bigSeq);
}

void WriteMainSequence(unsigned long mainSeq, unsigned offset)
{
	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + offset * 4, mainSeq);
}

void WriteGuideSequence(unsigned long guide, unsigned offset)
{
//	printf("0x%8lx, %d\r\n", guide, offset);
	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + ((125 + offset) * 4), guide);
}

bool ExtractGuide(int index, unsigned count, u8 seq[501], u8 guide[24])
{
	if (index == -1)
	{
		return false;
	}
	unsigned long charIndex = 500 - ((index + 1) / 4);
	if (seq[charIndex - 1] == 'G')
	{
		return false;
	}
	charIndex = charIndex - 21;

	for (int i = 0; i < 23; i++)
	{
		guide[i] = seq[charIndex + i];
	}
	guide[23] = '\0';
	return true;
}

bool ExtractOffTarget(int index, u8 seq[1001], u8 offTarget[24])
{
	if (index == -1)
		return false;
	if (index > (4000 - 23))
		return false;
	if (seq[1000 - ((index + 1)/ 4)] == 'U')
		return false;

	for (int cnt = 0, i = 1000 - ((index + 1) / 4); cnt < 23; i++, cnt++)
	{
		offTarget[cnt] = seq[i];
	}

	offTarget[23] = '\0';

	return true;
}

int findOffTarget(unsigned long startIndex)
{
	int pos = -1;
	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + (128 * 4), startIndex);
//	printf("Starting Index: 0x%32lx\r\n", startIndex);
//	xil_printf("Writing register values...\r\n");
	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + (129 * 4), 0x0);
//	xil_printf("Started searching...\r\n");
	Xil_Out32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + (129 * 4), 0x1);
	unsigned long location = 0;
	unsigned done = 0, found = 0;
	unsigned doneFoundLocationStream = 0;
	do
	{
		doneFoundLocationStream = Xil_In32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + (130 * 4));
		//{DONE, FOUND, LOCATION}
		//Location is first 12 bits:
		// 0000 1111 1111 1111
		// 0    f    f    f
		//FOUND is 13th bit:
		// 0001 0000 0000 0000
		// 1    0    0    0
		//DONE is 14th bit:
		// 0010 0000 0000 0000
		// 2    0    0    0
//		location = (doneFoundLocationStream >> 6) & 0xfff;
		done = doneFoundLocationStream & 0x2000;
//		printf("DFLS Stream: 0x%8x\r\n", doneFoundLocationStream);
//		xil_printf("%d\r\n", done);
	} while(done == 0);

	doneFoundLocationStream = Xil_In32(XPAR_OFFTARGETSEARCHER_0_S00_AXI_BASEADDR + (130 * 4));
	location = (doneFoundLocationStream) & 0xfff;
//	xil_printf("LOCATION: %d\r\n", location);
	pos = location;
	found = doneFoundLocationStream & 0x1000;
	if (found == 0)
		return -1;
	return pos;
}

int searchDNA(unsigned long startIndex)
{
	int pos = 0;
//	xil_printf("Start Index: %d\r\n", startIndex);
//	printf("Start index hex: 0x%3lx\r\n", startIndex);
	//startIndex is 11 bits long:
	//0000 0111 1111 1111
	//   0	  7    F    F
	//Done is at 12th bit:
	//0000 1000 0000 0000
	//   0    8    0    0
	//Found is at 13th bit:
	//0001 0000 0000 0000
	//   1    0    0    0
	u32 indexBin = 0;
	indexBin += startIndex;
	unsigned long location = 0;

	unsigned done = 0, found = 0;

	unsigned doneFoundLocationStream = 0;

	Xil_Out32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + (63 * 4), indexBin);

//	xil_printf("Writing register values...\r\n");
	Xil_Out32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + (64 * 4), 0x0);
//	xil_printf("Started searching...\r\n");
	Xil_Out32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + (64 * 4), 0x1);
	do
	{
		doneFoundLocationStream = Xil_In32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + 260);
//		printf("Found, Done, Location: 0x%08x\r\n", doneFoundLocationStream);
		done = doneFoundLocationStream & 0x800;
	}while (done == 0);


//	printf("DoneFoundLocation Stream: 0x%08x\r\n", doneFoundLocationStream);

	location = Xil_In32(XPAR_PAMCHUNKSEARCH_0_S00_AXI_BASEADDR + 260) & 0x7FF;
	pos = location;
//	printf("Search output : 0x%08lx\r\n", location);
	found = doneFoundLocationStream & 0x1000;
//	printf("Found: 0x%08x\r\n", found);
	if (found == 0)
	{
		pos = -1;
	}

	return pos;
}

void ReadBigSequence(u8 seq[501])
{
//	xil_printf("Reading big sequence\r\n");
	DFILE file;
	// the drive to mount the SD volume to.
	// options are: "0:", "1:", "2:", "3:", "4:"

	FRESULT fr;
	u32 bytesRead, totalBytesRead;
	u8 *seqPtr;

	//Mount the disk


	if ((fr = file.fsopen("500BP.txt", FA_READ)) == FR_OK) {
		seqPtr = seq;
		totalBytesRead = 0;
		do {
			fr = file.fsread(seqPtr, 1, &bytesRead);
//			xil_printf("%c", *seqPtr);
			seqPtr++;
			totalBytesRead += bytesRead;
		} while (totalBytesRead < 500 && fr == FR_OK);
//		xil_printf("\r\n");
		if (fr == FR_OK) {
			seq[totalBytesRead] = 0;

		}
		else
			xil_printf("Read failed\r\n");
	}
	else
		xil_printf("Failed to open file to read from\r\n");

}

bool ReadMainSequence(u8 seq[1001], uint segNum)
{
//	xil_printf("Reading main sequence\r\n");
	DFILE file;

	// the drive to mount the SD volume to.
	// options are: "0:", "1:", "2:", "3:", "4:"

	FRESULT fr;
	u32 bytesRead, totalBytesRead;
	u8 *seqPtr;

	//Mount the disk
	char fileName[29] = "genome/ccr_genome_seg";
	fileName[21] = (((segNum) / 100) % 10) + 48;
	fileName[22] = (((segNum) / 10) % 10) + 48;
	fileName[23] = ((segNum) % 10) + 48;
	fileName[24] = '.';
	fileName[25] = 't';
	fileName[26] = 'x';
	fileName[27] = 't';
	fileName[28] = '\0';
	printf("Opening file %s\n", fileName);
	if ((fr = file.fsopen(fileName, FA_READ)) == FR_OK) {
		seqPtr = seq;
		totalBytesRead = 0;
		do {
			fr = file.fsread(seqPtr, 1, &bytesRead);
//			xil_printf("%c", *seqPtr);
			seqPtr++;
			totalBytesRead += bytesRead;
		} while (totalBytesRead < 1000 && fr == FR_OK);
//		xil_printf("\r\n");
		if (fr == FR_OK) {
			seq[totalBytesRead] = 0;

		}
		else
		{
			xil_printf("Read failed\r\n");
			return false;
		}
	}
	else
	{
		xil_printf("Failed to open file to read from\r\n");
		return false;
	}
	return true;
}

unsigned TranslateNucleotide(u8 nucleotide)
{
	unsigned translated = 0x0;
	switch (nucleotide)
	{
	case 'U':
		translated = 0x0;
		//0000
		break;
	case 'A':
		translated = 0x1;
		//0001
		break;
	case 'G':
		translated = 0x2;
		//0010
		break;
	case 'C':
		translated = 0x4;
		//0100
		break;
	case 'T':
		translated = 0x8;
		//1000
		break;
	case 'M':
		translated = 0x5;
		//0101
		break;
	case 'R':
		translated = 0x3;
		//0011
		break;
	case 'W':
		translated = 0x9;
		//1001
		break;
	case 'S':
		translated = 0x6;
		//0110
		break;
	case 'Y':
		translated = 0xc;
		//1100
		break;
	case 'K':
		translated = 0xa;
		//1010
		break;
	case 'V':
		translated = 0x7;
		//0111
		break;
	case 'H':
		translated = 0xd;
		//1011
		break;
	case 'D':
		translated = 0xb;
		break;
	case 'B':
		translated = 0xe;
		//1110
		break;
	default:
		translated = 0xF;
		//1111
		break;
	}
	return translated;
}

unsigned long TranslateSequence(u8* sequence, unsigned offset)
{
	unsigned i = offset;
	u8 nucleotide = sequence[i];
	unsigned long translatedSequence;
	translatedSequence = TranslateNucleotide(nucleotide) & 0xF;
	do
	{
		i++;
		nucleotide = sequence[i];
		if (nucleotide == '\0')
			break;
//		xil_printf("%c\n", nucleotide);
		translatedSequence = translatedSequence << 4;
//		printf("0x%08x\n", translatedSequence);
		translatedSequence = translatedSequence | (TranslateNucleotide(nucleotide) & 0xF);
//		xil_printf("%u\n", TranslateNucleotide(nucleotide) & 0xF);
	}
	while (nucleotide != '\0' && i < offset + 7);
	return translatedSequence;
}