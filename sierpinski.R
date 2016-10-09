library(ggplot2)

random.point <- function(anchors) {
  index <- sample(1:length(anchors$x), 1)
  x <- anchors$x[index]
  y <- anchors$y[index]
  return(c(x, y))
}

get_anchors <- function(n) {
  offset <- pi / 2 - (n - 1) * pi / n
  print(offset)
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

for (n in 3:5) {
  anchors <- get_anchors(n)
  
  base.g <- ggplot() + geom_point(data=anchors, aes(x = x, y = y), color="red", size=4)
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
