library(animation)
source("sierpinski.R")

trace.animate <- function () {
  lapply(plots, function(x) print(x))
}

saveGIF(trace.animate(), interval=0.1, movie.name="anim.gif", ani.height=600, ani.width=600)
