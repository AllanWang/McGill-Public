# ECSE 429

## Lecture 2 - 2018/09/07

* Mistake - committed error
* Defect - result of a mistake
* Failure - executed defect
* Incident - consequence of failure
* Software testing - exercising software with test cases to gain confidence in the system

* Fault - hypothesized cause of error
    * HW - bit flip due to cosmic particle
    * SW - increment instead of decrement
* Error - erroneous state leading to failure
    * HW - reading faulty memory
    * SW - incorrect variable when faulty statement executes
* Failure - delivered service deviates from correct service
    * HW - robot arm collides with wall
    * SW - result of computation is incorrect
* 9 causes of software defects
    * Faulty requirement definition
    * Client-developer communication failures
    * Deliberate deviations from software requirements
    * Logical design errors
    * Coding errors
    * Non-compliance with documentation & coding instructions
    * Shortcomings of testing process
    * Procedure errors
    * Documentation errors
* Mean time to failure (MTTF) - probability of failure-free operation until specified time
* Mean time between failures (MTBF) - probability system is up at any given time
* Pervasive problems
    * Software commonly delivered late, over budget, and with unsatisfactory quality
    * Validation & verification rarely systematic; not based on well-defined techniques
    * Development process commonly unstable/uncontrolled
    * Quality poorly measured/monitored

## Lecture 3 - 2018/09/12

* Software quality challenges
    * Non tangible 
    * Heavily non linear (5% rule in engineering does not apply)
    * High complexity
* Software quality factors
    * Correctness - accurate output
    * Reliability/availability - first failure, maximum failure rate
    * Efficiency - hardware resources needed to function
    * Integrity - security, access rights
    * Usability/UX - how much training is required to learn and perform a task
    * Maintainability - effort required to identify & fix failures
    * Flexibility - degree of adaptability
    * Testability - support for testing
    * Portability - adaptation to other environments
    * Reusability - component use for other projects
    * Interoperability - ability to interface with other components/systems
* Software quality assurance
    * assuring acceptable level of confidence that software performs as expected
    * assuring acceptable level of confidence that software meets scheduling and budgetary requirements
    * aiding in minimizing cost of guaranteeing quality
* General principles of SQA
    * Know what you <i>are</i> doing
    * Know what you <i>should be</i> doing
    * Know <i>how to measure</i> the difference
* SQA includes defect prevention, detection, and removal
* Continuous Integration (CI) - branch of source code is built and tested whenever changes are committed to the source
* Continuous Deployment - changes are automatically deployed to production without manual intervention
* Continuous Delivery - software can be released to production at any time with as much automation as possible

## Lecture 4 - 2018/09/14

* "Program testing can be used to show the presence of bugs, but never to show their absence" - Dijkstra
* Exhaustive testing is impossible
    * Cannot test all operating conditions/inputs
    * Gain confidence based on incomplete testing
    * Continuity property - small differences in operating conditions may cause drastically different behaviour in software
        * As an example, a bridge that can sustain weight `W` can sustain any weight `w < W`. THe same cannot be said about software
* Early testing saves time & money
* Defects cluster together
* Pesticide paradox - system tends to build resistance to particular testing techniques
    * Executing same tests will not find new bugs
* Testing is context-dependent 
    * Different systems are tested differently (eg aircraft vs mobile app)
* Absence of errors is a fallacy

* Unit test failures are typically fixed directly by the developer. Problems that are submitted typically relate to later stages
* Well tested modules may still fail integration testing

## Lecture 5 - 2018/09/19

* Functional/Black-box testing
    * Tests for requirements/specification
    * Checks for completeness, correctness, appropriateness
    * Should be performed at all levels
* Non-functional testing
    * Tests characteristics of system as a whole
    * Checks for reliability, performance, security, usability
    * Cannot reveal unexpected functionality (not part of spec but implemented)
    * Should be performed at all test levels
* White-box testing
    * Tests based on system's internal structure
    * Checks for completeness, correctness, appropriateness
    * May be performed at all levels, but typically unit or integration level
    * Cannot reveal missing functionality
