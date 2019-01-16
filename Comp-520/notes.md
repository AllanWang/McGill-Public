# Comp 520

> [Course Website](https://www.cs.mcgill.ca/~cs520/2019/)

## Lecture 2 - 2019/01/09

* A compiler transforms source files (eg in Java, C) into target code (eg x86)
* A scanner transforms source file characters into more meaningful tokens
  * Keyword - eg `if`
  * Variable identifiers - eg `var0`
  * Syntax/structural elements - eg `{`
  * Note that keywords take precedence over any other rules
  * Whitespace is typically ignored
* Language (Comp 330 Review)
  * &Sigma; - alphabet, set of symbols, typically finite
  * Word - finite sequence of symbols from alphabet
  * &Sigma;* - set of all possible words in &Sigma;
  * Language - subset of &Sigma;*
* Regular languages - languages that can be accepted by a DFA, and for which regular expressions exist
* At its core, a regular expression contains
  * &emptyset; - language with no strings
  * &epsilon; - empty string
  * &alpha; for &alpha; &in; &Sigma;
  * | - alternation 
  * &centerdot; - concatenation 
  * \* - zero or more occurrences

## Lecture 3 - 2019/01/11

* Scanners
  * First phase of compiler
  * List of regular expressions; one per token type
  * Internally, transforms regular expressions to DFAs
* Algorithm is to match all DFAs against input
  * Find the longest match
    * If not empty, remove input and return a matching token
    * Otherwise, return input as output
  * If max length is the same for multiple DFAs, first one is typically used
* Rules can use look-aheads to increase match length, even though token length remains unchanged
  * Eg FORTRAN `363.EQ.363`; avoids mattching `363.` as float
* Context-sensitive grammars
  * Eg in C, `(a) * b` is either a type cast or a multiplication if `a` is a type or variable respectively
  * Solution is to either feed semantic language to the scanner, or run multiple passes
* Scanners should have a `.` rule at the end to match any unexpected character if no other rules match
* Line numbers in `flex`
  * Manually counting by matching against `\n`
  * Use `%option yylineno` to get the updated variable
* Scanner actions
  * Do nothing
  * Perform arbitrary computation
  * Return a token
* Scanner efficiency
  * Reduce number of regular expressions; note that keywords are already valid identifiers

## Lecture 4 - 2019/01/14

* Scanner error handler
  * Eg if positive ints cannot start with 0
  * Parser error - check for two consecutive int tokens and fail on match
  * Lexical error - create a new rule capturing all integers (allowing `0` prefix), and throw if rule matches
* Parsers
  * Second phase of compiler
  * Aka syntactic analysis
  * Takes tokens from scanner and generates a parse tree using CFG
  * Pushdown automata - FSM + unbounded stack
    * Used ot recognize CFG
  * CFG - Context-free grammar
    * V - set of variables
    * &Sigma; - set of terminals where V &cap; &Sigma; = &emptyset;
    * R - set of rules, where LHS &in; V & RHS &in; V &cup; &Sigma;
    * S - start variable where S &in; V
    * While DFAs and NFAs are equally powerful, DPDAs do not recognize all CFGs
    * BNF - backus-naur form
    * EBNF

## Lecture 5 - 2019/01/16

* Parse tree - aka concrete syntax tree
  * Built exactly from CFG rules
  * Parent nodes form LHS of readwrite rule
  * Child nodes form RHS of readwrite rules
  * Leaves form parsed input sentence
* Ambiguous grammar
  * Multiple parse tree results
  * Precedence - order of operations
  * Associativity - grouping of operations with same precedence
  * Rewriting grammar
    * Operands must not expand to other operations of lower precedence
    * If left associative, only LHS may expand; if right associative, only RHS may expand
  * Dangling else problem - ambiguous if statements without terminating token; solution in C is to match each `else` with the closest unmatched `if`
  * 