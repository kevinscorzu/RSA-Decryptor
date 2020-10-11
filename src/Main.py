import os
import PIL.Image as Image
import numpy as np

def readEncFile():
    with open('imagen.txt', "r") as f:
        data = f.read()
        f.close()
        data = data.split(' ')
        for i in range(0, len(data)):
            data[i] = int(data[i])
        return data

def readDecFile():
    with open('imagenNueva.txt', "r") as f:
        data = f.read()
        f.close()
        data = data.split(' ')
        del data[-1]
        for i in range(0, len(data)):
            data[i] = int(data[i])
        return data

def createEncImage():
    encImage = readEncFile()
    encNpArray = np.array(encImage)
    encNpArray = np.reshape(encNpArray, (640, 960))
    encImageData = Image.fromarray((encNpArray * 255).astype(np.uint8))
    encImageData.save('encrypted.png')

def createDecImage():
    decImage = readDecFile()
    decNpArray = np.array(decImage)
    decNpArray = np.reshape(decNpArray, (640, 480))
    decImageData = Image.fromarray((decNpArray * 255).astype(np.uint8))
    decImageData.save('decrypted.png')

if __name__ == '__main__':
    os.system('./Main')
    createEncImage()
    createDecImage()
    print('Listo')
