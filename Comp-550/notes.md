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

## Lecture 10 - 2018/10/04

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

## Lecture 11 - 2018/10/09

* Parsing algorithms
    * Top-down - start at top of tree, expanding downwards with rewrite rules
        * Eg Earley parser
    * Bottom-up - start from input words and build bigger subtrees until a tree spans the whole sentence
        * Eg CYK algorithm, shift-reduce parser
* CYK Algorithm
    * DP algorithm - partial solutions stored & efficiently reused
    * Steps
        * Convert CFG to appropriate form
        * Set up table of possible constituents
        * Fill in table
        * Read table to recover all possible parsers
* CNF Rules
    * A &rarr; B C D becomes A &rarr; X1 D and X1 &rarr; B C
    * A &rarr; s B becomes A &rarr; X2 B and X2 &rarr; s
    * A &rarr; B - replace all B on LHS with A
* Set up table
    * Let sentence have N words, `w[0] ... w[N - 1]`
    * Create table where cell i, j represents phrase spanning from `w[i:j + 1]` 
        * Only need half table since i < j
* Running through table
    * Base case - one word phrase - check all non-terminals
* PCFG - CFG with probabilities for each rule
    * For each nonterminal A &in; N
        * &Sigma;<sub>&alpha; &rarr; &beta; &in; R s.t. &alpha; = A</sub> Pr(&alpha; &rarr; &beta;) = 1
* Extend CYK to PCFG by calculating partial probabilities as you fill the table
    * Only best probability is included per cell
* Train PCFG with treebank, such as WSG
    * Simple version: MLE estimate
        * Pr(&alpha; &rarr; &beta;) = #(&alpha; &rarr; &beta;) / #&alpha;
            * Not great: 
                * No context
                    * Example: NPs in subject and object positions are not identically distributed
                * Too sparse   
                    * WIth the word 'ate', 'ate quickly', 'ate with a fork', 'ate a sandwich', etc are all labelled differently. Should be factorized, eg having an adverbial modifier

## Lecture 12 - 2018/10/11

* Adding context to PCFG
    * Append parent categories (eg `NP^S` &rarr; PRP to `NP^VP` &rarr; PRP)
* Removing context from long chain rule by splitting them into separate rule
    * Eg Pr(VP &rarr; START AdvP VBD NP PP END) to
        * Pr(VP &rarr; START AdvP)
        * Pr(VP &rarr; AdvP VBD)
        * Pr(VP &rarr; VBD NP)
        * Pr(VP &rarr; NP PP)
        * Pr(VP &rarr; PP END)
* Markovization
    * Vertical markovization - adding ancestors as context
        * Zeroth order - vanilla PCFGs
        * First order - one parent only (see above)
        * nth order - add n parents
    * Horizontal markovization - breaking RHS into parts
        * Infinite order - vanilla PCFGs
        * First order - pairs (see above)
        * Can choose any order with interpolations
* Semantics - study of meaning in language
    * Meaning of words - lexical semantics
* Referent - person/thing to which a expression refers
* Extensional definition - all things for which a definition applies, as opposed to intention or comprehension
* Intensional definition - necessary and sufficient conditions to be a telephone
* Multiple words can refer to the same referent. Used in different contexts &rarr; different senses.
    * Example of venus, morning star, evening star, which are all venus
* Hyponym/hypernym - ISA (is a) relationship
    * Monkey & mammal, Montreal & city, wine & beverage, etc. ([hyponym] is a [hypernym])
* Synonym/Antonym - roughly same/different meaning
* Homonymy
    * Homophone - same sound (son vs sun)
    * Homograph - same written form (lead (noun) vs lead (verb))
* Polysemy - multiple related meanings
    * Eg newspaper
        * Daily weekly publication
        * Business that publishes newspaper (meaning above)
        * Physical object that is the product of a newspaper publisher
        * Cheap paper made from wood pulp
* Homonymy is typically with unrelated meaning, whereas polysemy is with related meaning
* Metonymy - substitution of one entity for another related one
    * Eg 
        * Ordering a <u>dish</u> (food, not a physical dish)
        * I work for the local <u>paper</u> (place, not object)
        * <u>Quebec City</u> is cutting our budget again (government, not location)
        * The <u>loonie</u> is at a 11-year low (value, not physical loonie)
    * Synecdoche - specific kind involving whole-part relations
        * All <u>hands</u> on deck
* Holonymy/meronymy - whole part relationships
    * Holonym &rarr; whole, meronym &rarr; part
* Computational approach
    * Heuristic - eg Lesk's
    * Supervised ML - lots of work
    * Unsupervised - eg Yarowsky's
* Lesk's
    * Given a sentence, construct a word bag from definitions of all senses of context words, get the overlaps between each sense and the word in question, then select the one with the highest overlap
* Yarowsky's
    * Gather data set with target word to be disambiguated
    * Automatically label small seed set of examples
    * Repeat for a while
        * Train from seed set
        * Apply model to entire data set
        * Keep highly confident classification outputs to be new seed set
    * Use last model as final model
  
