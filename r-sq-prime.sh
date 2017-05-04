#!/bin/bash

bfile=$1
snpA=$2
snpB=$3

plink --bfile ${bfile} --snps ${snpA},${snpB} --r --out ${snpA}_${snpB}
plink --bfile ${bfile} --snps ${snpA},${snpB} --freq --out ${snpA}_${snpB}

cor=$(awk 'NR==2 { print $7 }' ${snpA}_${snpB}.ld)
Pa=$(awk 'NR==2 { print $5 }' ${snpA}_${snpB}.frq)
Pb=$(awk 'NR==3 { print $5 }' ${snpA}_${snpB}.frq)

awk -v cor=$cor -v Pa=$Pa -v Pb=$Pb -f r-sq-prime.awk
