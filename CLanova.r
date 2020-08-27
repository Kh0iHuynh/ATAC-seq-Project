library(tidyverse)
A = read.table("CLtable.txt", header=TRUE)

mA = A %>% group_by(chr,pos) %>%
        summarize(mC = mean(C), mL = mean(L))

#remove C < 50
A2 = A %>% group_by(chr,pos) %>%
        summarize(mC = mean(C), mL = mean(L)) %>%
        inner_join(A) %>%
        filter(mC > 50) %>%
        select(-mC,-mL)

# recode L= 0 to L =NA and small C to small + 5 small number to work in log space
A3 = A2 %>% mutate(L = na_if(L,0)) %>% mutate(C = log(C+5))
A4 = A2 %>% group_by(chr,pos) %>%  mutate(L = na_if(L,0)) %>% mutate(C = log(C+5)) %>% summarize(mC = mean(C), mL = mean(L,na.rm = TRUE))
write.table(A4,file = "test2.txt",append= FALSE,quote = FALSE,row.names=FALSE)
# -log10(p values) for C
C.LOD = A3 %>% group_by(chr,pos) %>%
        do(out = anova(lm(C~tissue+genotype+tissue:genotype,na.action=na.omit,data=.))) %>%
        mutate(Clog10t = -pf(out[1,3]/out[3,3],out[1,1],out[3,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(Clog10g = -pf(out[2,3]/out[3,3],out[2,1],out[3,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(Clog10tbyg = -pf(out[3,3]/out[4,3],out[3,1],out[4,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(residualC = out[4,3]) %>%
        select(-out)
print(C.LOD)
# -log10(p values) for L
L.LOD = A3 %>% group_by(chr,pos) %>%
        do(out = anova(lm(L~tissue+genotype+tissue:genotype,na.action=na.omit,data=.))) %>%
        mutate(Llog10t = -pf(out[1,3]/out[3,3],out[1,1],out[3,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(Llog10g = -pf(out[2,3]/out[3,3],out[2,1],out[3,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(Llog10tbyg = -pf(out[3,3]/out[4,3],out[3,1],out[4,1],lower.tail = FALSE, log.p = TRUE)/log(10)) %>%
        mutate(residualL = out[4,3]) %>%
        select(-out)
print(L.LOD)
# re-merge and check

LOD = merge(C.LOD,L.LOD)
print(LOD)
round(cor(LOD[,-(1:2)]),2)
plot(LOD[,-(1:2)],pch=".")
write.table(LOD,file = "test.txt",append= FALSE,quote = FALSE,row.names=FALSE)
# this LOD data.frame can now be used for Q-Q plots and other inferences you were trying to make.
