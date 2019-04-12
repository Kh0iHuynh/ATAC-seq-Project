# atacseq


Figure A: plot of raw total count of each samples. Y axis is sample name, x axis is the total count
![](rawtotalcount.jpg)

Figure B: plot of normalized total count for each sample. Y axis is sample name, x axis is total count.
![](normalizedtotalcount.jpg)


Figure C: scatter matrix plot using car package in R to show the scatter plot of raw fragment count for all fragments that are less than 1000 bp in length. The plot shows that all normalized fragment counts between samples have weak relationship and scatters which indicates no normalization. The fragment distributions are different and are also shown in diagonal line of sample names.
![](rawscatterplot.jpg)

Figure C: scatter matrix plot using car package in R to show the scatter plot of normalized fragment count for all fragments that are less than 1000 bp in length. The plot shows that all normalized fragment counts between samples have linear relationship. The fragment distribution after normalization are also shown in diagonal line of sample names.
![](normalizedscatterplot.jpg)
