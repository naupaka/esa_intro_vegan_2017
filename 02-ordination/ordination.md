# Ordination with vegan
Naupaka Zimmerman and Gavin Simpson  
August 8, 2015 • ESA 2015  





# Ordination plots



## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest



## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest

**Examples of unconstrained ordination:**

* Correspondance Analysis - CA
* Principal Components Analysis - PCA
* Nonmetric Multidimensional Scaling - NMDS



## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest

**Examples of unconstrained ordination:**

* Correspondance Analysis - CA
* Principal Components Analysis - PCA
* **Nonmetric Multidimensional Scaling - NMDS**



## Before we get started

Housekeeping

```r
setwd("your/working/dir")
```


```r
library("vegan")
data(dune)
data(dune.env)
```
Data from: Jongman, R.H.G, ter Braak, C.J.F & van Tongeren, O.F.R. (1987). Data Analysis in Community and Landscape Ecology. Pudoc, Wageningen.



## Before we get started | species


```r
dim(dune)
```

```
[1] 20 30
```

```r
head(dune[,1:10], n=3)
```

```
  Achimill Agrostol Airaprae Alopgeni Anthodor Bellpere Bromhord Chenalbu
1        1        0        0        0        0        0        0        0
2        3        0        0        2        0        3        4        0
3        0        4        0        7        0        2        0        0
  Cirsarve Comapalu
1        0        0
2        0        0
3        0        0
```



## Before we get started | environment


```r
head(dune.env, n=3)
```

```
   A1 Moisture Management      Use Manure
1 2.8        1         SF Haypastu      4
2 3.5        1         BF Haypastu      2
3 4.3        2         SF Haypastu      4
```

```r
summary(dune.env)
```

```
       A1         Moisture Management       Use    Manure
 Min.   : 2.800   1:7      BF:3       Hayfield:7   0:6   
 1st Qu.: 3.500   2:4      HF:5       Haypastu:8   1:3   
 Median : 4.200   4:2      NM:6       Pasture :5   2:4   
 Mean   : 4.850   5:7      SF:6                    3:4   
 3rd Qu.: 5.725                                    4:3   
 Max.   :11.500                                          
```



## Basic ordination and plotting

There are two more basic NMDS ordination functions:

* `isoMDS()` from the MASS package
* `monoMDS()` in vegan

Vegan also has a wrapper function for doing NMDS ordinations using best practices:

* `metaMDS()`

This will do handy things like try to standardize your data if necessary and perform rotation, among other things.



## Basic ordination and plotting


```r
dune.bray.ord <- metaMDS(dune, distance = "bray", k = 2, trymax = 50)
```

**Show in RStudio**



## Basic ordination and plotting (using all defaults)


```r
plot(dune.bray.ord)
```

![](ordination_files/figure-html/NMDS-2-1.png) 




## Basic ordination and plotting (just plots)


```r
plot(dune.bray.ord, display = "sites")
```

![](ordination_files/figure-html/NMDS-3-1.png) 



## Basic ordination and plotting (just species)


```r
plot(dune.bray.ord, display = "species")
```

![](ordination_files/figure-html/NMDS-4-1.png) 



## Site names instead of points


```r
plot(dune.bray.ord, display = "sites", type = "t")
```

![](ordination_files/figure-html/NMDS-5-1.png) 



## Site names instead of points


```r
plot(dune.bray.ord, display = "sites")
set.seed(314) ## make reproducible
ordipointlabel(dune.bray.ord, display = "sites", scaling = 3, add = TRUE)
```

![](ordination_files/figure-html/NMDS-5.2-1.png) 



## Site names instead of points


```r
plot(dune.bray.ord, display = "species")
set.seed(314) ## make reproducible
ordipointlabel(dune.bray.ord, display = "species", scaling = 3, add = TRUE)
```

![](ordination_files/figure-html/NMDS-5.5-1.png) 



## Site names instead of points


```r
plot(dune.bray.ord)
set.seed(314) ## make reproducible
ordipointlabel(dune.bray.ord, scaling = 3, add = TRUE)
```

![](ordination_files/figure-html/NMDS-5.6-1.png) 




## Larger points


