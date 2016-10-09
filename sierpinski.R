library(ggplot2)

random.point <- function(anchors) {
  index <- sample(1:length(anchors$x), 1)
  x <- anchors$x[index]
  y <- anchors$y[index]
  return(c(x, y))
}

get_anchors <- function(n) {
  offset <- pi / 2 - (n - 1) * pi / n
  anchors <- data.frame(
    x = sapply(0:(n - 1), function(x) cos(offset + x * 2 * pi / n)),
    y = sapply(0:(n - 1), function(x) sin(offset + x * 2 * pi / n))
  )
}

get_next <- function(current.point, n, anchors) {
  attract <- random.point(anchors)
  next.point <- (current.point + attract) / (n - 1)  
  return(next.point)  
}

plots <- list()

for (n in 3:6) {
  anchors <- get_anchors(n)
  
  # For values larger than 3, the points recede toward 0. [1 /(n-2)] is the correcting factor.
  plot.anchors <- anchors / (n - 2)
  base.g <- ggplot() + coord_fixed(1) +
    xlim(c(min(plot.anchors$x), max(plot.anchors$x))) +
    ylim(c(min(plot.anchors$y), max(plot.anchors$y))) +
    geom_point(data=plot.anchors, aes(x = x, y = y), color="red", size=4) +
    theme(
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank()  
    )
  
  plots[[length(plots) + 1]] <- base.g
  
  x <- numeric(0)
  y <- numeric(0)
  current.point <- random.point(anchors)
  # Iterate a bit without plotting, to let the point settle.
  for (i in 1:10)
    current.point <- get_next(current.point, n, anchors)
  
  for (i in 1:30) {
    for (j in 1:1000) {
      next.point <- get_next(current.point, n, anchors)
      x[length(x) + 1] <- next.point[1]
      y[length(y) + 1] <- next.point[2]
      current.point <- next.point
    }
    pts <- data.frame(x = x, y = y)
    
    g <- base.g + geom_point(data=pts, aes(x=x, y=y), size=0.1)
    plots[[length(plots) + 1]] <- g
  }
}
