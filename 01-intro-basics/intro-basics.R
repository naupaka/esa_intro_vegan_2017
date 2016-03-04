#' ---
#' title: "Community data analysis using the vegan package in R"
#' author: "Naupaka Zimmerman "
#' date: "March 4, 2016"
#' output:
#'   ioslides_presentation:
#'     fig_height: 6
#'     fig_width: 7
#'     highlight: tango
#'     keep_md: yes
#'     widescreen: yes
#' ---
#' 
## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(comment = "", cache = TRUE, crop = TRUE)
knitr::knit_hooks$set(crop = knitr::hook_pdfcrop)

#' 
#' 
#' ## Packages installed and loaded?
#' 
## ----load-libraries, eval=FALSE------------------------------------------
## install.packages("vegan", dependencies = TRUE)
## library("vegan")

#' 
#' 
#' ## Loading your OTU table into R
#' 
## ----loading-MLM, results='hide'-----------------------------------------
MLM.otus <- read.csv("data/MLM_data_otus.csv", row.names = 1, header = TRUE)
MLM.env <- read.csv("data/MLM_data_env.csv", header = TRUE)

#' 
#' 
#' 
#' ## Loading your OTU table into R
#' 
## ----loading-MLM-2, results='hide'---------------------------------------
MLM.otus <- read.csv("data/MLM_data_otus.csv", row.names = 1, header = TRUE)
MLM.env <- read.csv("data/MLM_data_env.csv", header = TRUE)

