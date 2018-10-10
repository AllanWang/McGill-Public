# ECSE 429

## Lecture 2 - 2018/09/10

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

// TODO missed

## Lecture 9 - 2018/10/03

* White-box testing
    * Focus on system's internal logic
    * Based on system's source code as opposed to specifications
    * (-) May miss functionality of specifications that was not implemented
    * Control-flow graph
        * Nodes - blocks of sequential statements
        * Edges - transfers of controls
        * Nodes with no branches should be grouped together
    * Modified condition/decision coverage
        * Each condition must be true & false at least once
        * Must have a pair of test cases where one condition changes, affecting the outcome
        * Requires n + 1 cases