library(rpart)
library(rpart.plot)
np=ceiling(0.1*nrow(sgemm_product))
text.index=sample(1:nrow(sgemm_product),np)
sgemm_product.testdata =sgemm_product[text.index,]
sgemm_product.traindata=sgemm_product[-text.index,]
str(sgemm_product)

#for(a in 1:nrow(sgemm_product))

  #{sgemm_product$mvwmn[a]<-mean(c(sgemm_product$VWM[a],sgemm_product$VWN[a]))}
sgemm_product.tree=rpart(mvwmn ~  sgemm_product.traindata$Run1..ms. +sgemm_product.traindata$Run2..ms. +
                           sgemm_product.traindata$Run3..ms. +sgemm_product.traindata$Run4..ms.
  ,method = "class" , data=sgemm_product.traindata    ,control=rpart.control(minsplit=5, maxdepth = 30, cp=0.001)                  
  )
sgemm_product.tree
rpart.plot(sgemm_product.tree) ; text(sgemm_product.tree)
summary(sgemm_product.tree)
#预测用的自变量的数据类型转换成数据框
AR <- data.frame(sgemm_product.testdata$Run1..ms.,sgemm_product.testdata$Run2..ms.,
                 sgemm_product.testdata$Run3..ms.,sgemm_product.testdata$Run4..ms.,sgemm_product.testdata$mvwmn)

p1<-predict(sgemm_product.tree,AR[1:217440,],type = "class")
table(sgemm_product.traindata[,5],predicted= p1 )


#mvwmn.traindata =sgemm_product$mvwmn[-text.index]
#mvwmn.testdata =sgemm_product$mvwmn[text.index]
#test.predict=factor(predict(sgemm_product.tree,sgemm_product.testdata, type = 'class'
#                            ),levels=levels(mvwmn.testdata))

#table.testdata=table(mvwmn.testdata,test.predict)
#table.testdata