#' 
## ----head-BCI------------------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' # Basic data summarizing
#' 
#' 
#' 
#' ## Summarizing data with `apply()` | sums and sorting
#' 
#' **Sum of rows**
## ----MLM-apply-1---------------------------------------------------------
sum.of.rows <- apply(MLM.otus, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (plots) 

#' 
#' 
#' 
#' ## Summarizing data with `apply()` | sums and sorting
#' 
#' **Sum of rows**
## ----BCI-apply-2---------------------------------------------------------
sum.of.rows <- apply(MLM.otus, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (plots) 

#' **Sum of columns**
## ----BCI-apply-3---------------------------------------------------------
sum.of.columns <- apply(MLM.otus, 2, sum)
sort(sum.of.columns, decreasing = TRUE)[1:3] #top 3 columns (species)

#' 
#' 
#' 
#' ## Summarizing data with `apply()` | sums and sorting
#' 
#' **Number of plots in which each spp. occurs**
## ----MLM-apply-4---------------------------------------------------------
spec.pres <- apply(MLM.otus > 0, 2, sum) 
sort(spec.pres, decreasing = TRUE)[1:18]

#' 
#' 
#' 
#' # Data Transformation
#' 
#' 
#' 
#' ## Basic data transformation
#' 
#' **Square root transformation**
## ----MLM-sqrt------------------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Basic data transformation
#' 
#' **Square root transformation**
## ----MLM-sqrt-2----------------------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.sqrt <- sqrt(MLM.otus)
head(spec.sqrt[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Total**
## ----MLM-decostand-total-------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Total**
## ----decostand-total-2---------------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.total <- decostand(MLM.otus, method = "total", MARGIN = 1) # by rows (sites)
head(spec.total[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Maximum**
## ----decostand-max-1-----------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Maximum** 
## ----decostand-max-2-----------------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.max <- decostand(MLM.otus, method = "max", MARGIN = 2) # by columns (species)
head(spec.max[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Presence-Absence**
## ----decostand-pa-1------------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Presence-Absence**
## ----decostand-pa-2------------------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.pa <- decostand(MLM.otus, method = "pa")
head(spec.pa[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Hellinger (Legendre & Gallagher 2001)**    
#' Square root of method "total"
## ----decostand-hellinger-1-----------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Hellinger (Legendre & Gallagher 2001)**     
#' Square root of method "total"
## ----decostand-hellinger-2-----------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.hellinger <- decostand(MLM.otus, method = "hellinger", MARGIN = 1) # on rows (sites)
head(spec.hellinger[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Wisconsin double standardization**      
#' Shortcut function for standardizing species to maximum, then sites by totals.  
## ----wisconsin-1---------------------------------------------------------
head(MLM.otus[,1:3], n = 3)

#' 
#' 
#' 
#' ## Data transformation in vegan with `decostand()`
#' 
#' **Wisconsin double standardization**    
#' Shortcut function for standardizing species to maximum, then sites by totals.
## ----wisconsin-2---------------------------------------------------------
head(MLM.otus[,1:3], n = 3)
spec.wisc <- wisconsin(MLM.otus)
head(spec.wisc[,1:3], n = 3)

#' 
#' 
#' 
#' # Calculating community distances
#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
#' ### Many different community distance metrics are available in `vegdist()`    
#' *manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*
#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
#' ### Many different community distance metrics are available in `vegdist()`   
#' *manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*
#' 
## ----dist-jacc-1---------------------------------------------------------
spec.jaccpa <- vegdist(MLM.otus, method = "jaccard", binary = TRUE)
# returns an object of class 'dist'
str(spec.jaccpa) 

#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
## ----dist-jacc-2---------------------------------------------------------
as.matrix(spec.jaccpa)[1:4,1:4]

#' 
#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
#' ### How to choose a good one for your data set?  
#' ### First step, read the help for vegdist
## ----vegdist-help, eval=FALSE--------------------------------------------
## ?vegdist

#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
#' ### Second, try `rankindex()`    
#' Higher rank correlations indicate better separation along gradients
## ----rankindex-1---------------------------------------------------------
rank.elev <- rankindex(MLM.env$elevation_m, MLM.otus, indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.elev

#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | so many distance metrics, so little time!
#' 
#' ### Second, try `rankindex()`    
#' Can also use on standardized data
## ----rankindex-2---------------------------------------------------------
rank.elev.wisc <- rankindex(MLM.env$elevation_m, wisconsin(MLM.otus), indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.elev.wisc

#' 
#' 
#' 
#' ## Calculating distances with `vegdist()` | comparison
#' 
## ----rankindex-3---------------------------------------------------------
sort(rank.elev, decreasing = TRUE)
sort(rank.elev.wisc, decreasing = TRUE)

#' 
#' 
#' # Diversity metrics
#' 
#' 
#' 
#' ## Alpha diversity
#' 
#' Basic counts of richness for each plot or site
## ----alpha-1-------------------------------------------------------------
site.richness <- apply(MLM.otus > 0, 1, sum)
site.richness[1:7]

#' 
#' 
#' 
#' ## Alpha diversity | Other metrics
#' 
#' Fisher's alpha
## ----alpha-2-------------------------------------------------------------
site.fisher <- fisher.alpha(MLM.otus)
site.fisher[1:7]

#' 
#' 
#' 
#' ## Alpha diversity | Other metrics
#' 
#' Shannon diversity
## ----alpha-3-------------------------------------------------------------
site.shannon <- diversity(MLM.otus, index = "shannon", MARGIN = 1)
site.shannon[1:7]

#' 
#' 
#' 
#' ## Rarefaction
#' 
#' This is the same as `apply(BCI > 0, MARGIN = 1, sum)`    
#' it gives the species count for each plot
## ----rarefac-1-----------------------------------------------------------
MLM.S <- specnumber(MLM.otus)

#' This finds the plot with the least number of individuals
## ----rarefac-2-----------------------------------------------------------
# could also use rowsums() instead of apply()
MLM.raremax <- min(apply(MLM.otus, 1, sum))

#' 
#' 
#' 
#' ## Rarefaction
#' 
#' Rarefy BCI species matrix to the minimum number of individuals in any plot    
#' and plot the relationship between observed and rarefied counts (plus add 1-1 line)
## ----rarefac-3, fig.height=4---------------------------------------------
MLM.Srare <- rarefy(MLM.otus, MLM.raremax)
plot(MLM.S, MLM.Srare, xlab = "Observed No. of Species", ylab = "Rarefied No. of Species")
abline(0, 1)

#' 
#' 
#' 
#' ## Rarefaction
#' 
#' Put it all together
## ----rarefac-4, fig.height=5.5-------------------------------------------
rarecurve(MLM.otus, step = 20, sample = MLM.raremax, col = "blue", cex = 0.6)

#' 
#' 
#' 
#' ## Beta diversity
#' 
#' Multivariate homogeneity of groups dispersions
## ----beta-1--------------------------------------------------------------
MLM.bray <- vegdist(MLM.otus, method = "bray")
(MLM.bray.bdisp <- betadisper(MLM.bray,group = as.factor(MLM.env$site_ID)))

#' 
#' 
#' 
#' ## Beta diversity {.smaller}
#' 
#' Multivariate homogeneity of groups dispersions
## ----beta-2--------------------------------------------------------------
permutest(MLM.bray.bdisp)

#' 
#' 
#' 
#' 
#' ## Beta diversity
#' 
#' Plot of within-group multivariate dispersion
## ----beta-3, fig.height=4.5----------------------------------------------
plot(MLM.bray.bdisp)

#' 
#' 
#' 
#' ## Beta diversity
#' 
#' Boxplot of within-group multivariate dispersion
## ----beta-4, fig.height=5.5----------------------------------------------
boxplot(MLM.bray.bdisp)

#' 
#' 
#' 
#' ## Beta diversity | ANOSIM
#' 
#' Analysis of similarities 
## ----beta-5, fig.height=4.5----------------------------------------------
(MLM.bray.anosim <- anosim(MLM.bray, MLM.env$site_ID))

#' 
#' 
#' 
#' ## Beta diversity | ANOSIM
#' 
#' Analysis of similarities 
## ----beta-6, fig.height=4.5----------------------------------------------
plot(MLM.bray.anosim)

#' 
#' 
#' ## PERMANOVA using `adonis`
#' 
#' Analysis of variance using distance matrices and for fitting linear models to distance matrices
## ----adonis--------------------------------------------------------------
adonis(MLM.otus ~ MLM.env$elevation_m)

#' 