* Gray-box testing **TODO**
* Oracle & Test coverage **TODO**
* Change-related testing
    * Confirmation testing - confirm original defect is fixed
    * At least failed test needs to be re-executed
    * Regression testing
        * Detect unintended side effects from changes to other portions of code

## Lecture 6 - 2018/09/21

* Static V&V (verification & validation)
    * No execution of work product
        * Manual (reviews), tool-driven (static analysis)
    * Enables early detection
        * No executability needed
        * Can be used on unfinished products
    * Cheaper to remove defects when found early
    * Improves code reviews/spreading knowledge
    * Increases productivity & code maintainability
    * Improves consistency & internal quality of WP (work product)
    * Effectiveness
        * Requirement defects - inconsistencies, contradictions, redundancies
        * Design defects - high coupling
        * Coding defects - undefined variables, variables declared but never used
        * Deviations from code standards
        * Incorrect interface specifications - different units of measurements used
        * Security vulnerabilities - susceptibility to buffer overflows
        * Maintainability defects
* Dynamic testing
    * Requires execution of software
    * Improves externally visible behaviour
* Types of Reviews
    * Informal review
        * Performed by development team (eg agile)
    * Detects potential defects
* Walkthrough
    * Driven by author of work product
    * Finds defects, improves software, considers alternatives
* Technical review
    * Documented process with experts
    * Gain consensus, detects defects
* Inspection
    * Formally documented, external experts and moderators
    * Detects defects, evaluates quality, prevents future defects
    * Roles
        * Moderator
            * Ensures procedures are followed
            * Verifies product readiness for inspection
            * Assembles effective inspection team
            * Keeps inspection on track
            * Verifies criteria are met
        * Recorder (Scribe)
            * Documents all defects
            * Requires technical knowledge
        * Reviewer
            * Analyzes defects in product
            * All participants play this role
        * Reader (presenter)
            * Leads inspection team through inspection by reading aloud small logical units
        * Producer (author)
            * Responsible for correcting found defects
    * Process
        * Planning
            * Identify product
            * Determine if criteria is met
            * Select team, assign roles
            * Set schedule
        * Overview
            * Optional phase where members who are unfamiliar with product receive orientation
        * Preparation
            * Individually look for defects
            * Most defects found during this step
        * Inspection meeting
            * Meet & discuss
            * No resolution attempted; action items assigned
            * Beware of team size and long, detailed presentations
        * Third hour
            * Optional additional time for discussion
            * If actual review needs more than 2 hours, schedule another review session
        * Rework
            * Work product revised by author to correct defects
        * Follow up
            * Meeting between moderator and author to determine of defects have been corrected

## Lecture 7 - 2018/09/26

* Coding guidelines - set of rules on style and best programming practices
    * Industry/domain specific (automotive, avionics)
        * MISRA C (motor industry)
            * Focus on reliability, safety, security
            * Tools: PolySpace, SonarQube, Coverity
            * 143 rules + 16 directives
            * Rules impose requirements on source code
    * Platform specific (Java, C)
    * Organization specific (Google, Microsoft)
* Unreachable code - code that cannot be executed under any condition
* Dead code - code that is reachable but does not affect program behaviour when removed 

## Lecture 8 - 2018/09/28

* Testing
    * Goal - investigate one run of program
    * Outputs pass/fail
* Static analysis
    * Goal - reasons about all runs of program
    * Outputs safe, error, or incomplete
    * Some problems cannot be analyzed (eg halting problem)
* Soundness - if prover says P is true, then P is true
    * Trivially sound: SA says nothing
* Completeness - if P is true, SA will say that P is true
    * Trivially complete: say everything
* Designated properties of SA
    * Precision - minimize false alarms
    * Scalable - be able to analyze large programs
    * Understandability - easily interpretable error reports
* SA Pros
    * May achieve higher coverage than testing
    * May prove absence of defects
    * May find subtle flaws
* SA Cons
    * Limited to functional correctness (no performance check)
    * False alarms/missed errors
    * May be time consuming or non-terminating

## Lecture 9 - 2018/10/03

