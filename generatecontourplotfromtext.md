writeout put out1:

write.table(out1,file="test.txt",row.names=FALSE, col.names=FALSE)


data2 <-read.table("test.txt")
data3<-as.matrix(data2)
li <-list(x=data3[,1],y=data3[,2],z=as.matrix(data3[,3:42]))




filled.contour(li,xlab ="mid point distance", ylab = "fragment length",main = "name", color.palette=colorRampPalette(c('white','blue','yellow','green','purple','red','darkred','black')), levels= pretty(range(0,0.0004),200))
