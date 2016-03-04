# Community data analysis using the vegan package in R
Naupaka Zimmerman   
March 4, 2016  




## Packages installed and loaded?


```r
install.packages("vegan", dependencies = TRUE)
library("vegan")
```


## Loading your OTU table into R


```r
MLM.otus <- read.csv("data/MLM_data_otus.csv", row.names = 1, header = TRUE)
MLM.env <- read.csv("data/MLM_data_env.csv", header = TRUE)
```



## Loading your OTU table into R


```r
MLM.otus <- read.csv("data/MLM_data_otus.csv", row.names = 1, header = TRUE)
MLM.env <- read.csv("data/MLM_data_env.csv", header = TRUE)
```


```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



# Basic data summarizing



## Summarizing data with `apply()` | sums and sorting

**Sum of rows**

```r
sum.of.rows <- apply(MLM.otus, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (plots) 
```

```
  w700y1   w700o9  w100y10  w1800y2   d700o9 d1700y10   w700o5   w100o1 
    7897     7805     7665     7536     7499     7109     7107     7092 
```



## Summarizing data with `apply()` | sums and sorting

**Sum of rows**

```r
sum.of.rows <- apply(MLM.otus, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (plots) 
```

```
  w700y1   w700o9  w100y10  w1800y2   d700o9 d1700y10   w700o5   w100o1 
    7897     7805     7665     7536     7499     7109     7107     7092 
```
**Sum of columns**

```r
sum.of.columns <- apply(MLM.otus, 2, sum)
sort(sum.of.columns, decreasing = TRUE)[1:3] #top 3 columns (species)
```

```
OTU_0001 OTU_0002 OTU_0003 
  174612   127234    39710 
```



## Summarizing data with `apply()` | sums and sorting

**Number of plots in which each spp. occurs**

```r
spec.pres <- apply(MLM.otus > 0, 2, sum) 
sort(spec.pres, decreasing = TRUE)[1:18]
```

```
OTU_0003 OTU_0002 OTU_0001 OTU_0030 OTU_0011 OTU_0049 OTU_0004 OTU_0029 
     119      108      106      105      102       94       87       83 
OTU_0038 OTU_0046 OTU_0008 OTU_0005 OTU_0083 OTU_0180 OTU_0034 OTU_0062 
      79       77       76       72       68       65       63       63 
OTU_0106 OTU_0092 
      62       60 
```



# Data Transformation



## Basic data transformation

**Square root transformation**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Basic data transformation

**Square root transformation**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.sqrt <- sqrt(MLM.otus)
head(spec.sqrt[,1:3], n = 3)
```

```
        OTU_0001 OTU_0002  OTU_0003
w100y1 58.566202 1.000000  8.660254
w100y2 21.794495 4.123106 24.677925
w100y3  4.898979 3.464102 15.588457
```



## Data transformation in vegan with `decostand()`

**Total**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Data transformation in vegan with `decostand()`

**Total**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.total <- decostand(MLM.otus, method = "total", MARGIN = 1) # by rows (sites)
head(spec.total[,1:3], n = 3)
```

```
          OTU_0001     OTU_0002   OTU_0003
w100y1 0.781677302 0.0002278943 0.01709207
w100y2 0.089758125 0.0032123961 0.11507937
w100y3 0.004244032 0.0021220159 0.04297082
```



## Data transformation in vegan with `decostand()`

**Maximum**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Data transformation in vegan with `decostand()`

**Maximum** 

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.max <- decostand(MLM.otus, method = "max", MARGIN = 2) # by columns (species)
head(spec.max[,1:3], n = 3)
```

```
          OTU_0001     OTU_0002   OTU_0003
w100y1 0.471153846 0.0001653439 0.01960272
w100y2 0.065247253 0.0028108466 0.15917407
w100y3 0.003296703 0.0019841270 0.06351281
```



## Data transformation in vegan with `decostand()`

**Presence-Absence**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Data transformation in vegan with `decostand()`

**Presence-Absence**

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.pa <- decostand(MLM.otus, method = "pa")
head(spec.pa[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1        1        1        1
w100y2        1        1        1
w100y3        1        1        1
```



## Data transformation in vegan with `decostand()`

**Hellinger (Legendre & Gallagher 2001)**    
Square root of method "total"

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Data transformation in vegan with `decostand()`

**Hellinger (Legendre & Gallagher 2001)**     
Square root of method "total"

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.hellinger <- decostand(MLM.otus, method = "hellinger", MARGIN = 1) # on rows (sites)
head(spec.hellinger[,1:3], n = 3)
```

```
         OTU_0001   OTU_0002  OTU_0003
w100y1 0.88412516 0.01509617 0.1307366
w100y2 0.29959660 0.05667800 0.3392335
w100y3 0.06514623 0.04606534 0.2072940
```



## Data transformation in vegan with `decostand()`

**Wisconsin double standardization**      
Shortcut function for standardizing species to maximum, then sites by totals.  

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```



## Data transformation in vegan with `decostand()`

**Wisconsin double standardization**    
Shortcut function for standardizing species to maximum, then sites by totals.

```r
head(MLM.otus[,1:3], n = 3)
```

```
       OTU_0001 OTU_0002 OTU_0003
w100y1     3430        1       75
w100y2      475       17      609
w100y3       24       12      243
```

```r
spec.wisc <- wisconsin(MLM.otus)
head(spec.wisc[,1:3], n = 3)
```

```
           OTU_0001     OTU_0002     OTU_0003
w100y1 0.0095409778 3.348254e-06 0.0003969597
w100y2 0.0005553552 2.392466e-05 0.0013548180
w100y3 0.0000395903 2.382749e-05 0.0007627289
```



# Calculating community distances



## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Many different community distance metrics are available in `vegdist()`    
*manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*



## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Many different community distance metrics are available in `vegdist()`   
*manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*


```r
spec.jaccpa <- vegdist(MLM.otus, method = "jaccard", binary = TRUE)
# returns an object of class 'dist'
str(spec.jaccpa) 
```

```
Class 'dist'  atomic [1:8385] 0.805 0.769 0.78 0.76 0.793 ...
  ..- attr(*, "Size")= int 130
  ..- attr(*, "Labels")= chr [1:130] "w100y1" "w100y2" "w100y3" "w100y4" ...
  ..- attr(*, "Diag")= logi FALSE
  ..- attr(*, "Upper")= logi FALSE
  ..- attr(*, "method")= chr "binary jaccard"
  ..- attr(*, "call")= language vegdist(x = MLM.otus, method = "jaccard", binary = TRUE)
```



## Calculating distances with `vegdist()` | so many distance metrics, so little time!


```r
as.matrix(spec.jaccpa)[1:4,1:4]
```

```
          1         2         3         4
1 0.0000000 0.4336283 0.4621849 0.4416667
2 0.4336283 0.0000000 0.4464286 0.4385965
3 0.4621849 0.4464286 0.0000000 0.4273504
4 0.4416667 0.4385965 0.4273504 0.0000000
```




## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### How to choose a good one for your data set?  
### First step, read the help for vegdist

```r
?vegdist
```



## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Second, try `rankindex()`    
Higher rank correlations indicate better separation along gradients

```r
rank.elev <- rankindex(MLM.env$elevation_m, MLM.otus, indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.elev
```

```
     bray    euclid manhattan      horn 
0.4835205 0.3780230 0.3852126 0.5090748 
```



## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Second, try `rankindex()`    
Can also use on standardized data

```r
rank.elev.wisc <- rankindex(MLM.env$elevation_m, wisconsin(MLM.otus), indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.elev.wisc
```

```
       bray      euclid   manhattan        horn 
 0.45556000 -0.03630866  0.45555990  0.46304968 
```



## Calculating distances with `vegdist()` | comparison


```r
sort(rank.elev, decreasing = TRUE)
```

```
     horn      bray manhattan    euclid 
0.5090748 0.4835205 0.3852126 0.3780230 
```

```r
sort(rank.elev.wisc, decreasing = TRUE)
```

```
       horn        bray   manhattan      euclid 
 0.46304968  0.45556000  0.45555990 -0.03630866 
```


# Diversity metrics



## Alpha diversity

Basic counts of richness for each plot or site

```r
site.richness <- apply(MLM.otus > 0, 1, sum)
site.richness[1:7]
```

```
w100y1 w100y2 w100y3 w100y4 w100y5 w100y6 w100y7 
   140    203    180    126    196    228    154 
```



## Alpha diversity | Other metrics

Fisher's alpha

```r
site.fisher <- fisher.alpha(MLM.otus)
site.fisher[1:7]
```

```
  w100y1   w100y2   w100y3   w100y4   w100y5   w100y6   w100y7 
27.58229 41.88171 35.44263 22.43722 38.22437 47.38469 30.18662 
```



## Alpha diversity | Other metrics

Shannon diversity

```r
site.shannon <- diversity(MLM.otus, index = "shannon", MARGIN = 1)
site.shannon[1:7]
```

```
   w100y1    w100y2    w100y3    w100y4    w100y5    w100y6    w100y7 
1.3131475 3.6102503 2.8062958 0.8844189 2.1920820 2.9354744 2.5789890 
```



## Rarefaction

This is the same as `apply(BCI > 0, MARGIN = 1, sum)`    
it gives the species count for each plot

```r
MLM.S <- specnumber(MLM.otus)
```
This finds the plot with the least number of individuals

```r
# could also use rowsums() instead of apply()
MLM.raremax <- min(apply(MLM.otus, 1, sum))
```



## Rarefaction

Rarefy BCI species matrix to the minimum number of individuals in any plot    
and plot the relationship between observed and rarefied counts (plus add 1-1 line)

```r
MLM.Srare <- rarefy(MLM.otus, MLM.raremax)
plot(MLM.S, MLM.Srare, xlab = "Observed No. of Species", ylab = "Rarefied No. of Species")
abline(0, 1)
```

![](intro-basics_files/figure-html/rarefac-3-1.png)



## Rarefaction

Put it all together

```r
rarecurve(MLM.otus, step = 20, sample = MLM.raremax, col = "blue", cex = 0.6)
```

![](intro-basics_files/figure-html/rarefac-4-1.png)



## Beta diversity

Multivariate homogeneity of groups dispersions

```r
MLM.bray <- vegdist(MLM.otus, method = "bray")
(MLM.bray.bdisp <- betadisper(MLM.bray,group = as.factor(MLM.env$site_ID)))
```

```

	Homogeneity of multivariate dispersions

Call: betadisper(d = MLM.bray, group = as.factor(MLM.env$site_ID))

No. of Positive Eigenvalues: 90
No. of Negative Eigenvalues: 39

Average distance to median:
d1700y  d700o  d700y  w100o  w100y w1100o w1100y w1800o w1800y w2400o 
0.4943 0.4630 0.3584 0.4405 0.4516 0.3840 0.4287 0.3647 0.3440 0.2618 
w2400y  w700o  w700y 
0.2770 0.2800 0.2867 

Eigenvalues for PCoA axes:
  PCoA1   PCoA2   PCoA3   PCoA4   PCoA5   PCoA6   PCoA7   PCoA8 
15.1299  8.0298  4.2202  2.3315  1.8155  1.5186  1.3340  1.2122 
```



## Beta diversity {.smaller}

Multivariate homogeneity of groups dispersions

```r
permutest(MLM.bray.bdisp)
```

```

Permutation test for homogeneity of multivariate dispersions
Permutation: free
Number of permutations: 999

Response: Distances
           Df  Sum Sq  Mean Sq      F N.Perm Pr(>F)  
Groups     12 0.75564 0.062970 2.4179    999  0.014 *
Residuals 117 3.04702 0.026043                       
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```




## Beta diversity

Plot of within-group multivariate dispersion

```r
plot(MLM.bray.bdisp)
```

![](intro-basics_files/figure-html/beta-3-1.png)



## Beta diversity

Boxplot of within-group multivariate dispersion

```r
boxplot(MLM.bray.bdisp)
```

![](intro-basics_files/figure-html/beta-4-1.png)



## Beta diversity | ANOSIM

Analysis of similarities 

```r
(MLM.bray.anosim <- anosim(MLM.bray, MLM.env$site_ID))
```

```

Call:
anosim(dat = MLM.bray, grouping = MLM.env$site_ID) 
Dissimilarity: bray 

ANOSIM statistic R: 0.7436 
      Significance: 0.001 

Permutation: free
Number of permutations: 999
```



## Beta diversity | ANOSIM

Analysis of similarities 

```r
plot(MLM.bray.anosim)
```

![](intro-basics_files/figure-html/beta-6-1.png)


## PERMANOVA using `adonis`

Analysis of variance using distance matrices and for fitting linear models to distance matrices

```r
adonis(MLM.otus ~ MLM.env$elevation_m)
```

```

Call:
adonis(formula = MLM.otus ~ MLM.env$elevation_m) 

Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

                     Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)    
MLM.env$elevation_m   1    10.517 10.5173  35.249 0.21592  0.001 ***
Residuals           128    38.192  0.2984         0.78408           
Total               129    48.709                 1.00000           
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

