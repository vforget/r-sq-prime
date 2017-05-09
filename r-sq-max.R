getr2max <- function(x) {
  Pa=x[1]
  Pb=x[2]
  if (Pa<0.5  && Pb>=0.5 && Pa<Pb  && (Pa+Pb)>=1) { return((((1-Pa)*(1-Pb)) / (Pa*Pb))) }
  if (Pa>=0.5 && Pb>=0.5 && Pa<Pb  && (Pa+Pb)>=1) { return(((Pa*(1-Pb))     / ((1-Pa)*Pb))) }
  if (Pa>=0.5 && Pb>=0.5 && Pa>=Pb && (Pa+Pb)>=1) { return((((1-Pa)*Pb)     / (Pa*(1-Pb)))) }
  if (Pa>=0.5 && Pb<0.5  && Pa>=Pb && (Pa+Pb)>=1) { return((((1-Pa)*(1-Pb)) / (Pa*Pb))) }
  if (Pa>=0.5 && Pb<0.5  && Pa>=Pb && (Pa+Pb)<1)  { return((Pa*Pb)         / ((1-Pa)*(1-Pb))) }
  if (Pa<0.5  && Pb<0.5  && Pa>=Pb && (Pa+Pb)<1)  { return((((1-Pa)*Pb)     / (Pa*(1-Pb)))) }
  if (Pa<0.5  && Pb<0.5  && Pa<Pb  && (Pa+Pb)<1)  { return(((Pa*(1-Pb))     / ((1-Pa)*Pb))) }
  if (Pa<0.5  && Pb>=0.5 && Pa<Pb  && (Pa+Pb)<1)  { return((Pa*Pb)         / ((1-Pa)*(1-Pb))) }
  NA
}

# Modified default filled.contour() to exclude border within legend.
source("filled.contour.R")

x <- seq(0.005, 0.5, 0.0005)
y <- seq(0.005, 0.5, 0.0005)

g <- expand.grid(x,y)
g$r2max <- apply(expand.grid(x,y),1,"getr2max")

lf <- 10

ix <- log(x,lf)
iy <- log(y,lf)

png(file="r-sq-max.png", width = 2400, height=2000, res=360)
lv=seq(0,1,0.05)
clv=seq(0,1,0.2)
labels <- matrix(c(0.0001,0.0005,0.001) %*% t(c(1,10,100,1000)), nrow=1, ncol=12)[1:11]
filled.contour(ix,iy, matrix(g$r2max, nrow = length(x), ncol=length(y), byrow=TRUE), levels=lv, col=cm.colors(length(lv)),
               key.title = title(main=expression(italic(r)[max]^"2")),
               xlab="% MAF(a)",
               ylab="% MAF(b)",
               plot.axes = {
                 abline(h=log(matrix(seq(0.0001,0.001,0.0001) %*% t(c(1,10,100,1000)))[1:35],lf), col = "gray", lty = "dotted")
                 abline(v=log(matrix(seq(0.0001,0.001,0.0001) %*% t(c(1,10,100,1000)))[1:35],lf), col = "gray", lty = "dotted")
                 contour(ix,iy, matrix(g$r2max, nrow = length(x), ncol=length(y), byrow=TRUE), 
                         levels=clv, add=TRUE, labcex = 0.6,  lty="dotted")
                 abline(a=0,b=1, col=rev(cm.colors(length(lv)))[1], lwd=2)
                 axis(1, at=log(labels,lf), labels = labels*100)
                 axis(2, at=log(labels,lf), labels = labels*100, las=1)
                 
                 }
               )

dev.off()
