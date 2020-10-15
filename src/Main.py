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
    encTitle.place(x=370, y=100)
    encImg = tk.PhotoImage(file='encrypted.png')
    encPanel = tk.Label(master=window, image=encImg, width=960, height=640)
    encPanel.image = encImg
    encPanel.place(x=50, y=150)

    decTitle = tk.Label(master=window, text="Imagen Desencriptada", width=30, height=1)
    decTitle.place(x=1390, y=100)
    decImg = tk.PhotoImage(file='decrypted.png')
    decPanel = tk.Label(master=window, image=decImg, width=480, height=640)
    decPanel.image = decImg
    decPanel.place(x=1250, y=150)

#Método para crear la ventana principal
def createWindow():
    global window

    window = tk.Tk()
    window.geometry("1680x850")

    title = tk.Label(master=window, text="RSA Decryptor", width=30, height=1)
    title.place(x=800, y=0)

    button = tk.Button(master=window, text="Iniciar \n Desencripción", width=10, height=2, command=start)
    button.place(x=865, y=25)

    window.mainloop()

#Método principal
if __name__ == '__main__':
    createWindow()
