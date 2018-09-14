# ECSE 429

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