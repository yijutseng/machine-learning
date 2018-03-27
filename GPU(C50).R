
library(C50)
np=ceiling(0.1*nrow(sgemm_product))
text.index=sample(1:nrow(sgemm_product),np)
sgemm_product.testdata =sgemm_product[text.index,]
sgemm_product.traindata=sgemm_product[-text.index,]
c=C5.0Control(subset = F,
              bands=0,
              winnow=F,
              noGlobalPruning = F,
              CF=0.25,
              minCases = 2,
              fuzzyThreshold = F,
              sample = 0,
              seed=sample.int(4096,size=1) -1L,
              earlyStopping =T
              )
         aa<-sort.list(as.factor(sgemm_product.traindata[,-5]),partial = NULL, na.last = TRUE, decreasing = FALSE,
                       method = c("quick"))
iris_treeModel <-C5.0((x=aa),y=as.factor(sgemm_product.traindata$Species),
                      control = c)