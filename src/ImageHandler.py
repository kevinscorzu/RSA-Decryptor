import PIL.Image as Image
import numpy as np

#Método encargado de leer el archivo encriptado
def readEncFile():
    with open('imagen.txt', "r") as f:
        data = f.read()
        f.close()
        data = data.split(' ')
        for i in range(0, len(data)):
            data[i] = int(data[i])
        return data

#Método encargado de leer el archivo desencriptado
def readDecFile():
    with open('imagenNueva.txt', "r") as f:
        data = f.read()
        f.close()
        data = data.split(' ')
        del data[-1]
        for i in range(0, len(data)):
            data[i] = int(data[i])
        return data

#Método encargado de crear la imagen con base al archivo encriptado
def createEncImage():
    encImage = readEncFile()
    encNpArray = np.array(encImage)
    encNpArray = np.reshape(encNpArray, (640, 960))
    encImageData = Image.fromarray((encNpArray * 255).astype(np.uint16))
    encImageData.save('encrypted.png')

#Método encargado de crear la imagen con base al archivo desencriptado
def createDecImage():
    decImage = readDecFile()
    decNpArray = np.array(decImage)
    decNpArray = np.reshape(decNpArray, (640, 480))
    decImageData = Image.fromarray((decNpArray * 255).astype(np.uint16))
    decImageData.save('decrypted.png')







