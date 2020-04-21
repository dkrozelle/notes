# Statistics overview
library(caret)
# http://topepo.github.io/caret/data-splitting.html

library(reshape2)
data("tips")

tips[['day']] <- as.factor(ifelse(tips$day %in% c("Sat", "Sun"), "weekend", "weekday"))

# split dataset into train and test
train_idx <- createDataPartition(tips$tip, times = 1, p = 0.8, list = F)
tips_train <- tips[train_idx,]
tips_test <- tips[-train_idx,]


tip_model <- lm(tip ~ ., data = tips_train)
summary(tip_model)


tip_model2 <- lm(tip ~ total_bill + size, data = tips_train)
summary(tip_model2)
