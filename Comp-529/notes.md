# Comp 529

> [Course Website](https://cs.mcgill.ca/~martin/teaching/comp529-winter-2019/) <br>
> [Textbook](https://www.safaribooksonline.com/library/view/software-systems-architecture/9780132906135/?ar&orpq) (Requires academic email & McGill network)

## Textbook Ch 1 - Introduction

* A software architect satisfies:
  * **Stakeholders** - People affected by the system. 
    * In many cases, this is more than just developers and end users
  * **Viewpoints** - Splitting a complex structure into manageable sections, relevant to each particular group.
    * Examples include functional structure, information organization, and deployment environment. 
    * A possible solution to deciding which views to use is through template views, aka architectural viewpoints.
  * **Perspectives** - Consideration of quality properties
    * Complementary to viewpoints, ensures that our structures exhibit properties we require

## Textbook Ch 2 - Software Architecture Concepts

* Computer systems are made up of software, data (transient of persistent) and hardware
* The architecture of a system refers to its elements and relationships, its fundamental properties, and the principles of its design and evolution
* Structure
  * **Static** - design-time elements and their arrangement
  * **Dynamic** - runtime elements and their interactions
* Fundamental system properties
  * Externally visible behaviour - what system does
    * Functional interactions between system and its environment
    * Can be modeled as a black box or consider internal system changes
  * Quality properties - how system does it
    * Nonfunctional properties, eg performance, security, scalability
* **Candidate architecture** - arrangement of static & dynamic structures with the potential to exhibit required externally visible behaviours and quality properties
* There may be multiple architectures for a given design, catering to different needs, though each should meet the system's requirements
* **Architectural element** - fundamental piece of system that can be constructed
  * Has a set of responsibilities
  * Has a defined boundary
  * Has a set of defined interfaces, which in turn define services provided to other elements
* Stakeholders
  * Note that software is not just *used*. It is also *built*, *tested*, *operated*, *repaired*, *enhanced*, and *paid for*. As a result, stakeholders involve much more than just the end users.
  * This term may also represent a class of individuals, such as developers, rather than a specific person
  * **Concern** - requirement, objective, constraint, intention, or aspiration a stakeholder has for architecture
    * Some concerns are common among stakeholders, but others may even conflict
      * Example includes triangle of cost, quality, and time
  * As the system is built to serve stakeholders, the architecture is created solely to meet stakeholder needs
  * A good architecture will address such concerns, and provide a balance when they conflict
* **Architectural description (AD)** - products that document an architecture such that stakeholders can understand and verify that concerns have been met
  * Note that not every system has an AD

## Textbook Ch 3 - Viewpoints and Views

* Avoid using a single overloaded model for ADs, as it becomes understandable by stakeholders when the system is sufficiently complex
* A complex system is more effectively described by a set of interrelated views
* **View** - representation of structural aspects of architecture, illustrating how architecture addresses stakeholder concerns
  * View scope - what aspects of architecture to represent
    * Eg representing runtime intercommunications vs runtime environment
  * Element types - what types of architectural elements to categorize
    * Eg is system deployment represented by individual server machines or service environment
  * Audience - which stakeholders to address
  * Audience expertise - how much technical understanding the stakeholders have
  * Scope of concerns - what stakeholder concerns are addressed by the view
  * Level of detail - how much stakeholders need to know about this view
  * Goal is to only include relevant information in each view for the target audience
* **Viewpoint** - patterns, templates, and conventions for creating views
* Using viewpoints and views allows for
  * Separation of concerns 
  * Communication with stakeholder groups - stakeholders can quickly identify relevant concerns
  * Management of complexity - architect can focus on specific aspects per view, vs everything at once
  * Improved developer focus
* Viewpoint pitfalls
  * Inconsistency - descriptions across views may not always match
  * Selection of wrong set of views 
  * Fragmentation 
* **Viewpoint catalog**
  * Context - describes relationships, dependencies, interactions
  * Functional - describes runtime functional elements
  * Information - describes how info is stored, manipulated, distributed
  * Concurrency - maps functional elements to concurrency units
  * Development - communicates aspects relevant to those building, testing, maintaining, and enhancing the system
  * Deployment - describes needed hardware environment
  * Operational - describes operation, administration, and support necessary for production environment

## Textbook Ch 4 - Architectural Perspectives

* When creating a view, focus on issues, concerns, and solutions relevant to that view
  * Eg: data ownership is not important for concurrency view; dev environment not concern for functional view
  * Decisions can affect multiple views, but concerns are typically different
* **Quality properties**
  * Span across multiple viewpoints
  * Doesn't make sense to view it in isolation as its own viewpoint
  * Should instead enhance existing views.
  * Eg security
    * Functional - identify and authenticate user
    * Information - system must have control of read, insert, update, delete at multiple levels
    * Operational - maintaining and distributing secret information
* **Architectural perspective**, aka perspective
  * Collection of architectural activities, tactics, guidelines to ensure that system exhibits certain quality properties across architectural views
  * Orthogonal model to viewpoints; applied to views
  * Issues addressed are referred to as *cross-cutting concerns* or *nonfunctional requirements*
* **Architectural tactic** - established & proven approach to help achieve particular quality property
  * Eg priority-based process schedule to improve system performance
  * More general than a design pattern
* Important perspectives
  * Performance & scalability
  * Availability & resilience
  * Evolution (coping with changes)
  * Regulation (confirming to laws)
* Typically not feasible to apply all perspectives to all views; some relations are more important than others.
  * Eg deployment view & security perspective, development view & evolution perspective
* Applying perspectives to views leads to 
  * **Insights** - creation of something, eg new model, to help meet quality properties
    * Eg security &rarr; existence of ignored security threats
  * **Improvements** - updated model to account for insights
    * Eg deployment &rarr; use more servers and show support for load balancing
  * **Artifacts** - important supporting architectural information that have significant lasting value
    * Eg deployment &rarr; spreadsheet modelling physical networks
* Benefits of perspectives
  * Defines concerns to help ensure that quality properties are exhibited
  * Provides common conventions, measurements or notation to describe qualities
  * Provides means of validating architecture
  * May offer recognized solutions
  * Provides systematic workflow
* Perspective pitfalls
  * Solutions may conflict between perspectives
  * Concerns & priorities are different for every system

## Textbook Ch 9 - Identifying and Engaging Stakeholders

* High priority stakeholder groups
  * Those most affected by architectural decisions
    * Eg those who use, operate, manage, or pay for system
  * Those who have influence over success of development
    * Eg those who pay for it
  * Those with specialist knowledge of business or technology domain
  * Those included for organizational/political reasons
* Good stakeholders are
  * Informed - able to make correct decisions
  * Committed - willing to participate
  * Authorized - allowed to make decisions
  * Representative - suitable for particular group
* Stakeholder classes
  * Acquirers - oversee system/product
  * Assessors - oversee legal regulations
  * Communicators - explain system to other stakeholders
  * Developers - construct/deploy system
  * Maintainers - manage evolution of system
  * Production engineers - design, deploy, manage hardware & software environment
  * Suppliers - build/supply hardware, software, infrastructure
  * Support staff - supports users
  * System administrators - run system after deployment
  * Testers - test system
  * Users - use system
* Large stakeholder groups need to be actively managed to ensure that its size does not impede progress
* Not always possible to identify all stakeholders until system is developed
* **Proxy stakeholder** - speaks on behalf of real stakeholders to ensure their concerns are equally  addressed as other real stakeholders
* Stakeholder responsibilities 
  * Ensures concerns are clearly communicated to architect
  * Make decisions in timely & authoritative manner
  * Escalate decisions that require more authority
  * Review AD to ensure system meets concerns
* Checklist
  * Identify at least one stakeholder per class
  * Inform stakeholders of responsibilities
  * Ensure stakeholders are aware of responsibilities
  * Identify suitable proxy for stakeholders that don't yet exist


