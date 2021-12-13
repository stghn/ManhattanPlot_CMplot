###
### Sajjad Toghiani
### 13 Dec 2020
### Last Modified: 13 Dec 2020

### A high-quality visualization tool for genomic analysis using SNP panels
### if you want to use the latest version on GitHub:
### source("https://raw.githubusercontent.com/YinLiLin/CMplot/master/R/CMplot.r")
 

rm(list = ls())

## specify the package names and loading them using packman package 
if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(tidyr,dplyr,tidyverse,data.table,RColorBrewer,readr,ggrepel,CMplot)

###########################################################
####### two example datasets bulit-in CMplot package  #####
###########################################################
data(pig60K)      # calculated p-values by mixed linear model (MLM)
data(cattle50K)   # calculated SNP effects by rrblup


#################################################################
####### Draw plot for genomic analysis using CMplot package #####
#################################################################

###------------------------- SNP-density plot -------------------- 
CMplot(pig60K,type="p",plot.type="d",bin.size=1e6,chr.den.col=c("black","yellow", "red"),file="jpg",memo="illumilla_60K",dpi=300,
       file.output=TRUE,verbose=TRUE,width=9,height=6)

CMplot(cattle50K,type="p",plot.type="d",bin.size=1e6,chr.den.col=c("black","yellow", "red"),file="jpg",memo="illumilla_50K",dpi=300,
       file.output=FALSE,verbose=TRUE,width=9,height=6)

###---------------------- Single_track Rectangular-Manhattan plot for GWAS ----------------

########################################################################
######   Amplifying SNP signals with red and green colors    ###########
######   setting the chromosomal colors by two grey type colors  #######
########################################################################

CMplot(pig60K,type="p",plot.type="m",LOG10=TRUE,file="jpg",memo="",dpi=300,
       threshold=c(1e-6,1e-4),col=c("grey30","grey60"),
       threshold.lty=c(1,2), threshold.lwd=c(1,1), threshold.col=c("black","grey"),
       amplify=TRUE,multracks=FALSE,
       chr.den.col=NULL, signal.col=c("red","green"), signal.cex=c(1,1),signal.pch=c(19,19),
       file.output=TRUE,verbose=TRUE,width=14,height=6)

###############################################################################
######     Amplifying SNP signals with original colors of chromosomes  ########
###############################################################################

CMplot(pig60K,type="p",plot.type="m",LOG10=TRUE,file="jpg",memo="",dpi=300,
       threshold=c(1e-6,1e-4),
       threshold.lty=c(1,2), threshold.lwd=c(1,1), threshold.col=c("black","grey"),
       amplify=TRUE,multracks=FALSE,
       chr.den.col=NULL, signal.col=NULL, signal.cex=c(1,1),signal.pch=c(19,19),
       file.output=TRUE,verbose=TRUE,width=14,height=6)

##################################################################
######       Highlight a group of SNPs on Manhattan plot  ########
##################################################################
signal <- pig60K$Position[which.min(pig60K$trait2)]
SNPs <- pig60K$SNP[pig60K$Chromosome==13 & 
                     pig60K$Position<(signal+1000000)&pig60K$Position>(signal-1000000)]

CMplot(pig60K[,c(1:3,5)], plot.type="m",LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col="green",highlight.cex=1,highlight.pch=19,file="jpg",memo="",
       dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)

##################################################################################
#####        Highlight a group of SNPs with similar criteria as a list   #########
#####                    to run on data with all p-value for traits      #########
##################################################################################
SNPs <- list(
  pig60K[pig60K$trait1 < 1e-4, 1],
  pig60K[pig60K$trait2 < 1e-4, 1],
  pig60K[pig60K$trait3 < 1e-4, 1])

CMplot(pig60K,type="p",plot.type="m",LOG10=TRUE,highlight=SNPs,highlight.type="h",
       col=c("grey30","grey60"),highlight.col="darkgreen",highlight.cex=1.2,highlight.pch=19,
       file="jpg",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)


######################################################################
####        Highlight a group of SNPs only on one chromosome    ######
######################################################################
signal <- pig60K$Position[which.min(pig60K$trait2)]
SNPs <- pig60K$SNP[pig60K$Chromosome==13 & 
                     pig60K$Position<(signal+1000000)&pig60K$Position>(signal-1000000)]

CMplot(pig60K[pig60K$Chromosome==13, ], plot.type="m",LOG10=TRUE,col=c("grey60"),highlight=SNPs,
       highlight.col="green",highlight.cex=1,highlight.pch=19,file="jpg",memo="", 
       threshold=c(1e-6,1e-4),threshold.lty=c(1,2),threshold.lwd=c(1,2), width=9,height=6,
       threshold.col=c("red","blue"),amplify=FALSE,dpi=300,file.output=TRUE,verbose=TRUE)

################################################################
###### Add genes or SNP names around the highlighted SNPs   ####
################################################################

SNPs <- pig60K[pig60K[,5] < (0.05 / nrow(pig60K)), 1]
genes <- paste("GENE", 1:length(SNPs), sep="_")
set.seed(666666)

CMplot(pig60K[,c(1:3,5)], plot.type="m",LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col=c("red","blue","green"),highlight.cex=1,highlight.pch=c(15:17), highlight.text=SNPs,      
       highlight.text.col=c("red","blue","green"),threshold=0.05/nrow(pig60K),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)

CMplot(pig60K[,c(1:3,5)], plot.type="m",LOG10=TRUE,highlight=SNPs,highlight.cex=1,highlight.pch=c(15:17), 
       highlight.text=SNPs, highlight.col = NULL,highlight.text.col=NULL,threshold=0.05/nrow(pig60K),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)

###---------------------- Single_track Rectangular-Manhattan plot for Genomic prediction or selection ----------------

##################################################################################################
######    Manhattan plot for SNP effects resylted from Genomic Selection/Prediction(GS/GP) #######
##################################################################################################

SNPs <- cattle50K$SNP[cattle50K$`Fat percentage`> 0.015]

SNPs <- list(
  cattle50K[cattle50K$`Somatic cell score`> 0.015,1],
  cattle50K[cattle50K$`Milk yield`> 0.015,1],
  cattle50K[cattle50K$`Fat percentage`> 0.015,1])

CMplot(cattle50K, plot.type="m", band=0.5, LOG10=FALSE, ylab="SNP effect",ylab.pos =4 ,cex.lab=1,
       threshold=0.015,col=c("grey30","grey60"),multracks=TRUE,
       threshold.lty=2, threshold.lwd=1, threshold.col="grey", amplify=TRUE, width=20,height=6,
       signal.col=NULL, chr.den.col=NULL, file="jpg",memo="",dpi=300,file.output=TRUE,
       verbose=TRUE,cex=0.5,highlight=SNPs, highlight.text=SNPs, highlight.text.cex=0.6,highlight.col = "red")

CMplot(cattle50K, plot.type="m", band=0.5, LOG10=FALSE, ylab="SNP effect",ylab.pos =4 ,cex.lab=1,
       threshold=0.015,multracks=TRUE,
       threshold.lty=2, threshold.lwd=1, threshold.col="grey60", amplify=TRUE, width=20,height=6,
       signal.col=NULL,signal.cex = 0.8, chr.den.col=NULL, file="jpg",memo="",dpi=300,file.output=TRUE,
       verbose=TRUE,cex=0.5,highlight=SNPs, highlight.text=SNPs, highlight.text.cex=1.4,highlight.col = NULL)

