def translateToBasePair(binary):
    basePair = ''
    if binary == '0000':
        basePair = 'U'
    elif binary == '0001':
        basePair = 'A'
    elif binary == '0010':
        basePair = 'G'
    elif binary == '0100':
        basePair = 'C'
    elif binary == '1000':
        basePair = 'T'
    return basePair

def translateFile():
    with open('candidatus_carsonella_ruddii_genome_binary.txt') as binFile:
        binData = binFile.read()
        with open('ccr_genome.txt' ,'w') as dnaFile:
            lenOfBinData = len(binData)
            for i in range(0, lenOfBinData - 1, 4):
                if i % 10000 == 0:
                    print('.', end='')
                binBasePair = binData[i : i + 4]
                print(binBasePair)
                basePair = translateToBasePair(binBasePair)
                print(basePair)
                #dnaFile.write(basePair)

translateFile()
