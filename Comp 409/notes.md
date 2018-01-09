# Comp 409

> Clark Verbrugge 

> [Course Webpage](http://www.sable.mcgill.ca/~clump/comp409/)

# Lecture 1 - 2018/01/09

* Parallelism
    * Control the ways things happen at the same time
* Concurrency
    * Define constraints on execution, which is influenced by other aspects such as the OS
    * Things may happen at the same time

* Process - large heavyweight with its own address space and handles
* Thread - lightweight with shared addresss space
    * Efficiently switched - changing threads may just involve changing some pointers, as the rest of the space may be the same

* Asynchronous Execution - threads execute at their own rate (dictated by OS)

* Thread Interactions
    * No interaction (independent) - "embarrassingly parallel"
    * Share memory (need to consider synchronization, coordination, resource consistency, etc)
    * 