* White-box testing
    * Focus on system's internal logic
    * Based on system's source code as opposed to specifications
    * (-) May miss functionality of specifications that was not implemented
    * Control-flow graph
        * Nodes - blocks of sequential statements
        * Edges - transfers of controls
        * Nodes with no branches should be grouped together
        * Branching nodes cannot contain assignment
            * Eg `if (i++ == 2)` cannot be in one node
    * Modified condition/decision coverage
        * Each condition must be true & false at least once
        * Must have a pair of test cases where one condition changes, affecting the outcome
        * Requires n + 1 cases

## Lecture 10 - 2018/10/08

// TODO missed 

## Lecture 11 - 2018/10/10

* Data flow graph (DFG) captures flow of definitions
    * Similar to control flow graph
    * c-use - computational use - variable used for assignment, in output, or as a parameter
        * Definition of `A[E]` is typically c-use E, def A
        * Reference to `A[E]` is typically c-use E, c-use A
    * p-use - predicate use - variable use in condition in branch statement
    * k - kill - deallocation 
    * Annotate nodes with def, c-use as needed; annotate edges with p-use
    * du-pair
        * Starts at d (define), ends at u (use)
        * If p-use ends at node after p-use
        * c-use must be def-clear simple path (at most one loop)
        * p-use must be def-clear loop-free path
* Paths go from def to a use case node; p-use are for edges only and are included in the paths
* Mutation testing
    * Given a program, create some mutants (change one node from original)
    * Original test will then run through mutants; if all are detected, then the mutants are dead and the test set is adequate

## Lecture 12 - 2018/10/12

* Project smells
    * Buggy tests
    * Lack of automated tests
    * High test maintenance costs
    * Production bugs
* Test code smells
    * Obscure test - hard to understand
    * Eager test - verifying too much functionality
    * Mystery guest - not able to see cause and effect as logic is outside of test method (eg using external file)
    * General fixture - building/referencing larger fixture than needed to verify functionality (eg comparing entire data vs needed attributes)
    * Hard-coded test data - constants in tests that obscure cause-effect relationship
    * Conditional test logic - tests not always called (eg due to branching)
    * Hard to test - eg highly coupled, asynchronous code
    * Test code duplication - same test code repeated many times
    * Test logic in production - code in production contains logic that should only be in tests
* Behaviour smells
    * Assertion roulette - many assertions in one method; hard to tell which assertion resulted in the failure
    * Erratic test - some tests pass, others fail
        * Possible causes
            * Interacting tests/test suite
            * Resource leakage
            * Resource optimism (depends on external resource, non-deterministic results)
            * Unrepeatable test - behaves differently the first time
            * Test run war - failure when several tests are run simultaneously
    * Fragile tests - tests that fail when SUT is changed in a way that should not affect the part the test is exercising
    * Manual intervention - requires manual action each time it is run
    * Slow tests - take too long to run
* Name test classes and methods to reflect what is being exercised, and general characteristics of input/output values
* Allow code reuse through parameterized tests or test utility methods

## 2018/10/17

* Quiz 1

---

> From this point forth, I will write lectures based on topics and start dates rather than lecture dates.

## Black Box Testing - 2018/10/19

* Black box component testing
    * Testing without inside into details of underlying code
    * Benefits - no need for source code; wide applicability
    * Disadvantage - does not test hidden functions
* EP - Equivalence partitioning
    * To have complete functional testing and avoid redundancy
    * Entire input set covered &rarr; completeness
    * Disjoint classes &rarr; avoid redundancy
    * EC - Equivalence class - behaves the same way, maps to similar output, tests the same thing, reveals the same bugs
    * WECT - weak equivalence class testing - choose one variable value for each equivalence class
    * SECT - strong equivalence class testing - test all interactions; based on Cartesian product
        * Makes an assumption that variables are independent
* Error conditions should likely include both valid and invalid inputs during testing
* Identifying EC (for each external input:)
    * If input is range of valid values:
        * Add one valid EC within range
        * Add two invalid ECs outside each end of range
    * If input is a number
        * Add one valid EC
        * Add two invalid ECs (none and more than N)
    * If input is element from set of valid values
        * Add one valid EC (within set)
        * Add one invalid EC (outside set)
    * If input is condition
        * Add one EC to satisfy condition
        * Add one invalid EC that rejects the condition
    * Consider equivalence partitions to handle defaults, empty, blank, null, zero, none conditions, etc
