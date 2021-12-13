# Draw Manhattan plot for genomic analysis
## R script using CMplot package

### Installation

**CMplot** is available on CRAN, so it can be installed with the following R code:
```r
> install.packages("CMplot")
> library("CMplot")

# if you want to use the latest version on GitHub:
> source("https://raw.githubusercontent.com/YinLiLin/CMplot/master/R/CMplot.r")
```
---
There are two datasets built-in **CMplot** package (i.e. pig 60K SNPs and cattle 50K SNPs) in which users can export and view the details by following R code:

- The first three columns in both datasets are **names, chromosome, position of SNPs** respectively.
- The rest of columns in pig data are the **p-values of GWAS** and in cattle data are **SNP effects of genomic selection** for given traits. 
- The number of traits added after those first three columns related to SNP information is unlimited.


```r
> data(pig60K)      # calculated p-values by MLM
> data(cattle50K)   # calculated SNP effects by rrblup
> head(pig60K)

          SNP Chromosome Position    trait1     trait2     trait3
1 ALGA0000009          1    52297 0.7738187 0.51194318 0.51194318
2 ALGA0000014          1    79763 0.7738187 0.51194318 0.51194318
3 ALGA0000021          1   209568 0.7583016 0.98405289 0.98405289
4 ALGA0000022          1   292758 0.7200305 0.48887140 0.48887140
5 ALGA0000046          1   747831 0.9736840 0.22096836 0.22096836
6 ALGA0000047          1   761957 0.9174565 0.05753712 0.05753712

> head(cattle50K)

   SNP chr    pos Somatic cell score  Milk yield Fat percentage
1 SNP1   1  59082        0.000244361 0.000484255    0.001379210
2 SNP2   1 118164        0.000532272 0.000039800    0.000598951
3 SNP3   1 177246        0.001633058 0.000311645    0.000279427
4 SNP4   1 236328        0.001412865 0.000909370    0.001040161
5 SNP5   1 295410        0.000090700 0.002202973    0.000351394
6 SNP6   1 354493        0.000110681 0.000342628    0.000105792

```
**Note**: if plotting SNP_Density, only the first three columns are needed.

**CMplot** could handle not only Genome-wide association study results (p-values), but also SNP effects, Fst, tajima's D and so on.

---
### Citation
CMplot has been integrated into our developed GWAS package ```rMVP```, please cite the following paper:</br>
Yin, L. et al. [rMVP: A Memory-efficient, Visualization-enhanced, and Parallel-accelerated tool for Genome-Wide Association Study](https://doi.org/10.1016/j.gpb.2020.10.007), ***Genomics, Proteomics & Bioinformatics*** (2021), doi: 10.1016/j.gpb.2020.10.007.</br>

---
