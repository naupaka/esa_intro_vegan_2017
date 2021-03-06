#' ---
#' title: "Ordination with vegan"
#' author: "Naupaka Zimmerman"
#' date: "March 3, 2016"
#' output:
#'   ioslides_presentation:
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
#' 
#' # Ordination plots
#' 
#' 
#' 
#' ## Unconstrained ordination
#' 
#' **What does it mean?**
#' 
#' * First we look for major variation, then try to attribute it to environmental variation
#' * vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest
#' 
#' 
#' 
#' ## Unconstrained ordination
#' 
#' **What does it mean?**
#' 
#' * First we look for major variation, then try to attribute it to environmental variation
#' * vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest
#' 
#' **Examples of unconstrained ordination:**
#' 
#' * Correspondance Analysis - CA
#' * Principal Components Analysis - PCA
#' * Principal Coordinates Analysis - PCoA
#' * Nonmetric Multidimensional Scaling - NMDS
#' 
#' 
#' 
#' ## Unconstrained ordination
#' 
#' **What does it mean?**
#' 
#' * First we look for major variation, then try to attribute it to environmental variation
#' * vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest
#' 
#' **Examples of unconstrained ordination:**
#' 
#' * Correspondance Analysis - CA
#' * Principal Components Analysis - PCA
#' * Principal Coordinates Analysis - PCoA
#' * **Nonmetric Multidimensional Scaling - NMDS**
#' 
#' 
#' 
#' ## Before we get started
#' 
#' Housekeeping
## ----housekeeping, eval=FALSE--------------------------------------------
## setwd("your/working/dir")

#' 
## ----loading-1, results='hide'-------------------------------------------
library("vegan")
MLM.otus <- read.csv("data/MLM_data_otus.csv", row.names = 1, header = TRUE)
MLM.env <- read.csv("data/MLM_data_env.csv", row.names = 1, header = TRUE)

#' 
#' ## Before we get started | OTUs
#' 
## ----loading-2-----------------------------------------------------------
dim(MLM.otus)
head(MLM.otus[,1:10], n=1)

#' 
#' 
#' 
#' ## Before we get started | environment
#' 
## ----loading-3-----------------------------------------------------------
head(MLM.env, n=1)

#' 
#' ## Before we get started | environment
#' 
## ----loading-3.5---------------------------------------------------------
summary(MLM.env)

#' 
#' 
#' 
#' ## Basic ordination and plotting
#' 
#' There are two basic NMDS ordination functions:
#' 
#' * `isoMDS()` from the MASS package
#' * `monoMDS()` in vegan
#' 
#' Vegan also has a wrapper function for doing NMDS ordinations using best practices:
#' 
#' * `metaMDS()`
#' 
#' This will do handy things like try to standardize your data if necessary and perform rotation, among other things.
#' 
#' 
#' 
#' ## Basic ordination and plotting
#' 
## ----NMDS-1, results='hide'----------------------------------------------
MLM.bray.ord <- metaMDS(MLM.otus, distance = "bray", k = 2, trymax = 50)

#' 
#' **Show in RStudio**
#' 
#' 
#' 
#' ## Basic ordination and plotting (using all defaults)
#' 
## ----NMDS-2, fig.height=5------------------------------------------------
plot(MLM.bray.ord)

#' 
#' 
#' 
#' 
#' ## Basic ordination and plotting (just plots)
#' 
## ----NMDS-3, fig.height=5------------------------------------------------
plot(MLM.bray.ord, display = "sites")

#' 
#' 
#' 
#' ## Basic ordination and plotting (just species)
#' 
## ----NMDS-4, fig.height=5------------------------------------------------
plot(MLM.bray.ord, display = "species")

#' 
#' 
#' 
#' ## Site names instead of points
#' 
## ----NMDS-5, fig.height=5------------------------------------------------
plot(MLM.bray.ord, display = "sites", type = "t")

#' 
#' 
#' 
#' ## Site names instead of points
#' 
## ----NMDS-5.2, fig.height=5----------------------------------------------
plot(MLM.bray.ord, display = "sites")
set.seed(314) ## make reproducible
ordipointlabel(MLM.bray.ord, display = "sites", scaling = 3, add = TRUE)

#' 
#' 
#' ## Larger points
#' 
## ----NMDS-6, fig.height=5------------------------------------------------
plot(MLM.bray.ord, display = "sites", cex=2)