* Myer's test selection
    * Until all valid ECs have been covered, add a test case that covers as many uncovered valid ECs as possible
    * Until all invalid ECs have been covered, add a test case that covers one and only one uncovered invalid EC
* EP is good in that it needs a small number of test cases, and a higher probability of uncovering defects than with randomly chosen test suites of the same size
* EP is limited in that 
    * Typed language avoid need to check for some invalid inputs
    * Myer's test selection is weak when inputs are dependent
    * Brute-force definitions are impractical when number of inputs is large
* BVA - Boundary value analysis
    * Tests under the assumption that errors tend to occur near extreme values
    * Condition characteristics
        * First/last, start/finish
        * Min/max, under/over, lowest/highest
        * Empty/full
        * Slowest/fastest, smallest/largest, shortest/longest
        * Next-to/farthest-from
        * Soonest/latest
    * Guideline - use values at minimum, just above minimum, nominal value, just below maximum, and maximum
        * Convention: min, min+, nom, max-, max
    * Make every value but one nominal, and let one variable assume extreme values
    * Guidelines can be applied to output conditions, and also sub-boundary conditions (internal to software, eg powers-of-two for data structure sizes)
    * Generally, n variables require 4n + 1 test cases
    * For some robustness, add values beyond boundary, ie min- amd max+. Leads to 6n + 1 test cases
* Worst case testing
    * BVA assumes that failures typically occur with one fault.
    * To account for any combination of faults, use full cartesian product, resulting in 5<sup>n</sup>
    * To extend to robust worst case testing, use 7<sup>n</sup>
* Decision table format 
    * List of conditions and their unique combination of conditions
    * List of resultants and the list of selected actions
    * Allows us to distinguish values that aren't important for a given condition/result. Typically, it means they don't have an effect or are mutually exclusive
* Binary decision trees
    * Each node is a decision and each branch matches the decision result: solid line for true and dashed line for false
    * Leaves are either 0 for false or 1 for true
* ROBDD - reduced ordered binary decision diagrams
    * Compact decision table
    * Omits redundancy by removing conditions with no effects, and by reusing subtrees with the same outputs
    * From binary decision tree
        * If outputs are equal, remove the parent node
        * If child matches another child, keep one and reuse it
    * Shannon expansion
        * Start with f, and replace a single variable with true or false (eg f = a &rarr; f<sub>a</sub>, f<sub><u>a</u></sub>)
        * Generate the new expression by replacing specified variable with its result, and continue. Eventually, we'll know the branches for each variable, and we can generate the decision diagram
    * Test suite can be generated by using every path of a ROBDD. Actions result from the path ending at a `1`.
* Cause-effect modeling
    * Given table, cause-effect table and graph allow us to generate boolean formula and decision table, which leads to test cases
    * We identify causes and effects
    * Potential constraints
        * At least one (I) (ie A &vee; B)
        * At most one (E) (ie &not;A &vee; &not;B)
        * Exactly one (O) (ie A &oplus; B)
        * Masks (M) (ie A &rArr; &not;B)
        * Requires (R) (ie A &rArr; B)
    * Write columns for conditions and columns for effects. This will map relevant conditions to their effects.
    * Generate expressions for each cause based on the necessary effects (use &vee; and &wedge;)
    * Create graph mapping each condition to the effects
    * Results in high-yield test cases
    * Helps identify all possible combinations of causes
    * More restrictive than straight decision tables
    * Points out incompleteness and ambiguities
    * Deriving decision table
        * Add row for each cause or effect
        * Add column for each test case (variant)
        * For each cause, figure out which variants are true and which are false
        * For each effect, see which variants are present and which one are absent
        * Use dash if both values are possible
