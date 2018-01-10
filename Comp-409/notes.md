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
* Thread - lightweight with shared address space
    * Efficiently switched - changing threads may just involve changing some pointers, as the rest of the space may be the same

* Asynchronous Execution - threads execute at their own rate (dictated by OS)

* Thread Interactions
    * No interaction (independent) - "embarrassingly parallel"
    * Share memory (need to consider synchronization, coordination, resource consistency, etc)
	
## Threads

* OS Part
    * Thread ID
    * Schedule policy
    * Priority
    * Signed mask
    * For this course, wew will assume little or no control (black box)
* User Part
    * Register set
    * Stack pointer (separate stacks)
    * PC
    * Shared memory

* Amdahl's Law
    * Total time is based on two pieces: sequential part + parallel part
    * Parallel part can be distributed among the $n$ threads: $t = s + p / n$
    * Speedup: $\dfrac{1}{(1 - p) + \frac{p}{n}}$

* Threads are good for 
    * Hiding latency (cache miss, pipeline stalls)
    * Switching context efficiently
    * Keeping CPU busy
    * Increasing responsiveness
        * Eg long running execution + GUI thread for listening for inputs & interrupts

* Appropriate Parallelism
    * Web server - requests are naturally parallel

* Downsides
    * Overhead
    * May be difficult to debug

* Is concurrency fundamentally different?
    * We may reason that with Turing Machines, n TMs does not give any more power than 1 TM. However, with parallel execution, there are some subtle differences.
    * Example 1 - consider the following conversions & constraints:<br>
        a &rarr; ab<br>b &rarr; ab<br>
        There cannot be any sequence of `aa` or `bb`.

        If we started with `ab`, we would not be able to make any conversions.
        However, if we did both conversions in parallel and ignore the middle transition, we will be able to transition to `abab`
    * Example 2 - consider 5 items spaced evenly in a circle, with equal distance from the center point. Our goal is to rotate them all at the same time. If we were to do it sequentially, there will be a speed for which an item will cross over another. However, if we were to do it all in parallel, which would not be an issue.