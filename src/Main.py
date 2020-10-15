import os
import ImageHandler as ih
import tkinter as tk

global window

#Método encargado de ejecutar el archivo de ensamblador, generar las imágenes y mostrarlas en la interfaz
def start():
    global window

    os.system('./Main')
    ih.createEncImage()
    ih.createDecImage()

    encTitle = tk.Label(master=window, text="Imagen Encriptada", width=30, height=1)
    encTitle.place(x=160, y=100)
    encImg = tk.PhotoImage(file='encrypted.png')
    #encImg = encImg.subsample(2, 2)
    encPanel = tk.Label(master=window, image=encImg, width=480, height=320)
    encPanel.image = encImg
    encPanel.place(x=50, y=150)

    decTitle = tk.Label(master=window, text="Imagen Desencriptada", width=30, height=1)
    decTitle.place(x=550, y=100)
    decImg = tk.PhotoImage(file='decrypted.png')
    decImg = decImg.subsample(2, 2)
    decPanel = tk.Label(master=window, image=decImg, width=240, height=320)
    decPanel.image = decImg
    decPanel.place(x=550, y=150)

#Método para crear la ventana principal
def createWindow():
    global window

    window = tk.Tk()
    window.geometry("850x500")

    title = tk.Label(master=window, text="RSA Decryptor", width=30, height=1)
    title.place(x=300, y=0)

    button = tk.Button(master=window, text="Iniciar \n Desencripción", width=10, height=2, command=start)
    button.place(x=365, y=25)

    window.mainloop()

#Método principal
if __name__ == '__main__':
    createWindow()
