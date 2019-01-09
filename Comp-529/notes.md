# Comp 529

> [Course Website](https://cs.mcgill.ca/~martin/teaching/comp529-winter-2019/)
> [Textbook](https://www.safaribooksonline.com/library/view/software-systems-architecture/9780132906135/?ar&orpq) (Requires academic email)

## Textbook Intro - Software Architecture Concepts

* A software architect satisfies:
  * Stakeholders - People affected by the system. 
    * In many cases, this is more than just developers and end users
  * Viewpoints - Splitting a complex structure into manageable sections, relevant to each particular group.
    * Examples include functional structure, information organization, and deployment environment. 
    * A possible solution to deciding which views to use is through template views, aka architectural viewpoints.
  * Perspectives - Consideration of quality properties
    * Complementary to viewpoints, ensures that our structures exhibit properties we require

## Textbook Ch 2 - Software Architecture Concepts

* Computer systems are made up of software, data (transient of persistent) and hardware
* The architecture of a system refers to its elements and relationships, its fundamental properties, and the principles of its design and evolution
* Structure
  * Static - design-time elements and their arrangement
  * Dynamic - runtime elements and their interactions
* Fundamental system properties
  * Externally visible behaviour - what system does
    * Functional interactions between system and its environment
    * Can be modeled as a black box or consider internal system changes
  * Quality properties - how system does it
    * Nonfunctional properties, eg performance, security, scalability
* There may be multiple architectures for a given design, catering to different needs, though each should meet the system's requirements
* Architectural element - fundamental piece of system that can be constructed
  * Has a set of responsibilities
  * Has a defined boundary
  * Has a set of defined interfaces, which in turn define services provided to other elements
* Stakeholders
  * Note that software is not just *used*. It is also *built*, *tested*, *operated*, *repaired*, *enhanced*, and *paid for*. As a result, stakeholders involve much more than just the end users.
  * This term may also represent a class of individuals, such as developers, rather than a specific person
  * Concern - requirement, objective, constraint, intention, or aspiration a stakeholder has for architecture
    * Some concerns are common among stakeholders, but others may even conflict
      * Example includes triangle of cost, quality, and time
  * As the system is built to serve stakeholders, the architecture is created solely to meet stakeholder needs
  * A good architecture will address such concerns, and provide a balance when they conflict
* Architectural description (AD) - products that document an architecture such that stakeholders can understand and verify that concerns have been met
  * Note that not every system has an AD