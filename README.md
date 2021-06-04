# Six-connectivity
Object labelling using six connectivity algorithm

We impemented 6-bit connectivity in MATLAB. 6-connected pixels are neighbors to every pixel that touches one of their corners (which includes pixels that touch one of their edges) in a hexagonal grid or stretcher bond rectangular grid.

There are several ways to map hexagonal tiles to integer pixel coordinates. With one method, in addition to the 4-connected pixels, the two pixels at coordinates:

(x+1,y+1) and (x-1,y-1) are connected to the pixel at (x,y)
