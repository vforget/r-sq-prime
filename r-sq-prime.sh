#!/bin/bash

bfile=$1
snpA=$2
snpB=$3

plink --bfile ${bfile} --snps ${snpA},${snpB} --r --out ${snpA}_${snpB} --silent
plink --bfile ${bfile} --snps ${snpA},${snpB} --freq --out ${snpA}_${snpB} --silent

cor=$(awk 'NR==2 { print $7 }' ${snpA}_${snpB}.ld)
Pa=$(awk 'NR==2 { print $5 }' ${snpA}_${snpB}.frq)
Pb=$(awk 'NR==3 { print $5 }' ${snpA}_${snpB}.frq)

awk -v cor=$cor -v Pa=$Pa -v Pb=$Pb -f r-sq-prime.awk

rm ${snpA}_${snpB}.log
rm ${snpA}_${snpB}.frq
rm ${snpA}_${snpB}.ld
rm ${snpA}_${snpB}.nosex

