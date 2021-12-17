# Comp 303

> [Martin Robillard](mailto:martin@cs.mcgill.ca?Subject=Comp%20303) &bull; [Github](https://github.com/prmr) &bull; [Software Design Textbook](https://github.com/prmr/SoftwareDesign/)

# Lecture 1 • 2017/09/05
* No assignments; 4 lab tests. Sign up for a room, TA gives question, code in editor
* 2 midterms, 1 final
* Keywords – Non fault tolerant, safety/security defect, bad user interface, bad feature interactions, compatibility issues, competing constraints, assumptions (eg expecting nonnull), bad usability
* At its core, software design is the ability to organize code so that it is clear and sustainable
* Centralized vs Distributed VCS
  * Centralized – only one database exists, and is located on the VCS server
  * Distributed – every computer has its own database, which can be modified independently of the server's database

# Lecture 2 • 2017/09/07
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

# Lecture 3 • 2017/09/12
* In a well encapsulated class, it should not be possible to modify the state of a class without calling a method in that class
* Scopes are nested – variables in an inner brace are not accessible by variables in the outer brace
* Constructors that take references and directly save them to global variables break encapsulation, as such references can be leaked and held even after the constructor
* If we have a class Deck with a stack, along with a method draw() which calls pop(), we may break encapsulation by exposing an EmptyStackException. This tells the user how the deck is implemented
* Private fields are available to any method in the same class. Be careful with methods that pass such private fields to other objects, thus exposing such properties

# Lecture 4 • 2017/09/14
* Interface – list of methods in a given scope
* Use interface to separate usage from implementation.
* Is a contract, where the implementor is expected to provide the proper implementation
* Benefits of interfaces - loose coupling and extensibility
* UML - diamond is on the side of the collection

# Lecture 5 • 2017/09/19
* Taught by TA
* Deck building