
def readGenome():
    genome = '' 
    with open('ccr_genome.txt') as dnaFile:
        genome = dnaFile.read()
    return genome


def writeSegment(division, divisionNum):
    fileName = 'ccr_genome_seg' + str(divisionNum).zfill(3) + '.txt'
    charactersWritten = 0
    with open(fileName, 'w') as segmentFile:
        charactersWritten = segmentFile.write(division)
    return charactersWritten

def divideGenome():
    genome = readGenome()
    size = len(genome)
    startPos = 0
    segmentNum = 1
    print(size)
    print(startPos)
    while True:
        segment = ''
        writeCheck = 0
        if startPos > size - 1000:
            segment = 'U' * (1000 - (size - startPos))
            segment = segment + genome[startPos : size]
            writeCheck = writeSegment(segment, segmentNum)
            if writeCheck != 1000:
                print('Only {} characters written!'.format(writeCheck))
            break
        segment = genome[startPos:startPos + 1000]
        writeCheck = writeSegment(segment, segmentNum)
        if writeCheck != 1000:
            print('Printed {} characters.'.format(writeCheck))
            break
        startPos = startPos + 977
        segmentNum = segmentNum + 1
    print('Done writing!')

divideGenome()
