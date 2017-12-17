 # Comp 361 Midterm Review

## Requirements Elicitation Models

### Domain Model

> Describes problem concepts and relationships

### Use Case Model

> Describes different ways actors interact with the system

* Captures _who_ (actor), _what_ (interaction), and _what purpose_ (goal) without dealing with system internals
    * Note that we may black box our model, and avoid dealing with _how_ actions are executed.
* Completion will detail all possible ways of achieving goals with the system
* A use case is a transaction, typically comprised of
    1. Request from primary actor to system
    1. Validation from system for the request & data
    1. Alteration of an internal state by the system
    1. Response from the system to the actor with a result
* Actor categories
    * Primary - directly interacts with the system
    * Secondary - supports creating values for other actors
    * Facilitator - used by primary/secondary actors to communicate with the system
* System boundary - definition of what separates the system and its environment
    * Important to have a well defined boundary, as it has a large effect on what should be built

#### Use Case Template
-------------
* Use case name
* Scope (affected entities)
* Level (summary, user-goal, subfunction)
* Intention in context (description)
* Multiplicity (scalable situation)
* Primary actor
    * Secondary actors
* Main success scenario
    * Sequence & interaction steps
* Extensions & exceptions
    * Additional/alternative interaction steps
-------------
* Interaction Step either
    * Refers to a lower level use case
    * Describes a base interaction step which
        * *Must* contain the word _System_ and at least one actor
        * Describe an input (actor to system) or output (system to actor) interaction
    * Describes an optional system processing step or communication step in the environment for clarity
* Sub steps are denoted with `.` notation (eg 3.1)
* Alternate steps are denoted with letters (eg 3a)
* Parallelism is denoted with `||`