library(readr)
library(dplyr)
library(lme4)
library(tidyr)
print("##############")
print("# SVLI")
print("#############")

data <- read.table("svli.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))


res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(length ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}


PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))


PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))


write.table(PvarM,file="PvarM.svli.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.svli.txt",row.names=FALSE,sep="\t",quote=FALSE)


print("##############")
print("# SVLG")
print("#############")

data <- read.table("svlg.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(length ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}


PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))


PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))


write.table(PvarM,file="PvarM.svlg.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.svlg.txt",row.names=FALSE,sep="\t",quote=FALSE)

print("##############")
print("# SLI")
print("#############")

data <- read.table("sli.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(length ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100* (x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}


PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))


PvarMinTcalc <- function(x)
{
100* (x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))


write.table(PvarM,file="PvarM.sli.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.sli.txt",row.names=FALSE,sep="\t",quote=FALSE)



print("##############")
print("# SLG")
print("#############")

data <- read.table("slg.txt",header = TRUE,sep =" ")
res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(length ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}

PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))

PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))

write.table(PvarM,file="PvarM.slg.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.slg.txt",row.names=FALSE,sep="\t",quote=FALSE)


print("##############")
print("# SVCI")
print("#############")

data <- read.table("svci.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr,peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(coverage ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}

PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))

PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))

write.table(PvarM,file="PvarM.svci.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.svci.txt",row.names=FALSE,sep="\t",quote=FALSE)



print("##############")
print("# SVCG")
print("#############")

data <- read.table("svcg.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(coverage ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}

PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))

PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))

write.table(PvarM,file="PvarM.svcg.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.svcg.txt",row.names=FALSE,sep="\t",quote=FALSE)


##############
# SCI
#############

data <- read.table("sci.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(coverage ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}

PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))

PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))

write.table(PvarM,file="PvarM.sci.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.sci.txt",row.names=FALSE,sep="\t",quote=FALSE)


##############
# SCG
#############

data <- read.table("scg.txt",header = TRUE,sep =" ")

res2 = data %>% group_by(chr, peak_pos,marker_pos) %>% filter(!all(marker == "R")) %>% filter(!all(marker == "A")) %>% filter(!all(marker == "G")) %>% filter(!all(marker == "T")) %>% filter(!all(marker == "C")) %>% filter(!all(marker == "INS")) %>% filter(!all(marker == "DEL")) %>% filter(!all(marker == "."))

res = res2 %>% group_by(chr, peak_pos,marker_pos) %>% do(Model = as.data.frame(VarCorr(lmer(coverage ~ (1|marker) + (1 | marker:tis) + (1|tis) + (1|geno:marker) + (1|tis:geno:marker), data = .)))) %>% unnest(Model)

PvarMcalc <- function(x)
{
100*(x$vcov[x$grp=="marker"]/(x$vcov[x$grp=="marker"]+x$vcov[x$grp=="geno:marker"]))
}

PvarM = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarM = round(PvarMcalc(.))))

PvarMinTcalc <- function(x)
{
100*(x$vcov[x$grp=="marker:tis"]/(x$vcov[x$grp=="marker:tis"]+x$vcov[x$grp=="tis:geno:marker"]))
}

PvarMinT = res %>% group_by(chr,peak_pos,marker_pos) %>% do(data.frame(PvarMinT = round(PvarMinTcalc(.))))

write.table(PvarM,file="PvarM.scg.txt",row.names=FALSE,sep="\t",quote=FALSE)

write.table(PvarMinT,file="PvarMinT.scg.txt",row.names=FALSE,sep="\t",quote=FALSE)
~
~