## Lecture 13 - 2018/10/16

* Hearst patterns - pairs of terms in hyponym-hypernym relationships tend to occur in certain lexico-syntactic patterns
    * Can find relations through key words (cause, induce, stem (from), etc)
    * Can find relations through co-occurring words (such as, and, or)
    * Can find relations through words that tend to co-occur with target words
* Term-context matrix
    * Each row is a vector representation of word through context
        * Context can refer to nearest 'x' neighbouring words
* Cosine similarity
    * sim(A, B) = (A &middot; B)/(||A|| ||B||)
    * -1 if vectors point in opposite direction, 0 if orthogonal, 1 if same direction
    * Positive (eg count) vectors are scored within 0 and 1
* Cosine similarity is not enough to determine synonymy
    * High cosine similarity can also indicate antonyms, word senses
* Similarity - synonymy, hypernymy, hyponymy
* Relatedness - anything that might be associated (eg good and bad)
* Cosine similarity is really a measure of relatedness
* Rescaling vectors
    * Pointwise mutual information (PMI)
        * pmi(w<sub>1</sub>, w<sub>2</sub>) = log (P(w<sub>1</sub>, w<sub>2</sub>)/(P(w<sub>1</sub>)P(w<sub>2</sub>)))
        * Numerator - probability of both words occurring
        * Denominator - probability of each word occurring in general
    * If ratio < 1, PMI is negative
        * Often disregarded &rarr; positive PMI (PPMI)
* Compressing term-context matrix 
    * Often very sparse, lots of zeros
    * Singular value decomposition (SVD)
        * X = W x &Sigma; x C<sup>T</sup>
            * m is rank of matrix X
            * Rows of W are new word vectors
            * Rows of C (cols of C<sup>T</sup>) are new context vectors
            * &Sigma; is diagonal matrix of singular values of X (sqrt of eigenvalues of X<sup>T</sup>X, from highest to lowest)
    * Truncated SVD
        * Throw out some singular values (lowest ones) in &Sigma;
    * Word embeddings
        * Neural network models
    * Skip-gram
* Validation
    * Word similarity
        * a : b :: c : d - what is d?
            * Eg man : king :: woman : ? (man is to king as woman is to <u>queen</u>)
        * Solved by assuming vector differences are 0: v<sub>a</sub> - v<sub>b</sub> = v<sub>c</sub> - v<sub>d</sub>
* Can download pretrained word2vec embeddings from web
    * Advantages - trained, large quantity, cheap, easy to try
    * Disadvantages - doesn't always work

## Lecture 14 - 2018/10/18

* Compositionality - meaning of phrase depends on meanings of its parts
    * Idioms often violate compositionality
* Co-compositionality - meanings of words depend also on other words that they are composed with
    * Considering words such as rose, wine, cheeks, red does not combine compositionally, but rather co-compositionally
* Semantic inference - making explicit something that is implicit
    * I want to visit the capital of Italy; capital of Italy is Rome; &therefore; I want to visit Rome
* Montagovian semantics - using logical formalism to represent natural language inferences
* First-order predicate calculus
    * Domain of discourse - set of entities we care about
    * Variables - potential elements of domain
        * Typically lower case
    * Predicates - maps elements of domain to truth values
        * Can be different valences (eg takes multiple elements)
    * Functions - maps elements to other elements
        * Can be different valences
            * Valence 0 function is a constant
    * Logical connectives - &not;, &wedge;, &vee;, &rarr;, &harr;
    * Quantifiers - &exist;, &forall;
* Interpretation of first order logic (FOL)
    * Domain of discourse (D)
    * Mapping for functions to elements of D
    * Mapping for predicates to True or False
    * All students who study and do homework will get an A
        * &forall;x.(study(x) &wedge; hw(x)) &rarr; grade(x) = A
* Lambda calculus - describes computation using mathematical functions
    * Definitions
        * Variables (eg x)
        * &lambda;x.t, t is a lambda term
        * ts, t and s are lambda terms
    * Function application (or beta reduction)
        * Given (&lambda;x.t)s, replace all instances of x in t with expression s
        * Left associative - abcd = ((ab)c)d
        * (&lambda;x.x + y)2 &rarr; 2 + y
        * (&lambda;x.xx)(&lambda;x.x) = (&lambda;x.x)(&lambda;x.x) = &lambda;x.x
    * Allows for partial computations
* Syntax-driven semantic composition
    * Augment CFG with lambda expressions (syntactic composition = function application)
    * Semantic attachments
        * Syntactic composition: A &rarr; a<sub>1</sub> ... a<sub>n</sub>
        * Semantic attachment: {f(a<sub>j</sub>.sem, ..., a<sub>k</sub>.sem)}
    * Proper noun: PN &rarr; COMP550 to {COMP550}
    * Type-raised proper noun: PN &rarr; COMP550 to {&lambda;x.x(COMP550)}
        * We create a function taking in the PN as argument
    * NP rule: NP &rarr; PN to {PN.sem}
    * Common noun: N &rarr; student to {&lambda;x.Student(x)}
        * Type &langle;e, t&rangle;; takes an entity and returns a truth value
    * Intransitive verbs: V &rarr; rules to {&lambda;x.&exist;e.Rules(e) &wedge; Ruler(e, x)}
        * Created an event variable e
    * Composition: S &rarr; NP VP to {NP.sem(VP.sem)}