```r
plot(dune.bray.ord, display = "sites", cex=2)
```

![](ordination_files/figure-html/NMDS-6-1.png) 



## Modifying the display of the points with environmental data 

* Color
* Shape
* Size



## Modifying the color of points {.smaller}

```r
colors.vec <- c("red", "blue", "orange", "grey")
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, pch = 21, 
       col = colors.vec[dune.env$Management], 
       bg = colors.vec[dune.env$Management])
legend("topright", legend = levels(dune.env$Management), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)
```

![](ordination_files/figure-html/NMDS-7-1.png) 



## Modifying the shape of points | pch()
![](ordination_files/figure-html/NMDS-8-1.png) 



## Modifying the shape of points {.smaller}

```r
shapes.vec <- c(21, 22, 24)
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, bg = "black", 
       pch = shapes.vec[dune.env$Use])
legend("topright", legend = levels(dune.env$Use), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")
```

![](ordination_files/figure-html/NMDS-9-1.png) 



## Modifying the shape and color of points {.smaller}

```r
colors.vec <- c("red", "blue", "orange", "grey")
shapes.vec <- c(21, 22, 24)
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, 
       pch = shapes.vec[dune.env$Use], 
       col = colors.vec[dune.env$Management], 
       bg = colors.vec[dune.env$Management])
legend("topright", legend = levels(dune.env$Management), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)
legend(1.4,1.05, legend = levels(dune.env$Use), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")
```

![](ordination_files/figure-html/NMDS-10-1.png) 



## Adding other layers


```r
# Just points
plot(dune.bray.ord, display = "sites", cex=2)
```

![](ordination_files/figure-html/NMDS-11-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![](ordination_files/figure-html/NMDS-12-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
```

![](ordination_files/figure-html/NMDS-13-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![](ordination_files/figure-html/NMDS-14-1.png) 



## Adding other layers


```r
# Plot first, then add layers
plot(dune.bray.ord, display = "sites", cex=2)
```

![](ordination_files/figure-html/NMDS-15-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![](ordination_files/figure-html/NMDS-16-1.png) 



## Adding other layers - axes scaling


```r
plot(dune.bray.ord, type = "n")
```

![](ordination_files/figure-html/NMDS-17-1.png) 



## Adding other layers - axes scaling


```r
plot(dune.bray.ord, type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
```

![](ordination_files/figure-html/NMDS-18-1.png) 



## Adding other layers - axes scaling


```r
plot(dune.bray.ord, display = "sites", type = "n")
```

![](ordination_files/figure-html/NMDS-19-1.png) 



## Adding other layers - axes scaling


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex = 2)
```

![](ordination_files/figure-html/NMDS-20-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![](ordination_files/figure-html/NMDS-21-1.png) 



## Adding other layers


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex = 2)
ordiellipse(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![](ordination_files/figure-html/NMDS-22-1.png) 



## Adding other layers

```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
ordisurf(dune.bray.ord,dune.env$A1, add = TRUE)
```

![](ordination_files/figure-html/NMDS-23-1.png) 



## Vectors in ordination space


```r
dune.bray.ord.A1.fit <- envfit(dune.bray.ord ~ dune.env$A1, permutations = 1000)
dune.bray.ord.A1.fit
```

```

***VECTORS

              NMDS1   NMDS2     r2  Pr(>r)  
dune.env$A1 0.99008 0.14052 0.3798 0.01499 *
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
Permutation: free
Number of permutations: 1000
```



## Vectors in ordination space


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
plot(dune.bray.ord.A1.fit, add = TRUE)
ordisurf(dune.bray.ord,dune.env$A1, add = TRUE)
```

![](ordination_files/figure-html/NMDS-25-1.png) 




## Activity

Using the cleaned `varespec` data from the last exercise, and based on your finding of an appropriate distance metric:

1. Load the data
2. Create an NMDS plot using `metaMDS()`
    * use the distance metric you chose earlier
        * if this doesn't work, `bray` is a decent fallback
    * Plot only the sites (not the species)
    * Make the points blue squares, size (cex = 2)
    * Add an `ordispider`
    * add a title with `main = "title"`
