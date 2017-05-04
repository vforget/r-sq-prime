#!/usr/bin/gawk

#  Usage: 
#    awk -v cor=<R-signed> Pa=<AF_SNPA> Pb=<AF_SNPB> -f r-sq-prime.awk

BEGIN {
    OFS="\t"
    
    r2max="NA"
    if (Pa<0.5  && Pb>=0.5 && Pa<Pb  && (Pa+Pb)>=1) { r2max=(((1-Pa)*(1-Pb)) / (Pa*Pb))}
    if (Pa>=0.5 && Pb>=0.5 && Pa<Pb  && (Pa+Pb)>=1) { r2max=((Pa*(1-Pb))     / ((1-Pa)*Pb)) }   
    if (Pa>=0.5 && Pb>=0.5 && Pa>=Pb && (Pa+Pb)>=1) { r2max=(((1-Pa)*Pb)     / (Pa*(1-Pb))) }
    if (Pa>=0.5 && Pb<0.5  && Pa>=Pb && (Pa+Pb)>=1) { r2max=(((1-Pa)*(1-Pb)) / (Pa*Pb)) }
    if (Pa>=0.5 && Pb<0.5  && Pa>=Pb && (Pa+Pb)<1)  { r2max=((Pa*Pb)         / ((1-Pa)*(1-Pb))) }
    if (Pa<0.5  && Pb<0.5  && Pa>=Pb && (Pa+Pb)<1)  { r2max=(((1-Pa)*Pb)     / (Pa*(1-Pb))) }
    if (Pa<0.5  && Pb<0.5  && Pa<Pb  && (Pa+Pb)<1)  { r2max=((Pa*(1-Pb))     / ((1-Pa)*Pb)) }
    if (Pa<0.5  && Pb>=0.5 && Pa<Pb  && (Pa+Pb)<1)  { r2max=((Pa*Pb)         / ((1-Pa)*(1-Pb))) }
    
    rmax = sqrt(r2max)
    rprime = cor/rmax
    print  "+++++++++++++++++++++++r-sq-prime+++++++++++++++++++++++"
    printf "%6s %6s %6s %6s %6s %10s %10s\n", "Pa","Pb","R","R-max","R-sq","R-sq-max","R-prime"
    printf "%1.4f %1.4f %1.4f %1.4f %1.4f %10.4f %10.4f\n", Pa, Pb, cor, rmax, cor*cor, r2max, rprime
}
