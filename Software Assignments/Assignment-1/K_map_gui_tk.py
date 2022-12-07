#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug  2 13:06:36 2022

@author: naman
"""

"""
Installing tkinter and PIL
1) pip install tk
2) pip install pillow
"""

from tkinter import *
from PIL import Image, ImageTk

coordinate_dir_start = {
    (0,0):(64, 64), (0,1):(114, 64), (0,2):(164, 64), (0,3):(214, 64),
    (1,0):(64, 114), (1,1):(114, 114), (1,2):(164, 114), (1,3):(214, 114),
    (2,0):(64, 164), (2,1):(114, 164), (2,2):(164, 164), (2,3):(214, 164),
    (3,0):(64, 214), (3,1):(114, 214), (3,2):(164, 214), (3,3):(214, 214),
                        }

coordinate_dir_end = {
    (0,0):(89, 89), (0,1):(139, 89), (0,2):(189, 89), (0,3):(239, 89),
    (1,0):(89, 139), (1,1):(139, 139), (1,2):(189, 139), (1,3):(239, 139),
    (2,0):(89, 189), (2,1):(139, 189), (2,2):(189, 189), (2,3):(239, 189),
    (3,0):(89, 239), (3,1):(139, 239), (3,2):(189, 239), (3,3):(239, 239),
                        }

headings = {
    (2,2): ([['0','1'],['0','1']],['a','b']),
    (4,2): ([['0','1'],['00','01','11','10']],['c', 'ab']),
    (2,4): ([['00','01','11','10'],['0','1']],['ab','c']),
    (4,4): ([['00','01','11','10'],['00','01','11','10']],['ab', 'cd']),
    }

class kmap(Tk):
    """
    Source: https://stackoverflow.com/questions/54637795/how-to-make-a-tkinter-canvas-rectangle-transparent
    """
    def create_rectangle(self, x1, y1, x2, y2, **kwargs):
        if 'alpha' in kwargs:
            alpha = int(kwargs.pop('alpha') * 255)
            fill = kwargs.pop('fill')
            fill = self.winfo_rgb(fill) + (alpha,)
            image = Image.new('RGBA', (x2-x1, y2-y1), fill)
            self.images.append(ImageTk.PhotoImage(image))
            self.canvas.create_image(x1, y1, image=self.images[-1], anchor='nw')
        self.canvas.create_rectangle(x1, y1, x2, y2, **kwargs)

    def __init__(self, values=[[0,0,0,0], [0,0,0,0]]):
        super(kmap, self).__init__()
        self.images = []
        self.title("Kmap")
        self.minsize(400, 400)
        self.canvas = Canvas(self, height=400, width=400, bg='#fff')
        self.rsz = len(values)
        self.csz = len(values[0])
        
        self.m = []
        labelh = headings[(self.rsz,self.csz)]
        self.canvas.create_text(50, 25, text=labelh[1][0])
        self.canvas.create_text(25, 50, text=labelh[1][1])
        for c in range(len(labelh[0][0])):
            self.canvas.create_text(75+50*c, 25, text=labelh[0][0][c])
        for c in range(len(labelh[0][1])):
            self.canvas.create_text(25, 75+50*c, text=labelh[0][1][c])
        for i in range(self.rsz):
            for j in range(self.csz):
                self.canvas.create_rectangle(50*j+50, 50*i+50, 100+50*j, 100+50*i, outline = 'black', fill='', width=2)
                if type(values[i][j])=='str':
                    self.canvas.create_text(50*j+75, 50*i+75, text=values[i][j])
                else:
                    self.canvas.create_text(50*j+75, 50*i+75, text=str(values[i][j]))
        
        self.canvas.pack()
    
    def draw_region(self, x1, y1, x2, y2, color):
        if x1 < self.rsz and y1 < self.csz and y2 < self.csz and x2 < self.rsz:
            if x1 <= x2 and y1 <= y2:
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], coordinate_dir_start[(x1, y1)][1], coordinate_dir_end[(x2, y2)][0], coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
            elif x1 <= x2 and y1 > y2:
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], coordinate_dir_start[(x1, y1)][1], 50+(self.csz)*50, coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
                self.create_rectangle(50, coordinate_dir_start[(x1, y1)][1], coordinate_dir_end[(x2, y2)][0], coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
            elif x1 > x2 and y1 <= y2:
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], coordinate_dir_start[(x1, y1)][1], coordinate_dir_end[(x2, y2)][0], 50+(self.rsz)*50, outline = 'green', fill=color, width=2, alpha=0.3)
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], 50, coordinate_dir_end[(x2, y2)][0], coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
            elif x1 == self.rsz-1 and y1 == self.csz-1 and x2 == 0 and y2 == 0:
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], coordinate_dir_start[(x1, y1)][1], 50+(self.csz)*50, 50+(self.rsz)*50, outline = 'green', fill=color, width=2, alpha=0.3)
                self.create_rectangle(50, 50, coordinate_dir_end[(x2, y2)][0], coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
                self.create_rectangle(coordinate_dir_start[(x1, y1)][0], 50, 50+(self.csz)*50, coordinate_dir_end[(x2, y2)][1], outline = 'green', fill=color, width=2, alpha=0.3)
                self.create_rectangle(50, coordinate_dir_start[(x1, y1)][1], coordinate_dir_end[(x2, y2)][0], 50+(self.rsz)*50, outline = 'green', fill=color, width=2, alpha=0.3)
            else:
                print("ERROR: Illegal coordinates values for the corner, check your (x1,y1),(x2,y2)")
                return
        else:
            print("ERROR: Value out of k-map area")
            return
    
#Sample code 

# root = kmap([[0,0,0,0], [0,0,0,0], [0,0,0,'x'], [0,1,1,1]])
# root.draw_region(0,1,1,2,'green')
# # root.draw_region(0,0,3,1,'red')
# root.draw_region(0,3,3,3,'blue')
# root.draw_region(0,3,3,0,'yellow')
# root.draw_region(3,0,0,3,'red')
# root.canvas.pack()
# root.mainloop()
