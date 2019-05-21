
# Example derived from
# http://topepo.github.io/caret/model-training-and-tuning.html

library(caret)
library(pROC)
library(mlbench)

# Example using the Sonar data set from mlbench
data(Sonar)

# Set a seed for reproducibility
set.seed(998)
# A simple random split of the data: 75% for training, 25% for testing
# Note: caret will further split the training set into analysis and assessment
#       sets during the resampling process in the model training
inTraining <- createDataPartition(Sonar$Class, p = .75, list = FALSE)
training <- Sonar[ inTraining,]
testing  <- Sonar[-inTraining,]


# Step 1. Make a trainControl object
# resampling: 10-fold cross validation repeated 10 times
# performance eval: two class summary metrics (e.g. ROC AUC, sens, spec)
fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 10,
                           ## Estimate class probabilities
                           classProbs = TRUE,
                           ## Evaluate performance using 
                           ## the following function
                           summaryFunction = twoClassSummary,
                           # Print out the training iterations
                           verboseIter = TRUE)


# Step 2. Do the training workflow
# model: svm with a radial kernel
# pre-processing: center and scale features
# model eval: best ROC AUC
set.seed(825)
svmFit <- train(Class ~ ., data = training, 
                method = "svmRadial", 
                trControl = fitControl, 
                preProc = c("center", "scale"),
                tuneLength = 8,
                metric = "ROC")

# Step 3. Review the results and select the "best" model
# The best model per the "metric" specified above is included
# in the fit object
svmFit
plot(svmFit)


# Step 4. Make predictions on new data
testPreds <- predict(svmFit, testing, type = "prob")
testROC <- roc(testing$Class, testPreds$R)
plot(testROC)

