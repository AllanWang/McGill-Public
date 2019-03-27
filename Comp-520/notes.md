# Comp 520 <!-- omit in toc -->

> [Course Website](https://www.cs.mcgill.ca/~cs520/2019/)

- [Acronyms](#acronyms)
- [Intro](#intro)
- [Scanners](#scanners)
- [Parsing](#parsing)
  - [Shift-Reduce Bottom-Up Parsing](#shift-reduce-bottom-up-parsing)
- [Abstract Syntax Tree](#abstract-syntax-tree)
- [JOOS](#joos)
  - [Weeding](#weeding)
  - [Symbol Table](#symbol-table)
- [Type Checking](#type-checking)
- [Virtual Machines](#virtual-machines)
  - [Java Virtual Machine](#java-virtual-machine)
- [{Bite}Code Generation](#bitecode-generation)
- [Optimization](#optimization)
- [Midterm Review](#midterm-review)
- [Garbage Collection](#garbage-collection)
  - [Reference Counting](#reference-counting)
  - [Mark & Sweep](#mark--sweep)
- [Runtime Deallocation](#runtime-deallocation)
- [Virtual Machines (VirtualRISC)](#virtual-machines-virtualrisc)
- [Native Code Generation](#native-code-generation)

## Acronyms

| | |
|---|---|
| AOT | Ahead Of Time compilation |
| AST | Abstract Syntax Tree |
| CST | Concrete Syntax Tree |
| GC | Garbage Collection |
| IL | Intermediate Language |
| IR | Intermediate Representation |
| JIT | Just In Time compilation |
| JVM | Java Virtual Machine |
| LALR | Look Ahead Left-to-right Right derivation |
| LL | Left-to-right Left derivation |
| LR | Left-to-right Right derivation |
| LSP | Local Stack Pointer |
| PC | Program Counter |
| SP | Stack Pointer |
| VM | Virtual Machine |

## Intro

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

## Scanners

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

## Parsing

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
  * Look Ahead Left-to-right Rightmost derivation parser (LALR)
    * Bottom up
    * Eg yacc + bison (LALR(1)), SableCC
  * Left-to-right Leftmost-derivation parser (LL)
    * Top down 
    * For LL(k), look k tokens ahead and determine when to reduce
    * Note that not all grammars are LL(k) for any fixed k
    * Some rules require unbounded lookahead
    * Recursive Descent Parsers
      * Repeatedly expand left non-terminal
        * If one occurrence, use rule
        * If multiple, there's a conflict
        * If none, there's an error
      * Problematic when rules have same prefixes of length greater than the lookahead count
        * Resolved by factoring the grammar
        * Eg `if then end`, `if then else end` becomes `if then ifend`, where `ifend` &rarr; `end | else end` 
      * Left recursion also a problem. A &rarr; A &beta; | &epsilon; expands to &epsilon; | A | A &beta; | A &beta; &beta; ...

---

### Shift-Reduce Bottom-Up Parsing

* Two token collections, one for input stream and one for stack representation
* Shift - place token from stream to stack; more symbols are needed before applying rule
* Reduce - replace multiple symbols on stack with single symbol according to grammar
* Accept - when start symbol (`S'`) is on the stack
* Using a table, effectively like LR parsing but in reverse
* Deciding between shift and reduce
  * Implemented as stack of states; represents top content without caring about sub contents

## Abstract Syntax Tree

* Parsing conflicts
* Resolving conflicts
  * For operations with same precedence & left associativity, prefer reducing
  * When reduction contains operation of lower precedence than lookahead token, prefer shifting
* Compiler architecture
  * One-pass compiler - scans only once
    * Prevents modularity and limits optimization
    * Historically good as it's fast and space efficient
  * Multi-pass compiler - 5-15 phases
    * Requires intermediate representation (IR) of program
* Abstract syntax tree (AST)
  * Only important terminals kept
  * Tree is not language dependent
* Building IRs
  * Extend parser & execute semantic actions
  * Semantic actions - arbitrary actions executed during parser execution
  * Semantic values 
    * Terminals - provided by scanner
    * Non-terminal - created by parser
* Building IRs
  * Extends parser
  * Executes semantic actions during process
  * Values are terminal (provided by scanner) or non-terminal (created by parser)
* LALR(1)
  * Left recursion, for efficiency

## JOOS

* Subset of Java
* Types - boolean, int, char, external (Object, Boolean, Integer, String, etc)
* Expressions - evaluate to a value
  * Constants, variables, binary op, unary op, class creation, expression cast, method invocation
* Statements - no associated values
  * Expression statements, blocks, control (if, while), return

### Weeding 

* If we wish to create certain constraints (ie avoid division by 0), updating the parser will double the code
* Instead, we can weed out exceptions by parsing invalid code and running pass-throughs afterwards
* Can also be used in more complicated cases, like distinguishing casting or parentheses around expressions.

### Symbol Table

* Semantic analysis - analyzes meaning of program
  * Symbol table - analyzes variable definitions & uses
    * Maps identifier to meanings
* Used in JOOS for
  * Class hierarchy - what classes, inheritance
  * Class members - what fields, what methods, signatures
  * Identifier - when defined, when used
  * Type checking - analyzes expression types & uses
* Previously, var declarations were done in one pass. In this case, we wouldn't be able to use elements in the global scope until they were defined
* Identifiers in the same scope can be unique, but can shadow parent scopes
* Dynamic scoping - uses program state to resolve symbols
* Mutual recursion 
  * Requires two traversals, one to collect definitions and another to collect uses

## Type Checking

* Type annotations are invariant about the run-time behaviour
* Rules
  * Declaration - introduce variables
  * Propagation - expression type determines enclosing expression type
  * Restrictions - expression type constrained by usage context
  * Logical rules 
    * (&Gamma; &vdash; P) / ( &Gamma; &vdash; C) - if P is provable under context &Gamma;, then C is provable under context &Gamma;
    * &Gamma; &vdash; E : T - under context &Gamma;, it is provable that E is well typed with type T
    * (&Gamma; [x &#8614; T] &vdash; S) / (&Gamma; &vdash; x; S) - modify context
    * (&Gamma;(x) = T) / (&Gamma; &vdash; x : T) - access context
  * L - class library
  * C - current class
  * M - current method
  * V - variables
* Type proof
  * Internal nodes are inferences
  * Leaves are axioms or true predicates
  * Program is statically type correct iff it is root of some type proof

## Virtual Machines

* Ahead of time compilation (AOT) - source code to machine code before execution
  * Advantages
    * Fast execution
    * Allows optimization
    * Intermediate languages facilitate code generation for target architectures
  * Disadvantages
    * Runtime information ignored
    * Code generator must be built
  * Virtual machines
    * Not tied to any architecture
    * Delays generating native code until execution time
* Interpreted - instructions read one at a time; not compiled
  * Advantages
    * Easy to generate virtual machine code
    * Code is architecture independent
    * Bytecode can be more compact
  * Disadvantages
    * Poor performance
* Just in time (JIT) - generate native code during program execution
  * Advantages
    * Target specific architectural details
    * Observe program properties at runtime
    * Efficiently allocate optimization time towards important methods
  * Disadvantages
    * Program performance depends on compile time
* Abstract machine - intermediate language

---

### Java Virtual Machine
* `.class` files
  * Magic number (`0xCAFEBABE`)
  * Minor version/major version
  * Constant pool
  * Access flags
  * This class
  * Super class
  * Interfaces
  * Fields
  * Methods
  * Attributes
* Java class loaders
  * Extend `java.lang.ClassLoader`
  * Allow for loading classes from other sources & transforming classes during loading
* Consists of
  * Memory
    * Stack (function call frames)
      * Call stack (function call frames)
        * Reference to constant pool
        * Reference to current object (`this`) if any
        * Method arguments
        * Local variables
        * Local stack for intermediate results (baby stack)
      * Baby/operand/local stack - operands & results from instructions
    * Heap (dynamically allocated memory)
    * Constant pool (shared constant data)
    * Code segment (JVM instructions of currently loaded class files)
  * Registers
    * No general purpose registers
    * Stack pointer (`sp`) pointing to top of stack
    * Local stack pointer (`lsp`) points to location in current stack frame
    * Program counter (`pc`) points to current instruction
  * Condition codes
  * Execution unit
* Data Types
  * Primitives - boolean, integral (byte, short, int, ...), floating, internal
  * Reference - class, array, interface
* Jasmin Code
  * Z - boolean
  * F - float
  * I - int
  * J - long
  * V - void
  * Reference types represented by fully qualified names
  * Methods
    * Signature - `.method <modifiers> <name>(<parameter types>) <return type>`
    * Stack limits `.limit stack <limit>`, `.limit locals <limit>`
    * Method body
    * Termination line `.end method`
* JVM contains 256 instructions for arithmetic ops, constant loading, local operations, branch operations, stack operations, class operations, and method operations
  * Unary arithmetic ops
    * `ineg` - negate
    * `i2c` - to char, `% 65536`
  * Binary arithmetic ops 
    * `iadd`
    * `isub`
    * `irem`
  * Direct ops 
    * `iinc k a` - `local[k] += a`
  * Constant loading
    * `iconst_0` - load 0
    * `aconst_null` -load `null`
    * `ldc_int i` - load `int`
  * Local ops 
    * `iload k` - add `local[k]` to stack
    * `istore k` - pop stack and store to `local[k]`
    * `aload`, `astore`, counterparts for references
  * Field ops
    * `getfield f sig`, `putfield f sig`, modify fields of objects using value from stack.
  * Branch ops
    * `goto L` 
    * `ifeq L`, `ifgt L`, `ifnonnull L` - reads first stack value
    * `if_icmpeq_L` - compares top two elements
  * Stack ops
    * `dup` - repeat stack value
    * `pop`
    * `swap`
    * `nop` - does nothing
  * Class ops
    * `new C` - allocate space
    * `invokespecial C/<init>()V` - execute constructor
    * `instance_of C` - puts 0 or 1 on stack
    * `checkcast`
  * Method ops
    * `invokevirtual m sig` - calls method taking in `o` (self) plus all args
    * `ireturn`, `return`
* Java Class Loading
  * `ClassLoader` finds class and checks that method exists
  * If method not loaded, it is verified
  * Method body is interpreted
  * If executed multiple times, bytecode is translated to native code
  * If method becomes hot, native code is optimized
* Bytecode verification syntax
  * First 4 bytes should be `0xCAFEBABE`
  * Bytecodes should be syntactically correct
    * All instructions complete
    * Branch targets within code segment
    * Only legal offsets referenced
    * Constants have appropriate types
    * Execution must return
  * Stack (Important)
    * Should be same size along all execution paths
    * Should have the same types along 
* Resource offsets
  * For variables that can never exist together (same scope level), we can reuse offsets and lower our limit
  * Extra slot required for non-static method
* Labels
  * `if` - 1 label
  * `ifelse` - 2 labels
  * `while` - 2 labels
  * `||` and `&&` - 1 label (short circuit)
  * `==` ,`<`, `>`, `<=`, `>=`, and `!=` - 2 labels (like `ifelse` branching, as we are not saving a value in the stack)
  * `!:` - 2 labels
  * `toString` coercion - 2 labels

## {Bite}Code Generation

* Code templates allow code generation from AST, without worrying about surrounding context
  * Simple, recursive strategy 

| Template | Jasmin |
| --- | --- |
| if (**E**) **S** | **E** <br> ifeq stop <br> **S** <br> stop: |
| if (**E**) **S_1** else **S_2** | **E** <br> ifeq else <br> **S_1** <br> goto stop <br> else: <br> **S_2** <br> stop: |

## Optimization

* Focus on 
  * Reducing execution time
  * Reducing code size
  * Reducing power consumption

## Midterm Review

* Compiler phases
  * Scan - chars to tokens
  * Parse - tokens to syntax tree
  * Weed - rejects invalid trees (syntax)
  * Symbol - tracks context
  * Type - AST to AST + types; rejects programs that are semantically correct but syntactically wrong
  * Resource
  * Code
  * Optimize
  * Emit
* Type checking definitions
  * a / b - if a then b
  * a &vdash; b - if under the assumptions of a, then b is provable
  * a : b - a has type b

## Garbage Collection

* Memory allocation
  * In stack
    * Function call info, local variables, return values
    * Allocated & deallocated at beginning & end of function
    * Contains fixed size data
    * Contains constant pool, local vars, baby stack
    * Memory allocation is easy
  * In heap
    * Dynamic - unknown size & time
    * Requires runtime support for managing heap space
  * Data never point from stack to heap
  * Heap deallocation
    * Manual - user code
      * Advantages
        * Reduces runtime complexity
        * Programmer has full control
        * May be more efficient
      * Disadvantages
        * Requires extensive effort
        * Error prone
        * Often less efficient
          * Can free larger blocks at once
    * Continuous - determined on the spot
    * Periodic - interval checks
* When are records dead?
  * Ideally, when they are never accessed again, but this is undecidable
  * Conservative assumption - if they are no longer used within stacks; dead records may still be referenced from other dead records

### Reference Counting

* Continuous GC
* Extra field to track pointers
* Dead when reference count is 0
* Disadvantage
  * Cyclic references don't get GC'd

### Mark & Sweep

* Periodic GC
* Mark - mark if encountered
* Sweep - go through all records and reclaim unmarked once
  * Unmark all marked records as we go
* Assumes that
  * We know the size of each record
  * We know which fields are pointers
* Can run in parallel
* Disadvantage
  * Scanning can be expensive
  * Heap may become fragmented

## Runtime Deallocation 

<b>TODO</b>

## Virtual Machines (VirtualRISC)

<b>TODO (Slides 1-20)</b>

* JOOS Code executes through
  * Interpreter
  * Ahead-of-time compiler
    * Translate directly to native code
    * Not as useful for Java/JOOS
      * Method code fetched as needed
      * Needs to allow code across internet
      * Should support different native code sets
  * Just-in-time compiler
    * Merge interpreters with traditional compilation techniques
    * When method is invoked for the first time
      * Bytecode fetched
      * Translated into native code
      * Control given to generated code
    * Needs to be fast to be useful

## Native Code Generation

* Important problems
  * Instruction selection - choose correct instructions from native code instruction set
  * Memory modelling - decide where to store variables & allocate registers
  * Method calling - determine calling conventions
  * Branch handling - allocate branch targets
* Map locals/stacks to frame
  * Stack memory can be arbitrarily large, but is limited by hardware `ulimit -a`
  * Registers are very limited, usually much less than number of program variables
  * Want to allocate as many variables in register as possible
  * Liveness analysis
    * Variable is live if it can be read in the future
    * Undecidable, but can be approximated
* TODO
* Fixed register allocation
  * m registers to first m locals
  * n registers to first n stack locations
  * k scratch registers
  * Spill remaining locals & locations into memory
  * Registers allocated once, and does not change
  * No difficult control flow paths
  * Wastes registers, and assumes first locals/stack locations are more important