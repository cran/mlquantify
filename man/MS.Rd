% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MS_method.r
\name{MS}
\alias{MS}
\title{Median Sweep}
\usage{
MS(test, TprFpr)
}
\arguments{
\item{test}{a numeric \code{vector} containing the score estimated for the positive class from
each test set instance.}

\item{TprFpr}{a \code{data.frame} of true positive (\code{tpr}) and false positive
(\code{fpr}) rates estimated on training set, using the function
\code{getTPRandFPRbyThreshold()}.}
}
\value{
A numeric vector containing the class distribution estimated from the test set.
}
\description{
It quantifies events based on testing scores, applying Median Sweep (MS) method, according to
Forman (2006).
}
\examples{
library(randomForest)
library(caret)
cv <- createFolds(aeAegypti$class, 3)
tr <- aeAegypti[cv$Fold1,]
validation <- aeAegypti[cv$Fold2,]
ts <- aeAegypti[cv$Fold3,]

# -- Getting a sample from ts with 80 positive and 20 negative instances --
ts_sample <- rbind(ts[sample(which(ts$class==1),80),],
                   ts[sample(which(ts$class==2),20),])
scorer <- randomForest(class~., data=tr, ntree=500)
scores <- cbind(predict(scorer, validation, type = c("prob")), validation$class)
TprFpr <- getTPRandFPRbyThreshold(scores)
test.scores <- predict(scorer, ts_sample, type = c("prob"))
MS(test = test.scores[,1], TprFpr = TprFpr)
}
\references{
Forman, G. (2006, August). Quantifying trends accurately despite
classifier error and class imbalance. In Proceedings of the 12th ACM SIGKDD
international conference on Knowledge discovery and data mining (pp. 157-166).<doi.org/10.1145/1150402.1150423>.
}