* To derive logic formulas, generate initial function from cause-effect graph, then transform into minimum DNF (disjunctive normal form) form using boolean algebra laws
* Variable negation
    * Unique true points - variant for each product term such that the product term is true but no other product term is true
    * Near false points - variant for each literal such that the whole function is false, and where a negation to the literal value will render the whole function true

## System Integration

* Bottom up testing - testing leaves and their respective parents until we reach the root (main)
    * No stubs are required
* Top down testing - testing main with stubs for all children, then go down in BFS until leaves are tested (without stubs)
* Risk driven - test based on criticality. Test top down from critical points and then BFS for the remaining nodes.  

## Integration Testing

* Stubs - replaces called module
    * Passes test data for input module
    * Returns test results for output module
    * Must be declared/invoked as real module (same name, parameter, return types, modifier)
    * Stubs can become too complex
* Drivers - used to call tested modules
    * Handles parameter passing and return values
* Strategies
    * Big Bang
        * Non-incremental; integrate all components as a whole
        * Fast for small/stable systems, but does not allow parallel developments and can easily miss interface faults
    * Top-down
        * Test high level components, then called components until lowest-level components
        * Better fault localization, little to no drivers needed, can test in parallel, supports different orders, major design flaws found first
        * Needs lots of stubs and may not adequately test reusable components
    * Bottom-up
        * Test low level then highest level
        * No need for stubs, can test reusable components thoroughly,  can test in parallel
        * Needs drivers, high-level components tested last, no concept of early skeletal system
    * Sandwich
        * Has logic (top down), middle, and operations (bottom up)
    * Risk-driven
        * Integrate based on criticality
    * Function/thread-based
        * Integrate based on threads/functions

## Testing OO Systems

* OO software seems to require more testing than other paradigms
* OO specific constructs
    * Encapsulation of state
    * Inheritance
    * Polymorphism & dynamic binding
    * Abstract classes
    * Exception
* Correctness is now input/output relation as well as object state
* Testing OO methods is only meaningful in relation to other operations and their joint effect on shared state
* New fault models
    * Wrong instance of method inherited
    * Wrong redefinition of attribute
    * Wrong instance of operation called due to dynamic binding
* OO integration levels
    * Functions
    * Classes
    * Basic unit testing - single operation of class
    * Unit testing - methods within lass
    * Intra-class testing
        * Black box/white box
            * Data flow-based testing (across several methods)
        * State-based testing
        * Complex tests with stubs/mocks
    * Cluster integration - integrate two or more classes through inheritance
        * Recommended only with small or stable clusters, where components are tightly coupled
    * System integration - integrate components into single application
* Mock objects - help setup and control stubs; based on interfaces
* Kung et al. Strategy
    * Produces partial ordering of testing levels
    * ORD - object relation diagram
        * Diagram with edges representing inheritance (I), composition (C), and association (A)
    * CFW - identify effects of class change at class level
        * For class X, set of classes that could be affected by change to class X
        * Assuming ORD is not modified, CFW(X) has to include subclasses of X, classes composed with X, and classes associated with X
    * Dynamic relationships not taken into account
    * Abstract classes cannot be tested directly
    * Cyclic ORD
        * Cluster - maximal set of strongly connected nodes
        * Cyclic breaking - removing edges from cluster until graph becomes acyclic
        * Deleting inheritance and composition edges result in stubbing/retesting, whereas removing association will lead to the simplest stub

## System Testing

* Performed after software is assembled
* Check if system satisfies requirements
* Acceptance tests - carried out by customers to verify expectations
    * Alpha testing - performed on systems that may have incomplete features, typically by in-house testing panel
    * Beta testing - end user testing performed within user environment
* System level black-box testing
    * Test cases derived from statement of functional requirements
        * Natural language requirements
        * Use cases
        * Models
        * For each case
            * Develop scenario graph from use cases
            * Determine and rank all possible scenarios
            * Generate and execute test cases from scenarios to meet coverage goal
* TODO p572 - ended with "example: combinatorial method"

## Gray Box Testing

* Testing
    * Test case analyzes one execution trace of system
    * Detects errors but cannot guarantee/prove absence of errors
    * Expensive to design; cheap to execute
