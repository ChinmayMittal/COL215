# -*- coding: utf-8 -*-
"""
Created on Mon Aug  8 23:28:02 2022

@author: nsahu
"""

from K_map_gui_tk import *

"""
Class kmap is the wrapper for the tkinter gui.
Usage: kmap(<kmap values in list of list form>)
example for 2 input k-map, kmap([[1,0],[0,0]])
        for 3 input k-map, kmap([[1,0,0,1],[0,0,0,1]])
        for 4 input k-map, kmap([[1,0,0,1],[0,0,0,1],[0,1,0,1],[0,1,0,1]])

To draw the region, use api root.draw_region(x1,y1,x2,y2,"fill colour")
Here x1,y1 is the index for the top left corner of the region
x2,y2 is the index for the bottom right corner of the region.
Fill colour options = ['red', 'blue', 'green', 'yellow']
"""

"""
Sample code for the example given in the slide
"""

root = kmap([[0,1,1,0], ['x',1,'x',0], [1,0,0,0], [1,'x',0,0]])
root.draw_region(0,1,1,2,'blue')
root.draw_region(3,3,3,0,'green')
root.mainloop()


"""
Sample code for the displaying wrap region
"""
root = kmap([[0,1,1,0], ['x',1,'x',0], [1,0,0,0], [1,'x',0,0]])
root.draw_region(1,3,2,0,'blue')
root.draw_region(3,0,0,3,'green')
# root.draw_region(3,3,0,0,'green')
root.mainloop()
