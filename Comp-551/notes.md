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
* 