* Formal Verification
    * Exhaustively analyzes all possible execution traces of system
    * Can detect errors and guarantee/prove absence of errors
    * Expensive to design; expensive to execute
* Gray-box testing - test based on limited knowledge of internals (eg architecture, state, and UML design models)
* Concrete state - combination of possible values of attributes
    * Can be infinite
* Abstract state
    * Predicates over concrete states
    * One may represent many concrete states
    * Hierarchical
    * Eg overdrawn state checks if concrete balance < 0
* State machines: event(arguments) [condition] /operation(arguments)
* Testing challenges for state machines
    * In code generation, we automate the synthesis of executable code, and ensure that the implementation corresponds to the model
    * In test generate, we automate the synthesis of test cases and test data, and verify that the implementation corresponds to the spec
* Challenges for state-based tests
    * Executability - finding data to execute test sequence (may be undecidable)
    * Scalability- large number of concrete states
    * Missing state model - need to reverse-engineer model
* Fault model
    * Missing/incorrect transitions to valid state based on correct input
        * Eg missing transition, or incorrect end state
    * Missing/incorrect output (action) based on correct input and transition
        * Eg incorrect output, where start and end states are correct
    * Corrupt state - invalid state output
        * Eg transitioning to a new state after correct input
    * Sneak path - transition that takes in unspecified or illegal input
    * Illegal input failure - bad handling of illegal message
        * Ie incorrect output, corrupted state
    * Trap door - accepts undefined messages
* N+ test strategy
    * Reveals
        * All state control faults
        * All sneak paths
        * Many corrupt states
    * Procedure
        * Derive round-trip path tree from state model
            * Flatten state model (remove concurrency & hierarchy)
            * Set root node to initial state
            * Add edge for every transition out of initial node
            * Mark each subsequent leaf as terminal if state it represents has already been drawn, or it is a final state (at most one loop)
            * Repeat until all leaves are terminal
            * Note that structure depends on order in which transitions are traced (breadth or depth first); depth first has fewer but longer test sequences
        * Generate sneak path test cases
        * Sensitize transitions in each test case
* Conformance test cases
    * Shows conformance to explicitly modeled behaviour
    * Each test starts at root adn ends at leaf
    * Oracle is sequence of states and actions
    * Test cases are completed by identifying method parameter values and required conditions to traverse path
    * Run tests by applying sequence to object starting at initial state, then checking intermediary states, final states, and outputs
* Sneak path test cases
    * Shows correct handling of implicitly excluded behaviour
    * Sneak path possible for each unspecified transition, and for guarded transitions that evaluate to false
    * Need to test all states' illegal events; on need to check sneak paths traversing two or more states
    * Check for appropriate action; eg exception handling, error message, etc
    * Also check that resultant state is unchanged

TODO
N+ 691

## Model Checking

* Technique for checking if system model guarantees designated properties of spec
* Formal verification can prove or disprove correctness of system with respect to formal property
* Model checking exhaustively enumerates possible states and transitions of system 
* Formal language required to capture system models and required properties
* Kripke Structures
    * KS = (S, I, R, L)
    * S: states
    * I &subseteq; S: initial states
    * R &subseteq; S x S: transitions
    * L : S &rarr; 2<sup>AP</sup>: labelling
    * Transform from state machine by flattening hierarchy and parallelism, as well as encoding variables in the new states
* Temporal logics
    * Expresses functional requirements
    * Deals with order and occurrences of states
* Classification
    * Linear - individual executions
    * Branching - trees of executions
* TODO CTL Syntax

## Invited Talk

* Identifying Bugs
    * Traditional defect models predict defective modules
        * Given previous releases, attempts to identify areas with more bugs in future releases
        * May not always yield insightful results
        * Require perfect recollection
    * Can identify problematic patches
        * Just in time models trained to predict fix-inducing changes
* Expertise identification
    * Modules with many minor contributors are more likely to be defective
    * Bean plot - comparison between histogram of minor minor contributors in defective modules vs clean modules
* Preempting legal issues
    * Ensuring compliance with license terms of reused components
        * Which source files are enabled?
        * How are they combined? Statically, dynamically?
        * 