#' 
#' 
#' ## Modifying the display of the points with environmental data 
#' 
#' * Color
#' * Shape
#' * Size
#' 
#' 
#' 
#' ## Modifying the color of points {.smaller}
## ----NMDS-7, fig.height=4.5, crop = TRUE---------------------------------
colors.vec <- c("red", "blue")
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord, display = "sites", cex=2, pch = 21, 
       col = colors.vec[MLM.env$side_of_island], 
       bg = colors.vec[MLM.env$side_of_island])
legend("topright", legend = levels(MLM.env$side_of_island), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)

#' 
#' 
#' 
#' ## Modifying the shape of points | pch()
## ----NMDS-8, fig.width=11, echo=FALSE------------------------------------
par(mar = rep(0,4))
plot(c(-1, 26), 0:1, type = "n", axes = FALSE)
text(0:25, 0.4, 0:25, cex = 1.5)
points(0:25, rep(0.3, 26), pch = 0:25, bg = "grey", cex = 2)

#' 
#' 
#' 
#' ## Modifying the shape of points {.smaller}
## ----NMDS-9, fig.height=4.5----------------------------------------------
shapes.vec <- c(21, 22)
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord, display = "sites", cex=2, bg = "black", 
       pch = shapes.vec[MLM.env$flow_type])
legend("topright", legend = levels(MLM.env$flow_type), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")

#' 
#' 
#' 
#' ## Modifying the shape and color of points {.smaller}
## ----NMDS-10, fig.height=4-----------------------------------------------
colors.vec <- c("red", "blue")
shapes.vec <- c(21, 22)
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord, display = "sites", cex=2, 
       pch = shapes.vec[MLM.env$flow_type], 
       col = colors.vec[MLM.env$side_of_island], 
       bg = colors.vec[MLM.env$side_of_island])
legend("topright", legend = levels(MLM.env$side_of_island), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)
legend(1.4,1.05, legend = levels(MLM.env$flow_type), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-11, fig.height=5-----------------------------------------------
# Just points
plot(MLM.bray.ord, display = "sites", cex=2)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-12, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", cex=2)
ordihull(MLM.bray.ord, groups = MLM.env$site_ID, label = FALSE)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-13, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", cex=2)
ordihull(MLM.bray.ord, groups = MLM.env$site_ID, label = FALSE, col = "blue")

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-14, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", cex=2)
ordihull(MLM.bray.ord,groups = MLM.env$site_ID, label = FALSE, col = "blue")
ordispider(MLM.bray.ord,groups = MLM.env$site_ID, label = TRUE)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-15, fig.height=5-----------------------------------------------
# Plot first, then add layers
plot(MLM.bray.ord, display = "sites", cex=2)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-16, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", cex=2)
ordispider(MLM.bray.ord,groups = MLM.env$site_ID, label = TRUE)

#' 
#' 
#' 
#' ## Adding other layers - axes scaling
#' 
## ----NMDS-17, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, type = "n")

#' 
#' 
#' 
#' ## Adding other layers - axes scaling
#' 
## ----NMDS-18, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, type = "n")
points(MLM.bray.ord,display = "sites", cex = 2)

#' 
#' 
#' 
#' ## Adding other layers - axes scaling
#' 
## ----NMDS-19, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", type = "n")

#' 
#' 
#' 
#' ## Adding other layers - axes scaling
#' 
## ----NMDS-20, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord, display = "sites", cex = 2)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-21, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord,display = "sites", cex = 2)
ordispider(MLM.bray.ord,groups = MLM.env$site_ID, label = TRUE)

#' 
#' 
#' 
#' ## Adding other layers
#' 
## ----NMDS-22, fig.height=5-----------------------------------------------
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord, display = "sites", cex = 2)
ordiellipse(MLM.bray.ord,groups = MLM.env$site_ID, label = FALSE)

#' 
#' 
#' 
#' ## Adding other layers
## ----NMDS-23, fig.height=5, message=FALSE, results='hide'----------------
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord,display = "sites", cex = 2)
ordisurf(MLM.bray.ord,MLM.env$elevation_m, add = TRUE)

#' 
#' 
#' 
#' ## Vectors in ordination space
#' 
## ----NMDS-24-------------------------------------------------------------
MLM.bray.ord.elev.fit <- envfit(MLM.bray.ord ~ elevation_m, data = MLM.env, permutations = 1000)
MLM.bray.ord.elev.fit

#' 
#' 
#' 
#' ## Vectors in ordination space
#' 
## ----NMDS-25,fig.height=5, results='hide'--------------------------------
plot(MLM.bray.ord, display = "sites", type = "n")
points(MLM.bray.ord,display = "sites", cex = 2)
plot(MLM.bray.ord.elev.fit, add = TRUE)
ordisurf(MLM.bray.ord,MLM.env$elevation_m, add = TRUE)

#' 
#' 
