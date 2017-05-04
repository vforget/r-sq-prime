# R-sq-prime 

Computed R-squared-prime as defined by:

    VanLiere JM, Rosenberg NA. Mathematical properties of the r2 measure of
    linkage disequilibrium. Theor Popul Biol. 2008 Aug;74(1):130-7. doi:
    10.1016/j.tpb.2008.05.006. Epub 2008 Jun 1. PubMed PMID: 18572214; PubMed Central
    PMCID: PMC2580747.

## Usage

    awk -v cor=<R-signed> Pa=<AF_SNPA> Pb=<AF_SNPB> -f r-sq-prime.awk

## Output 
 
    $ awk -v cor=0.7207 -v Pa=0.0023 -v Pb=0.0037 -f r-sq-prime.awk
    Pa         Pb      R  R-max   R-sq   R-sq-max    R-prime
	0.0023 0.0037 0.7207 0.7879 0.5194     0.6207     0.9147
	 
