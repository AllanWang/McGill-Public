# Lecture Notes

## Guest Lecture 1 - Multi-tenant architecture

* Single-tenant multi-user
  * Eg McGill exchange server & other exchange servers; each hosted separately
* Multi-tenant multi-user
  * Eg google apps - all services in one host

---

* Application designed to provide every tenant a dedicated share of instance, including
  * Data
  * Configuration
  * User management
  * Tenant individual functionality
  * Non-functional properties
* Problems
  * Cache poisoning - caching may be used incorrectly across tenants
  * Permissions
  * Performance - one tenant may by significantly more intensive and affect resources for other tenants
* Pros
  * Maximize resource usage
  * Reduce maintenance time
  * Data aggregation
  * Operating cost advantages
* Cons
  * Outages affect may tenants
  * Feature requests (customization) more complex to manage
  * High performance can be challenging as you grow
* Tenant key - SQL, program primary key; one per tenant
  * Required in all classes, even if that involves duplicate data
* Example model
  * Two annotations in python implementation
  * `@requires_tenant` enforces tenant id check, so methods don't have to do so themselves
  * `@multi_tenant` removes restrictions, but indicates that we've acknowledged our usage
* Sharding - horizontal partitioning
  * Split tenant data across multiple databases
  * Strategies
    * One node per tenant
    * One node per big tenant, shared node for multiple tenants
    * Nodes per tenant by region

## Guest Lecture 2

* Product standards
  * Accessibility - eg color blind, 
  * Business configurations - no complexity for consultants; good UI
  * Functional correctness
  * Globalization - eg internationalization
  * Operations support
  * Performance
  * Security
  * Software lifecycle - companies like H & M need to upgrade everything in 2 hours
  * UX consistency

---

* Scalability - scale to demand
* Loose coupling
  * SAP allows features to be deployed with one click through a pipeline
  * Not possible if everything were a monolithic library?
* Composability
* Replaceability - want to replace component without affecting collaborators

---

Lessons learned

* Keep middleware 'dumb'
* Failover - spend less time trying to stop the inevitable, and a bit more time in dealing with it gracefully
* Logs - distinguish errors from various components, vs putting all logs together

## Guest Lecture 3

### The Need for Context in Software Engineering

> Gail C. Murphy

* Lot of modern software development workflow involves switching tasks
  * 47 times per hour
  * Sometimes to remain productive, eg waiting for builds or feedback
* Study, definition & use of context can improve flow of software by reducing accidental complexity & allowing focus on essential complexity
* Context types
  * Static artifacts - eg IDE
  * History - eg similarity of bugs
  * Dynamic execution - eg relating runtime objects to code
  * Individual activity - eg content assist; IDE features
  * Team activity - eg JIRA, Travis, tools for synchronizing activity
* Four steps
  * Recognize
    * Often easier in physical entities; location based, etc
  * Explain
  * Experiment
  * Build