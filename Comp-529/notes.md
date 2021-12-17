# Comp 529 <!-- omit in toc -->
> [Course Website](https://cs.mcgill.ca/~martin/teaching/comp529-winter-2019/) 

- [Software Systems Architecture](#software-systems-architecture)
  - [Ch 1 - Introduction](#ch-1---introduction)
  - [Ch 2 - Software Architecture Concepts](#ch-2---software-architecture-concepts)
  - [Ch 3 - Viewpoints and Views](#ch-3---viewpoints-and-views)
  - [Ch 4 - Architectural Perspectives](#ch-4---architectural-perspectives)
  - [Ch 8 - Concerns, Principles, and Decisions](#ch-8---concerns-principles-and-decisions)
  - [Ch 9 - Identifying and Engaging Stakeholders](#ch-9---identifying-and-engaging-stakeholders)
  - [Ch 10 - Identifying and Using Scenarios](#ch-10---identifying-and-using-scenarios)
  - [Ch 11](#ch-11)
  - [Ch 12](#ch-12)
  - [Ch 13 - Creating the Architectural Description](#ch-13---creating-the-architectural-description)
  - [Ch 14 - Evaluating the Architecture](#ch-14---evaluating-the-architecture)
  - [Ch 17 - The Functional Viewpoint](#ch-17---the-functional-viewpoint)
  - [Ch 28 - The Evolution Perspective](#ch-28---the-evolution-perspective)
- [Pattern Oriented Software Architecture](#pattern-oriented-software-architecture)
  - [Ch 9 - From Mud to Structure](#ch-9---from-mud-to-structure)

# Software Systems Architecture

> [Textbook]([https://www.safaribooksonline.com/library/view/software-systems-architecture/9780132906135/?ar&orpq](https://learning.oreilly.com/library/view/software-systems-architecture/9780132906135/?ar))

## Ch 1 - Introduction

* A software architect satisfies:
  * **Stakeholders** - People affected by the system. 
    * In many cases, this is more than just developers and end users
  * **Viewpoints** - Splitting a complex structure into manageable sections, relevant to each particular group.
    * Examples include functional structure, information organization, and deployment environment. 
    * A possible solution to deciding which views to use is through template views, aka architectural viewpoints.
  * **Perspectives** - Consideration of quality properties
    * Complementary to viewpoints, ensures that our structures exhibit properties we require

## Ch 2 - Software Architecture Concepts

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

## Ch 3 - Viewpoints and Views

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

## Ch 4 - Architectural Perspectives

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
  * Collection of architectural *activities, tactics, guidelines* to ensure that system exhibits certain quality properties across architectural views
  * Orthogonal model to viewpoints; applied to views
  * Issues addressed are referred to as *cross-cutting concerns* or *nonfunctional requirements*
* **Architectural tactic** - *established & proven* approach to help achieve particular quality property
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

## Ch 8 - Concerns, Principles, and Decisions

* Scope and requirements of system define architectural solutions, and are part of the Context viewpoint.
* **Concern** - requirement, object, constraint, intention, or aspiration stakeholder has for architecture
  * Business & IT strategies - long-term priorities & roadmap
  * Goals & drivers - fundamental issues & problems
  * Standards & policies - general operations
  * Real-world constraints - time, money, skill, technology pitfalls, etc
* **Requirement** - specific, unambiguous, measurable concern
* Concern categories
  * Problem-focused concerns - why, what
    * Influence
      * Require a capability
      * Clarify/shape a detail
    * Constrain
      * Limit behaviour in certain circumstances
      * Prohibit actions
    * Includes
      * Business strategy
        * Overall direction for business
        * Defines service, customers, difference between competitors, etc
        * Includes **roadmap** describing future transformations to achieve desired state
      * Business goals & drivers
        * **Goal** - specific aim of the organization
        * **Driver** - force acting on organization requiring behaviour
        * Often hard to translate
      * System scope & requirements
        * **System scope** - defines main responsibilities of system
        * **Requirements** - more detailed, often split into *functional requirements* and *quality properties*
      * Business standards & policies - internal mandates
        * Eg data retention policy
  * Solution-focused concerns - how, with what
    * Often derived from problem-focused concerns
    * IT strategy
    * Technology goal & drivers
    * Technology standards & policies
      * Open standards - eg ISO, IEEE, W3C; generally accepted
      * Proprietary standards
      * De facto standards - widely followed but not ratified
      * Organizational standards
      * May need to comply with legal, statutory, regulatory standards
    * Real world constraints
      * Technical constraints - eg scaling, security
      * Time
      * Cost
      * Skills
      * Operational constraints - eg must maintain certain uptime
      * Physical constraints
      * Organizational/cultural constraints
  * Good concerns are
    * Quantified & measurable where possible
    * Testable
    * Traceable - eg justified backwards to strategy/goal, traced forward to architectural/design features
* Architectural principles
  * Fundamental approach that guides the definition of an architecture
  * Help maintain consistency & transparency when addressing/rejecting concerns
  * Good principles are
    * Constructive
    * Reasoned
    * Well articulated
    * Testable
    * Significant
* Architecturally significant decisions
  * "what"
    * Map out functional components
    * Significant stakeholder impact
  * "how"
    * Define method of construction
    * Uses standard patterns
    * Typically impacts solution space more than problem space
  * "with what"
    * Technology stack to be used
  * Architectural significance is defined by
    * Having significant impact on functionality or quality properties
    * Addressing significant risk
    * Affecting time or cost 
    * Being complex or unexpected
    * Requiring significant time or effort to resolve
* Principles can justify architectural elements by relating
  * **Rationale** - why is something valuable & appropriate
  * **Implication** - what needs to happen for principle to be reality
* Traceability process
  * Business drivers & goal
  * Business principles (rationales & implications)
  * Technology principles (rationales & implications)
  * Architectural decisions
* Checklist
  * Consulted all relevant stakeholders?
  * Documented influencing concerns? (goals & drivers)
  * Documented constraining concerns? (standards & policies)
  * Understood real world constraints?
  * Documented all concerns in clear, simple, understandable language?
  * All principles supported by rationales & implications?
  * Stakeholders reviewed & ratified concerns & principles?

## Ch 9 - Identifying and Engaging Stakeholders

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

## Ch 10 - Identifying and Using Scenarios

* **Architectural Scenario** - Description of interaction between external entity & system
* Scenarios capture:
  * Interactions that must be handled
  * Potential peak load situations
  * Demands made to system
  * Responses by system to specific failures
  * Change maintainers may need for system
* **Functional scenarios** - sequence of external events
  * Often documented through use case
* **System quality** - defines system reactions towards environment (showing certain quality properties)
* Scenarios can:
  * Provide input to architecture definition
  * Define & validate system scope
  * Evaluate architecture
  * Help communicate with stakeholders
  * Find missing requirements - defining use case in one scenario helps think about omitted scenarios
  * Drive testing process - by highlighting important aspects to stakeholders
* Identify scenarios by looking at:
  * Requirements - functional requirements suggest functional scenarios; quality requirements suggest behaviours
  * Stakeholders - brainstorm ideas together
  * Experience - experience may lead to more useful/informed scenarios
* Prioritize scenarios by looking at:
  * Importance of relevant stakeholder(s)
    * In some cases, we may need to balance priorities, rather than just pick the most voted scenarios across the board
  * Risk of scenario
  * Note to avoid having a large number of scenarios (> 15-20)
* Capturing functional scenarios
  * Overview - brief description
  * System state - state of system before scenario
  * System environment - significant observations such as unavailability of external systems, time-based constraints, etc
  * External stimulus - cause of scenario
  * Required system response - explanation of responses from an external observer's perspective
* Capturing system quality scenario
  * Overview - (same as above)
  * System state - (same as above)
  * System environment - (same as above)
  * Environmental changes - causes for scenarios
    * Eg infrastructure failure, security attack, etc
  * Required system behaviour - definition of response to change
* Both scenarios above should have unique identifier & good name
* A good scenario is
  * Credible - realistic
  * Valuable - impacts architectural process
  * Specific - describes situation accurately
  * Precise - scenario situation and required system response should be clear
  * Comprehensible - understandable & unambiguous
* Applying scenarios
  * Paper models 
    * Easiest, simple, inexpensive
    * Can ve validated using walkthroughs
  * Simulations - cheaper than full prototype 
    * Unfortunately, usually has little carry over towards other scenarios, and may not always be an accurate reflection of real situations
  * Prototype implementation testing 
    * Can focus efforts on high-risk areas
  * Full-scale live testing
* Scenarios are rarely applied at the same level
* Effective use of scenarios
  * Identify focused sets - too many scenarios isn't effective
  * Use distinct scenarios - similar scenarios is not cost effective relative to their added benefits
  * Use scenarios early - scenarios lose their benefits when they are applied too late
  * Include system quality scenarios 
  * Include failure scenarios
  * Involve stakeholders closely
* Checklist
  * Find suitable range of system quality
  * Find suitable range of failure scenarios
  * Prioritize scenarios
  * Small number of scenarios (< 15-20)
  * Review & agree on required responses & behaviours
  * Include scenarios you feel will be valuable + those nominated by stakeholders
  * Catalog & name scenarios
  * Address mistakes/gaps identified through scenarios
  * Likewise, revise architectural design when divergence occurs

## Ch 11

* Design pattern types
  * **Architectural style** - fundamental structural organization schema for software systems
    * Provides element types, responsibilities and relationship rules & guidelines for system as a whole
  * **Software design pattern** - captures detailed design solution
    * Common/proven structure of interconnected elements
    * Solves general design problem within particular context
  * **Language idiom** - programming-language-specific design solutions
* Design patterns have
  * **Name** - memorable & meaningful identifier
  * **Context** - motivation, rationale, relevant situations
  * **Problem** - DPs are solutions to a particular problem; may describe design forces
  * **Solution** - eg design model
  * **Consequences** - results & tradeoffs, benefits & costs
* DP Roles
  * Store of knowledge
  * Examples of proven practices - can be used directly or also to help solve different problems
  * Language - common language for problems
  * Standardization
  * Source of improvement - often in public domain
  * Encourages generality
* See Ch 9 of POSA (below) for models
* Architectural style benefits
  * Solution for system design
  * Basis for adaptation
  * Inspiration for related solution
  * Motivation for new styles
* AS rarely used in isolation
* When using multiple ASs, it's helpful to pick a dominant style with subsidiary styles added for problems the primary one can't address; experience, knowledge, and sound judgement will help

## Ch 12

* **Model** - abstract, simplified, partial representation of aspect of architecture
  * Help *understand* situation
  * Medium for *communication*
  * Help *analyze* situation
  * Help *organize* processes, teams, deliverables
* Every architectural model is an approximation of reality; abstracts away unnecessary detail
* Match model complexity to skill level and interests of audience
* Ensure audience is aware of any simplifications/approximations in model
* **Quantitative models** - illustrate structural/behavioural elements
* **Sketch** - deliberately informal graphical model used to communicate important aspects to nontechnical audience
* Guide to effective modelling
  * Model purposefully
  * Address audience
  * Abstract carefully
  * Focus efforts according to risks
  * Choose descriptive names
  * Define terms
  * Aim for simplicity
  * Use defined notation
  * Beware of implied semantics 
  * Validate models
  * Keep models alive

## Ch 13 - Creating the Architectural Description

* ADs should be crisp, concise, and to the point
* Properties
  * **Correctness** - should represent & meet the needs & concerns of stakeholders
  * **Sufficiency** - should allow stakeholders to understand key architectural decisions made
  * **Timeliness** - follow milestones; late deliverables are not useful
    * Focus on key risks, then update incrementally
    * Do not leave out difficult decisions, expecting that they will get easier down the road; often times the decision will end up being made 'by default'
  * **Conciseness** - focus on important elements, and leave out highly specific details
    * Factors
      * Familiarity of technology
      * Difficulty/criticality of problem
      * Scale of quality property requirements
      * Time/resources available
  * **Clarity** - consider intended readership when writing AD
    * Tailor content to skill, knowledge, and time available 
  * **Currency** - think about how AD will be updated throughout the life of the system
    * Mark out of date sections as such
  * **Precision** - ensure precision, and break details into parts if they are necessary
    * If not careful, precision becomes the converse of conciseness
    * Use abstraction layers to avoid writing details multiple times
  * **Glossary** - include glossary in AD to explain ambiguous/unclear terminology
* Contents
  * **Document Control** - identifiers versions, date, status, changelog, etc
  * **Table of Contents**
  * **Introduction & Management Summary** - describes objectives, summarizes goals, scope & requirements, presents high-level overview of solution, identifies key decisions
  * **Stakeholders** - define stakeholder groups & concerns
  * **General Architectural Principles** - info that doesn't naturally fit into any views
  * **Architectural Design Decisions** - decisions, rationales, alternatives considered
  * **Viewpoints** - define viewpoints; can reference external set of definitions
  * **Views** - details dependent on viewpoint
  * **Quality Property Summary** - include general insights & non-view-specific artifacts
  * **Important Scenarios** - record initial system state, external stimulus, required behaviour
  * **Issues Awaiting Resolution** - document parts where consensus not formed
  * **Appendices** - for detailed content
* Presentation
  * **Formal documents**
    * Good when AD is complicated
    * Harder to assemble if information changes frequently
  * **Wiki documents**
    * Very accessible
    * Less strong if complicated formatting is required
  * **Presentations**
    * Largely used
  * **UML models**
    * Good de facto solution
    * Less feasible for nontechnical stakeholders
  * **Drawing tools**
  * **Code**
  * **Spreadsheets**

## Ch 14 - Evaluating the Architecture

* Why
  * Validate abstractions - ensure they are reasonable & appropriate
  * Check technical correctness - easy to create models that seem credible until implementation
  * Sell the architecture - prove that AD meets needs
  * Explain the architecture - interaction helps with engagement, especially with less technical stakeholders
  * Validate assumptions - ensure that key assumptions are tested
  * Provide management decision points
  * Offer basis for formal agreement
  * Ensure technical integrity
* Evaluation techniques
  * Presentations
    * (+) Quick & cheap
    * (+) Immediate feedback
    * (-) Shallow level of analysis
    * (-) Effectiveness dependent on engagement of attendees
  * Formal Reviews & Structured Walkthroughs
    * Involves moderator, presenter, & reviewers
    * (+) Deeper analysis than presentation
    * (-) Requires significant presentation
  * Using Scenarios
    * Steps
      * Understand requirements
      * Understand proposed architecture
      * Identify prioritized scenarios
      * Analyze architecture
      * Draw conclusions
    * (+) Provides deep analysis
    * (+) Allows team to understand decisions
    * (-) Complex & expensive
    * (-) Training/preparation required to lead
  * TODO

## Ch 17 - The Functional Viewpoint

* Concerns
  * **Functional capabilities** - what system is required (and not required) to do
  * **External interfaces** - data, event, control flows between system and others
    * Should consider both syntax & semantics
  * **Internal structure** - many implementations possible; pick one that best suits the needs
    * Has a large impact on quality properties
  * **Functional design philosophy** 
    * **Coherence** - logical structure, elements work well
      * Error may indicate incorrect decomposition
    * **Cohesion** - relations between functions in element
      * High cohesion = well grouped function = less error prone
    * **Consistency** - are design decisions consistent across architecture?
      * Easier to build, test, operate, evolve
    * **Coupling** - interrelationships between elements
      * Loose coupling = easier to support, but may also be less efficient
    * **Extensibility** - ease of changing or adding functions to system
      * Often result of coherence, low coupling, simplicity, consistency
    * **Generality** 
      * Needs to be balanced against added cost and complexity
    * **Interdependency**
      * Interactions between elements can be much more complex than within the same element
    * **Simplicity**
  * Stakeholder concerns
    * Acquirers - functional capabilities, external interfaces
    * Assessors - all concerns
    * Communicators - all concerns
    * Developers - design quality, internal structure, functional capabilities, external interfaces
    * System administrators - design philosophy, external interfaces, internal structure
    * Testers - design quality, internal structure, functional capabilities, external interfaces
    * Users - functional capabilities, external interfaces
* Models
  * Functional structure model
    * Functional elements - software module, data store, application package
    * Interfaces - inputs, outputs, semantics of operations offered by elements
    * Connectors - link elements together, separate from the semantics of the operations
    * External entities - other systems, programs, hardware devices, or entities
  * Notation
    * Formal - UML, old ones: Yourdon, Jackson System Development
    * Architecture description languages (ADL) - Unicon, Write, xADL
      * Provide native support
      * Lack stakeholder familiarity
    * Boxes & line diagrams
      * Less technical
    * Sketches
* Identify elements by
  * Finding key system level responsibilities
  * Finding functional elements that will perform those responsibilities
  * Assessing elements against design criteria
  * Iterating to refine structure
* Refinements
  * Generalization
  * Decomposition - break large elements into smaller subelements
  * Amalgamation - replace lots of small similar elements with a larger element
  * Replication 
  * Assign responsibilities to elements
  * Design interfaces - inputs, outputs, preconditions, postconditions
    * Interface definition languages (IDL)
    * Data oriented - describe purely messages exchanged
  * Design connectors
  * Check functional traceability
  * Walk through common scenarios
  * Analyze interactions
  * Analyze flexibility

## Ch 28 - The Evolution Perspective

* Concerns
  * Product management
  * Magnitude of Change
  * Dimensions of Change
    * Functional
    * Platform
    * Integration
    * Growth
  * Likelihood of Change
  * Timescale for Change
  * When to Pay for Change
    * Flexible design - more work early on
    * Simplest design possible - more work later on
  * Changes Driven by External Factors
  * Development Complexity
  * Preservation of Knowledge
  * Reliability of Change
* Design Techniques
  * Metamodel
    * Break down data into building blocks and use runtime configurations to create functional components
    * Faster to iterate as we just change configurations
    * Harder to build and less efficient 
  * Variation Points
    * Identify points that should support change and make them replaceable/configurable
    * Separate physical & logical processing
    * Break down processing into steps
  * Standard Extension Points
    * Mainstream variation points
  * Ensure Reliable Change
    * Configuration management
    * Automated build process
    * Dependency analysis
    * Automated release process
    * Easy rollback
    * Automated testing
    * Continuous integration
  * Preserve Development Environments
* Problems
  * Prioritizing wrong dimensions
    * Analyze beforehand to be confident of large changes
  * Changes that never happen
    * Provide support for change only if confident that it is needed
  * Evolution of critical quality properties
    * Maintain balance between flexibility & other important quality properties
  * Overreliance on specific hardware/software
    * Create abstractions and be wary of roadmaps
  * Lost development environments 
    * Save environment info so you can test against it again
  * Ad hoc release management
    * Use automated processes to improve reliability & repeatability

# Pattern Oriented Software Architecture

> [Textbook](https://learning.oreilly.com/library/view/pattern-oriented-software-architecture/9780470059029/?ar)

## Ch 9 - From Mud to Structure

* Software architecture should be meaningful
  * Functionality & features provided by system should support concrete business
* Models should be concerned with variability
  * Hard to make decisions if we don't know how the domain may vary
* **Domain model**
  * Defines structure & workflow of application domain + variations
  * Partition by considering
    * How application interacts with environment
    * How processing is organized
    * What variations must be supported
    * Life expectancy of application
  * **Layers** pattern - decomposes application into subtasks, each with a particular level of abstraction or hardware-distance
    * Subtasks can be developed independently 
  * **Model-View-Controller** (MVC) pattern
    * Model - functionality & data
    * View - display information
    * Controller - user input handlers
    * Allows variation within one specific UI
    * Also model view presenter, which avoids delegating all view behaviour to models; contains intermediate presenter
  * **Presentation-Abstraction-Controller** (PAC) - cooperating agents, each with their own PAC
    * Separates human-computer interaction from functionality and communication with other agents
    * Supports multiple, distinct UT
  * **Microkernel** - for systems that must adapt to changing system requirements
    * Separates minimal functional core from custom parts
    * Flexible in *what* functionality is provided
    * Common in OS
  * **Reflection** pattern - change structure & behaviour dynamically
    * Flexible in *how* functionality is executed/used
    * Common in service integration
  * **Pipes & Filters** pattern - each process is a filter component; combines into a way to process data streams
    * Common in image processing
  * **Shared Repository** pattern - maintains common data, which can be modified and propagated to specific components
    * Deterministic control flow
    * Common in telecommunication management networks
  * **Blackboard** pattern - for problems with no deterministic solution strategies
    * Based on heuristics
    * Common in bio-informatics
  * **Domain Object** pattern - self-contained entities with explicit interfaces, while hiding inner structure & implementation
    * Allows changing specific requirements independent of other realizations
