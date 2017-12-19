# Comp 361 Midterm Review

## Requirements Elicitation Models

### Domain Model

> Describes problem concepts and relationships

This is a UML class diagram.

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

## Structural Models

### Environment Model

> Defines the system's interface (boundaries & operations).

* Black box view of system
* Interaction with entities and actors (labelled `name:type`)
* Contains arrows and a list of possible input & output methods

### Concept Model

> Defines the static structure of the system (concepts & relationships)

* Like an environment model, but showcasing only what is necessary to create the system interactions
* Cards may be grouped to show the system/object for which they belong to

## Behavioural Models

### Operation Model

* System operations may
    * Create a new instance of a class
    * Remove an object from system state
    * Change attribute value or an existing object
    * Add/remove link to/from association
    * Send message to actor

#### Operation Schema
---
* Operation - `Caller::methodName(arg0: arg0Type, arg1: arg1Type, ...)`
* Scope - classes & associations from concept model
* Message - all message output types - `Sender::{msgs, here};`
* New - all objects that may be created - `newX: X`
* Pre - (optional) conditions that must be met for this operation to make sense
* Post - description of effects of operation
* Use Cases - cross-reference to related use cases
---

### Protocol Model

> Defines allowable interactions between system & environment

* Denoted using use case maps
* Elements
    * Start node - black dot
    * End node - black bar
    * Responsibility - annotated `x`
    * Or - fork
    * And - two bars with three arrows in between
    * Stubs - white diamond
* Conditions added on paths with brackets
* Responsibilities may be surrounded by box dictating entity
* Stubs may have multiple annotated out paths
* Can use timers, with either an input condition (dot is filled) or an output timeout value (dot has clock symbol, timeout line is jagged)
