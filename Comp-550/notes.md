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

* P(outcome i) = #(outcome i)/#(all events)
* &pi;<sub>i</sub> = P(Q<sub>1</sub> = 1) = #(Q<sub>1</sub> = 1)/#(sentences)
* a<sub>ij</sub> = P(Q<sub>t+1</sub> = j | Q<sub>t</sub> = i) = #(i, j)/#(i)
* b<sub>ik</sub> = P(O<sub>t</sub> = k | Q<sub>t</sub> = i) = #(word k, tag i)/#(i)
* Forward algorithm
    * Uses DP to avoid unnecessary recalculations
    * Create table of all possible state sequences, annotated with probabilities
    * Trellis - table for possible state sequences
* Backward algorithm
    * Trellis with cells &beta;<sub>i</sub>(t)
    * Unlike &alpha;<sub>i</sub>(t), it excludes the current word
* Forward & backward
    * P(O|&theta;) = &Sigma;<sup>N</sup><sub>i=1</sub> &alpha;<sub>i</sub>(t)&beta;<sub>i</sub>(t) for any t = 1 .. T
* Log sum trick - to avoid underflow (from small numbers), work in log domain
* Viterbi algorithm - similar to forward algorithm, but replace summation with max
    * Used to find most likely state sequence
    * Backpointers - keep track of max entry; work backwards to recover best label sequence