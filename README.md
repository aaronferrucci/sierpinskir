# SierpinskiR

Draw a Sierpinski Triangle with R, ggplot2.

## Algorithm
```
Draw the 3 vertices of a triangle
Choose a random vertex as the "current point"
repeat:
  move halfway from the current point to a random vertex
  plot the current point
```

The algorithm can be generalized beyond n=3, by moving ```1/(n-1)``` of the
distance. As ```n``` grows, the points recede to the origin, so I apply a scale
factor when plotting.

![A tesselation](https://github.com/aaronferrucci/sierpinskir/blob/master/anim.gif)

