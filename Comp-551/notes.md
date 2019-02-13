# Comp 551

> [Course Website](https://www.cs.mcgill.ca/~wlh/comp551/)

## Lecture 1 - 2019/01/08

* 10% weekly quizzes
* 60% projects
* 30% midterm
* 2 hour midterm March 26, 6-8 pm
* Projects in groups of three; can't have same group more than once
* Case studies
  * Computer vision - recognizing faces
  * NLP - machine translation
    * Core principle is representing words as vectors
  * Social recommendations
    * Important to consider ethical implications
  * Game playing - eg AlphaZero
* Supervised learning
  * Classification - eg spam or not spam. Category based
  * Regression - eg output speed for self driving car. Predicting continuous variable
* Unsupervised learning
  * Generation - eg creating synthetic images

## [Reading](https://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf)

* Learning = representation + evaluation + optimization
  * Representation - classification is represented as some formal language that a computer can handle
    * Eg SVM, Naive Bayes, logic programs, neural networks
  * Evaluation determines if a classifier is good or bad
    * Eg Accuracy, squared error, cost/utility margin
  * Optimization - want to find classifier with high evaluation 
    * Eg greedy search, gradient descent, linear programming
* Goal of ML is to generalize beyond examples in training set
* Cross validation - randomly splitting test and training data, avoids overfitting 
* Learners typically don't beat random guessing, but fortunately, most data is not completely random, and assumptions can be made
* Bias - tendency to consistently learn the same wrong thing
* Variance - tendency to learn independently random things
* Regularization term also helps avoid overfitting
  * Eg penalize classifiers with more structure, since larger structures are more likely to overfit
* Multiple testing helps reduce the false discovery rate, caused by unrelated correlation
* Curse of dimensionality - problem increases exponentially as dimensionality increases
  * Adding new features that are unrelated may end up hindering performance, due to the overhead
* Blessing of non-uniformity - to counteract the point above, most applications are not uniform throughout the instance space, but rather concentrated on a lower-dimensional manifold.
  * Ex the set of handwritten digits is typically much smaller than the set of all pixel combinations in images of the same size
* Simplicity does not imply accuracy
  * Given two classifiers with the same training error, the simpler one will likely have the lowest test error
* Not everything representable is learnable
* Correlation does not imply causation

## Lecture 2 - 2019/01/10

* Predictions - classification vs regression
* I.I.D. assumption - Independently and identically distributed
  * Important assumption for training set
* Empirical risk minimization (ERM)
  * Define notion of error 
  * Want to find function that minimized error over training set
* Linear hypothesis 
  * Weight and bias term attached to each variable
* Least square solution method
  * Large coefficient & small standard error &rarr; expect small change in x to have a large effect on y
* Gradient descent
  * Incremental approach to minimizing mean squared error (MSE)
  * Take steps in negative direction of gradient
  * Multiplied by parameter &alpha;, which is the learning rate
  * Keep descending until error is within some acceptable magnitude
* &alpha;<sub>k</sub> are a Robbins-Monroe sequence if
  * &Sigma;<sub>k = 0: &infin;</sub> a<sub>k</sub> = &infin;
  * &Sigma;<sub>k = 0: &infin;</sub> a<sub>k</sub><sup>2</sup> < &infin;
  * Ensures convergence of w<sub>k</sub> to local minimum of error function
  * Example &alpha;<sub>k</sub>
    * 1/(k + 1)
    * 1/2 for k = 1, ..., T
* In non-convex functions, local minima is not always global minima

## Lecture 3 - 2019/01/15

> Linear Regression

* Least square solution w<sub>hat</sub> = (X<sup>T</sup>X)<sup>-1</sup>X<sup>T</sup>T
* Two main failures
  * X<sup>T</sup>X is singular, inverse is undefined
    * Weights may not be uniquely defined - one is linear function of the other
    * Number of features/weights (m) exceeds the number of training examples (n)
  * Simple linear function is a bad fit
* Solutions for failures
  * Pick a better function
  * Use more features
  * Get more data
* Input variables
  * Original quantitative variables
  * Transformation of variables (eg log)
  * Basic expansions
  * Interaction terms (combining multiple variables)
  * Numeric coding of qualitative variables (eg 1, 0 for `true`, `false`)
* Coding variable (feature design)
  * Eg for categorical variables: {blue, red, green, yellow}
    * Cannot introduce four binary variables, as they are perfectly correlated; three false values require the other one to be true
    * Alternative solution is to have three separate binary variables with the last colour being the intercept
* Validation set - compare different models during development
* Test set - evaluate final performance of model
* Two sets must be separate of we may result in "meta"-overfitting
* Hyperparameter - parameter that is not learned but could impact performance
* K-fold cross validation - separate data into many training/validation sets vs just one split
* Leave-one-out cross validation - k-fold cross validation but where each validation set is a single point from training set

## Lecture 4 - 2019/01/17

* Applications of classification
  * Text classification (spam filtering, sentiment analysis)
  * Image classification (face detection, object recognition)
  * Prediction of cancer recurrence 
  * Recommendation systems
* Binary classification - probabilistic approach
  * Discriminative learning - estimate `P(y|x)`
  * Generative learning - model `P(x|y)` and `P(y)`, and use Bayes' rule to estimate `P(y|x)`
* Log-odds ratio: a = ln(P(y = 1|x)/P(y = 0|x))
  * How much more likely is `y = 1` compared to `y = 0`?
  * Modelled with a linear function, as we often don't know the actual values in the real world
* Logistic function: &sigma; = 1/(1 + exp(-a))
* Maximizing likelihood is numerically unstable, as values are extremely small; maximizing log-likelihood is preferred
* Cross-entropy loss - measures number of bits of info required to fix model
  * Minimizing loss = maximizing likelihood

 ## Lecture 5 - 2019/01/22

* For assignment, can use different stopping condition; error is often used
* Descent with sum of squared errors will require a much smaller learning curve than mean error
* Generative learning 
  * More flexible
    *  Eg change P(y) if spammers become more active;  other features are the same
  * Works well with smaller datasets
* Linear Discriminant Analysis (LDA)
  * Assumes
    * Multivariate gaussian, mean &mu; and covariance matrix &Sigma;
    * Different classes have same covariance matrix, &Sigma;
* Quadratic Discriminant Analysis (QDA)
  * Allows different covariance matrices, &Sigma;<sub>y</sub> for each y
  * Note that covariance is m x m, requiring O(m<sup>2</sup>) parameters. Much more costly than logistic regression
* Naive Bayes - assume x<sub>j</sub> are conditionally independent given y
  * P(x<sub>j</sub> | y) = P(x<sub>j</sub> | y, x<sub>k</sub>) for all j, k
  * &Sigma; is diagonal
* Laplace smoothing - add one count per encountered attribute in numerator, and number of attributes to denominator
  * Allows us to give odds greater than 0 for unknown attributes

## Lecture 6 - 2019/01/24

* Classification objectives
  * Select correct model for problem
  * Test performance of new algorithm
  * Evaluate impact on new application
  * Minimize errors
* Not all real world errors are equal
  * Predicting tumor vs passing spam through spam filter
* Most real world data is not 'balanced'; classes are not equally distributed.
  * Can get 99% accuracy by predicting that all emails are not spam, if 99% of emails are not spam
* Accuracy
  * (true positive + true negatives) / total examples
  * (TP + TN) / (TP + FP + FN + TN)
* Precision
  * true positives / total number of declared positives
  * TP / (TP + FP)
* Recall/Sensitivity
  * true positives / total number of actual positives
  * TP / (TP + FN)
* Specificity
  * true negatives / total number of actual negatives
  * TN / (FP + TN)
* False positive rate
  * FP / (FP + TN)
* Type I - false positive (m01)
* Type II - false negative (m10)
* Error rate - (m01 + m10) / m
  * m = m00 + m01 + m10 + m11
* Accuracy alone isn't always useful
* Confusion matrix contains TP, FP, FN, and TN
* Receiver operating characteristic (ROC)
  * 2 classes - blue = negative, red = positive
  * Decision boundary - vertical line marking prediction
  * Changing boundary defines ROC curve, plotting P(FP) to P(TP)
  * Take convex hull to smooth curve
  * Area under curve - AUC
    * Perfect algorithm - AUC = 1
    * Random algorithm - AUC = 0.5
    * Equivalent to probability of ranking random positive example higher than random negative example
* Regression
  * MSE - mean squared error
  * RMSE - root mean squared error
  * MAE - mean absolute error
* Minimize validation error 
  * Simple model 
    * High training error, high test error
    * High bias
  * Complex model 
    * Low training error, high test error
    * High variance

## Lecture 7 - 2019/01/29

## Lecture 8 - 2019/01/31

## Lecture 9 - 2019/02/05


