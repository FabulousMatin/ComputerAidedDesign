import numpy as np

def tohex(val, nbits):
  return hex((val + (1 << nbits)) % (1 << nbits))


def print_to_file(memory, fileName: str):

    file = open(fileName, 'w')
    header = '''// memory data file (do not edit the following line - required for mem load use)
// format=hex addressradix=d dataradix=h version=1.0 wordsperline=4'''
    print(header, file=file)

    for i in range(128):
        for j in range(4):
            print(tohex(memory[i][j], 8)[2:].zfill(2), file=file, end='')
        print(file=file)
    
    file.close()



def random_test(x, y, z):
    
    wordsPerLine = 4
    memory = np.zeros(shape=(128, 4), dtype=int)
    
    A = np.random.randint(size=(16,16), low=-10, high=11)
    filter = np.random.randint(size=(4,4), low=-1, high=2)
    res = np.zeros(shape=(13,13), dtype=int)

    for i in range(256):
        memory[x + i // wordsPerLine][i % wordsPerLine] = A.flatten()[i]
    for i in range(16):
        memory[y + i // wordsPerLine][i % wordsPerLine] = filter.flatten()[i]
    print_to_file(memory, "./sim/file/input.mem")

    for i in range(13):
        for j in range(13):
            res[i][j] = np.sum(np.multiply(A[i:i + 4, j:j + 4], filter))
    for i in range(169):
        memory[z + i // wordsPerLine][i % wordsPerLine] = res.flatten()[i]
    print_to_file(memory, "./sim/file/expectedOutput.mem")

    print("picture:")
    print(A)
    print("filter:")
    print(filter)
    print("result:")
    print(res)


# x needs 64 free spaces, y needs 4 and z needs 43
random_test(x = 0, y = 70, z = 75)
