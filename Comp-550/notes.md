# Comp 550

> [Course Website]( http://cs.mcgill.ca/~jcheung/teaching/fall-2018/comp550/index.html)

## Lecture 1 - 2018/09/04



## Lecture 2 - 2018/09/06

* Morpheme - subpart of a word that cannot be broken down any further
    * Free morphemes can occur on their own
    * Bound morphemes must occur with other morphemes as parts of words
        * Prefix (before), suffix (after), infix (between), circumfix (around)
* Inflectional morphology - expresses grammatical function required by language
* Derivational morphology - derives a new word, possibly of a different part of speech
* Isolating languages - low morpheme-to-word ratio
* Synthetic languages - high morpheme-to-word ratio
* Computation Tasks
    * Morphological recognition - is this a well formed word?
    * Stemming - cut affixes off to find the stem
    * Morphological analysis
        * Lemmatization - remove inflectional morphology & recover lemma
        * Full morphological analysis - recover full structure

* FSA - finite state automata

## Lecture 3 - 2018/09/11

* Word - smallest unit that can appear in isolation
* Convenient assumption is that words are delimited by spaces
* Word frequency
    * Term frequency: TF(w, S) = #w in corpus S
        * eg TF(<i>cat</i>, the cat sat on the mat) = 1
    * Relative frequency: RF(w, S) = TF(w, S) / |S|
        * eg RF(<i>cat</i>, the cat sat on the mat) = &frac16;
* Corpus - collection of text; used for text to count
* Zipf's Law: f &prop; 1/r
    * Frequency of word type is inversely proportional to rank of word type (by frequency)

## Lecture 4 - 2018/09/13

* Entropy - minimum number of bits needed to communicate some message if we know what probability distribution the message is drawn from
* Cross entropy is for when we don't know the distribution
    * H(p, q) = -&Sigma;<sup>k</sup><sub>i = 1</sub> p<sub>i</sub>log<sub>2</sub>q<sub>i</sub>
    * Estimate: H(p, q) = -(1/N) log<sub>2</sub> q(w<sub>1</sub>...w<sub>N</sub>)
    * Perplexity(p, q) = 2<sup>H(p, q)</sup>
    * Eg: [A B C B B], M: P(A) = 0.3, P(B) = 0.4, P(C) = 0.3
        * q = 0.3 * 0.4</sup>3</sup> * 0.3
        * Perp(M) = 2<sup>-&frac15;log<sub>2</sub>q
* Overfitting - model that is tailored to the training data, making it a poor representation of new data
* OOV - out of vocabulary
* Explicitly modelling OOV items
    * Assign vocabulary items less frequent than some frequency threshold `<UNK>`
    * Treat `<UNK>` as some vocabulary word
    * Use `<UNK>` for unseen words during testing
* Smoothing - shift probability mass to cases that we haven't seen before/are unsure about

## Lecture 5 - 2018/09/18

* Supervised learning - model has access to some input data and corresponding output data (eg a label)
* Unsupervised learning - model has only input data
* Clustering - finding hidden structure in data without labels
* Learning - creating good characterization of data
* Semi-supervised learning - outputs for some inputs but not all
* Grey Area 
    * Specific rules
        * eg anything ending in -ed is a verb
        * Variously called semi-supervised, distantly supervised, minimally supervised, or unsupervised
    * Give seed set
        * eg learning sentiment lexicon; gives positive seeds (good, awesome, great) and negative seeds (bad,  awful, dreadful)
* Regression - y is a continuous outcome
* Classification - y is a discrete outcome
* Linear Regression
* N-grams
    * Aka bag-of-words
    * Versions
        * Presence of absence of an N-gram (1 or 0)
        * Count of N-gram
        * Proportion of total document
        * Scaled versions of counts

## Lecture 6 - 2018/09/20

* Part of speech
    * Identifies some grammatical properties of words
    * Includes
        * Model & auxiliary words - <u>Did</u> the chicken cross the road?
        * Conjunctions - <u>and</u>, <u>but</u>
        * Particles - look <u>up</u>, turn <u>down</u>
* Penn Treebank (PTB) Tagset
* Open class - words tend to be added (neologism)
    * Noun, verb, adjective, etc
* Closed class - new words tend not to be added
    * Pronoun, determiners, quantifiers, conjunctions, modals & auxiliary, preposition
* PTB distinguishes between singular and plural nouns , but not transitive and intransitive verbs

## Lecture 7 - 2018/09/25

* P(outcome i) = #(outcome i)/#(all events)
* &pi;<sub>i</sub> = P(Q<sub>1</sub> = 1) = #(Q<sub>1</sub> = 1)/#(sentences)
* a<sub>ij</sub> = P(Q<sub>t+1</sub> = j | Q<sub>t </sub> = i) = #(i, j)/#(i)
* b<sub>ik</sub> = P(O<sub>t</sub> = k | Q<sub>t</sub> = i) = #(word k, tag i)/#(i)
* Forward algorithm
    * Uses DP to avoid unnecessary recalculations
    * Create table of all possible state sequences, annotated with probabilities
    * Trellis - table for possible state sequences
    * Runtime O(N<sup>2</sup>T)
* Backward algorithm
    * Trellis with cells &beta;<sub>i</sub>(t)
    * Unlike &alpha;<sub>i</sub>(t), it excludes the current word
* Forward & backward
    * P(O|&theta;) = &Sigma;<sup>N</sup><sub>i=1</sub> &alpha;<sub>i</sub>(t)&beta;<sub>i</sub>(t) for any t = 1 .. T
* Log sum trick - to avoid underflow (from small numbers), work in log domain
* Viterbi algorithm - similar to forward algorithm, but replace summation with max
    * Used to find most likely state sequence
    * Backpointers - keep track of max entry; work backwards to recover best label sequence 
* Unsupervised training
    * No state sequences; have to estimate them
    * Initialize params randomly
    * Viterby EM ('Hard EM)
        * Prediction and updates using Viterbi algorithm
    * Soft predictions - probabilities of all possible state sequences

## Lecture 8 - 2018/09/27

* Chunking - find syntactic chunks in sentence; not hierarchical 
* Named-entity recognition (NER) - identify elements in text corresponding to high level categories (eg person, organization, location)
* IOB Tagging - label whether word is inside, outside, or at beginning of span
    * Eg for Org, McGill University would be labelled B I, as both compose a single organization
* Generative models - learn joint distributions P(X, Y)
    * Can be applied to new models, unlike discriminative
* Discriminative models - learn conditional distributions P(Y|X)
* Standard HMM - product of probabilities
    * Forward algorithm - P(X|&theta;)
    * Viterbi algorithm - argmax<sub>y</sub>P(X, y|&theta;)
* Linear-chain conditional random fields (CRF) - Sums over features & time-steps
    * Replaces HMM products by numbers that are not probabilities, but linear combinations of weights & feature values
    * Allows word templates
    * Forward algorithm - Z(X)
    * Viterbi algorithm - argmax<sub>Y</sub>P(Y|X, &theta;)
* To avoid overfitting, make weights close to zero
    * Done be adding an extra term (-&theta;<sub>k</sub>/&sigma;<sup>2</sup>) for regularization

## Lecture 9 - 2018/10/02

* Linear models
    * Includes logistic regressions, support vector machines, etc
    * Cannot learn complex non-linear functions (eg starts with capital and not at beginning of sentence -> proper noun)
* Artificial neural network
    * Automatically learns non-linear functions from input to output
* Feedforward 
    * All connections flow forward (no loops)
    * Each layer of hidden units fully connected to next
* Activation function
    * Linear combination of inputs & weights &rarr; non-linearity
    * Popular choices
        * Sigmoid function
        * Tanh function
        * Rectifier/ramp function: g(x) = max(0, x)
    * Need non-linearity, otherwise we are just transforming a linear function into another linear function
* Loss function 
    * Measures how much error is made during predictions
    * y - correct distribution
    * ŷ - predicted distribution
    * L(y, ŷ) - loss function
* Training
    * Typically by stochastic gradient descent
    * Back propagation - derive new values from error signal back to inputs
* Recurrent neural network
* Long-term dependencies in language
    * Dependencies between words can be arbitrarily far apart
        * Eg look up [x] can be written as look [x] up
    * Cannot easily model with HMMs or LC-CRFs, but possible with RNNs

## Lecture 10 = 2018/10/04

* Syntax 
    * How words can be arranged to form grammatical sentence
    * Invalid sentences are prefixed with `*`
* Constituency
    * Group of words that behave as a unit
        * Noun phrases - three people on the bus, Justin Trudeau
        * Adjective phrases - blue, very good
    * Tests for constituency
        * Check if they can appear in similar syntactic environment
            * Eg I saw [it, three people on the bus, *on the]
        * Can be placed in different positions/replaced as a unit
        * Can be used to answer a questions
* Grammatical relations
    * Subject - tend to come before verbs
    * Direct object - the boy kicked <u>the ball</u>
    * Indirect object - she gave <u>him</u> a good beating
    * Some verbs require different number of arguments
        * Eg relax (subj), steal (subj, dobj), give (subj, iobj, dobj)
* Formal grammar - rules that generate a set of strings that make up a language
    * Format of A &rarr; B
* Constituent tree
    * Trees & sentences generated by previous rules
    * Entries on the LHS of arrow are non-terminals
    * Entries on the RHS of arrows are terminals
*  free grammar (CFG)
    *  4-tuple
        *  N - set of non-terminal symbols
        *  &Sigma; - set of terminal symbols
        *  R - set of rules or productions of form A &rarr; (&Sigma; &cup; N)*, and A &in; N
        *  S - designated start symbol, S &in; N