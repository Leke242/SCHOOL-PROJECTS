library(ggplot2)
library(modeldata)
# the basics
?ggplot2
?diamonds
# modifying basic properties of the plot

View(diamonds)
ggplot(diamonds, aes(x = cut , y =price)) +
  geom_point(color = "red",
            size = 4,
            alpha = 3,
            shape = "square") +
  labs("x =cut", "y =price",
       tittle = diamonds, 
       color ="cut") +
scale_color_brewer(palette = "red") + 
  
#learn more about the options for the geom
  # with ? geom
  # addding another layer
  ggplot(diamonds, aes(x = cut , y =price)) +
  geom_point(color = "red",
             size = 4,
             alpha = 3,
             shape = "square") +
  labs("x =cut", "y =price",
       tittle = diamonds, 
       color ="cut") +
geom_smooth()+
  
 # data 
 carat<- c(0,0.21, 0.22, 0.23, 0.24,0.26, 0.29,.0.30,0.31)
table <-c(61,66,55,64,64,58,62,60,54)
price<-c(337,369,563,361,1013,371,592,1776,586,416)
  
 #df<-data.frame(carat, cut, color, clarity, depth, table, price, x, y, z)
df
  

#export to csv format


write.csv(df,"exportcsv.csv",row.names = FALSE)

#export to xlsx format
install.packages("xlsx")


library(xlsx)
write.csv(df,"exportcsv.csv", row.names = FALSE)