* Neo-Davidsonian event semantics
    * Method 1: multi-place predicate: Rules(x)
    * Method 2: Neo-Davidsonian version with event variable: &exist;e.Rules(e) &wedge; Ruler(e, x)
        * Reifying event variable makes things more flexible
            * Optional elements such as location and time
            * Can add information to event variable

## Lecture 15 - 2018/10/23

* Neo-Davidsonian semantics cont.
    * Transitive verbs: V &rarr; enjoys to {&lambda;w.&lambda;z.w(&lambda;x.&exist;e.Enjoys(e) &wedge; Enjoyer(e, z) &wedge; Enjoyee(e, x))}
* Note that for quantifiers, universal quantifiers use &rarr;, while existential ones use &wedge;
* Russell (1905)'s Definite descriptions
    * How to represent 'the' in FOL?
        * In "the student took Comp550", we must enforce 
            * An entity who is a student
            * At most one thing referred as a student
            * Student participates in some predicate ("took Comp550")
        * &exist;x.Student(x) &wedge; &forall;y.(Student(y) &rarr; y = x) &wedge; took(x, COMP550
    * Det &rarr; a to {&lambda;P.&lambda;Q.&exist;x. P(ex) &wedge; Q(x)}
    * Det &rarr; the {&lambda;P.&lambda;Q.&exist;x P(x) &wedge; &forall;y(P(y) &rarr; y = x)}
* Scopal ambiguity
    * Eg. Every student took a course
        * every > a: for all students, there exists a course that was taken by that student
        * a > every: there exists a course for which all students took
* Underspecified representation - meaning representation that can embody all possible readings without explicitly enumerating lal of them
* Cooper Storage
    * Associate a store with each FOL so that each reading can be recovered
    * Every student took a course
        * &exist;e.took(e) &wedge; taker(e, s<sub>1</sub>) &wedge; takee(e, s<sub>2</sub>)
            * (&lambda;Q.&forall;x.Student(x) &rarr; Q(x), 1)
            * (&lambda;Q.&exist;y.Course(y) &wedge; Q(y), 2)
        * We do not specify the order of each sub expression
    * Compositional rules now modify the inside part of a store, and introduce new idnex variables 

## Lecture 16 - 2018/10/25

* Coherent - property of discourse that makes sense
    * Contains logical structure/meaning
* Incoherent - eg two completely unrelated sentences
* Cohesion - use of linguistic devices to tie together text units
    * Lexical cohesion - related words in passage
    * Discourse markers - cue words for discourse relations
        * Eg also, and, therefore, however
* Referent - actual entity in the world
* Referring expressions - phrases that refer to the referent
* Referring expressions towards the same referent are said to corefer
* Antecedent - thing that exists before or logically precedes another
* Anaphor - points to an antecedent that precedes it
* Cataphor - points to an antecedent that follows it
* Zero anaphora - ommitting pronouns in certain contexts
    * Languages with this are referred to as pro-drop
    * Eg No habl-o español
    * Others can be dependent on context
* Bridging reference - reference to entities that can be inferred from previously mentioned entity
    * I like my office. <u>The windows</u> are large.
* Non-referential pronouns
    * Pleonastic pronouns 
        * It is raining - not sure what 'it' is referring to
    * Clefting
        * It is he that is Bob - 'it' used to focus on some point
* Pronominal anaphora resolution
    * Relevant info to identify pronouns include gender & number (eg 3Sg), syntactic information, and recency
* C-command - reflexives that must be bound by a subject in certain syntactic relationships
    * Eg 'the students taught themselves', themselves refers to the students, if it was 'them' it would refer to some other group
* Hobb's algorithm
    1. Begin at NP node i mmediately dominating the pronoun
    2. Go to first NP or S above it. Call this node X and the path to it p
    3. Do left to right breadth first traversal of all branches below X to left o p. Propose as antecedent any NP node encountered that has an NP or S between it and X
    4. If X is highest S in sentence, consider parse trees of previous sentences in recency order, and traverse each in left to right breadth first order. When NP encountered, propose as antecendent. If X not highest S, continue to step 5
    5. From X, go to first NP or S above it. Call this node X and path to it p
    6. If X is NP and p doens't pass through Nominal that X immediately dominates, propose X as antecedent
    7. Do left to right breadth first traversal of all branches below X to left of p. Propose any NP encountered as antecedent
    8. If X is S, do left to right breadth first traversal of all branches below X to right of p, but don't go below any NP or S encountered, Propose any NP encountered as antecedent
    9. Go to step 4
* 