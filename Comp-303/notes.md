# Comp 303

> [Martin Robillard](mailto:martin@cs.mcgill.ca?Subject=Comp%20303) &bull; [Github](https://github.com/prmr) &bull; [Software Design Textbook](https://github.com/prmr/SoftwareDesign/)

# Lecture 1 • 2017/09/05
* No assignments; 4 lab tests. Sign up for a room, TA gives question, code in editor
* 2 midterms, 1 final
* Keywords – Non fault tolerant, safety/security defect, bad user interface, bad feature interactions, compatibility issues, competing constraints, assumptions (eg expecting nonnull), bad usability
* At its core, software design is the ability to organize code so that it is clear and sustainable
* Centralized vs Distributed VCS
  * Centralized – only one database exists, and is located on the VCS server
  * Distributed – every computer has its own database, which can be modified independently of the server's database

# Lecture 2 • 2017/09/07
* A good design space involves – reusability, portability, stability, tolerance, understandability, etc
* A domain should be clearly represented
  * For example, representing a card as an integer and using arrays to map it to strings is bad in that:
    * It is unclear what the integer actually represents (it could be considered as an index, which it isn't)
    * It is not mappable using the entire range of integers; passing a number such as 53 will result in an invalid 'card'
  * We may instead create a class 'Card' to wrap the integer
  * Encapsulation is a way of hiding an implementation by only exposing certain methods, but it must be done correctly
    * Simply wrapping an integer with a getter and setter method is not enough, as it doesn't do anything to prevent exposure
    * Instead, we may considering hiding the int altogether, and creating methods that do specifically what a user requires, such as 'getSuit()', 'getRank()', 'toString()', etc
* @Override is an annotation asserting that the same method header exists in a superclass. It helps us avoid typos, and is really nothing more than a lint check. (Side note: there are many other useful annotations, such as @NonNull, @Nullable, @IntRange, @FunctionalInterface, etc)
* <b>Type</b> – set of values and operations
* Avoid hardcoding many edge cases with if else statements; it only clutters the code and requires in exponentially greater test cases.
* 'assert' is used to evaluate a predicate, and throws an exception if the predicate returns false

# Lecture 3 • 2017/09/12
* In a well encapsulated class, it should not be possible to modify the state of a class without calling a method in that class
* Scopes are nested – variables in an inner brace are not accessible by variables in the outer brace
* Constructors that take references and directly save them to global variables break encapsulation, as such references can be leaked and held even after the constructor
* If we have a class Deck with a stack, along with a method draw() which calls pop(), we may break encapsulation by exposing an EmptyStackException. This tells the user how the deck is implemented
* Private fields are available to any method in the same class. Be careful with methods that pass such private fields to other objects, thus exposing such properties

# Lecture 4 • 2017/09/14
* Interface – list of methods in a given scope
* Use interface to separate usage from implementation.
* Is a contract, where the implementor is expected to provide the proper implementation
* Benefits of interfaces - loose coupling and extensibility
* UML - diamond is on the side of the collection

# Lecture 5 • 2017/09/19
* Taught by TA
* Deck building

# Lecture 6 • 2017/09/21
* Taught by TA
* Iterators and more factory methods

# Lecture 7 • 2017/09/26
* UML is all about models; queries like isEmpty, or methods that don't change states aren't as necessary
* Boxes are states (not necessarily a procedure) – usually adjectives
* Arrows are actions – verbs
* Guard state – actions with a condition can be denoted as `action [condition]`
* Overriding equality
  * Check nonnull, check self reference, check same class (exact, not instanceOf), check equality
* Flyweight pattern
  * Ensures objects that are equal are never created twice
  * Hold a reference to each object, and return a new one or the saved one when applicable

# Lecture 8 • 2017/09/28
* Reviewed flyweight pattern (open parliament)
* Continue UML diagram for solitaire
* Classes – Deck, Suit Stack, Discard Pile, Card, Working Stack, Game Engine, Iterable (interface), Playing Strategy (interface), Random Strategy, Smart Strategy
* States – fresh, in progress

# Lecture 9 • 2017/10/03
* In UML diagrams, the 'yellow cards' are notes
* Three components of a test
  * Program unit (eg canMoveTo)
  * Input data
  * Oracle
* Learned a bit about reflection and JUnit

# Lecture 11 • 2017/10/10
* Implement interfaces (like Comparable) in the same class it pertains to to help with information hiding and access to the private variables.

# Lecture 15 • 2017/10/24
* Learn observable pattern
* Instead of every model keeping track of shared states, allow them to pass through observers to be called by the actual mutation
* Avoid adding a lot of conditionals based on an observer. Rather let the observers themselves handle such conditions

# Lecture 16 • 2017/10/26
* GUI Programming in 3 Simple Concepts
  | | |
  ---|---
  Component Graphs | Composite/Decorate Patterns
  Event Loop | Frameworks/Concurrency
  Event Handling | Observer Design Pattern
* GUI Component Graph
* Visual vs Logical, Static vs Dynamic