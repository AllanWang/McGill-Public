# Comp 409

> Clark Verbrugge  &bull; [Course Webpage](http://www.sable.mcgill.ca/~clump/comp409/)

# Acronyms

| | |
--- | ---
AMO | At Most One
CAS | Compare and Swap
CMP | on Chip Multi-Processor
CMT | Coarse-grained Multi Threaded
CS | Critical Section
CV | Condition Variable
FA | Fetch and Add
FMT | Fine-grained Multi Threaded
IPC | Instructions Per Cycle
JLE | Jump Less Than
JMP | Jump
JNS | Jump Not Signed
ME | Mutual Exclusion
MP | Multi-Processor
NUMA | Non-Uniform Memory Access
PC | Process Consistency
SC | Sequential Consistency
SMP | Symmetric Multi-Processor
SMT | Simultaneous Multi Threaded
TLS | Thread Local Storage
TS | Test and Set
TSD | Thread Specific Data
UMA | Uniform Memory Access
UP | Uni-Processor
LL | Linked List

# Interfaces

## Semaphore

```java
/**
 * Block thread until [count] permits are available before acquiring them
 * acquire() = acquire(1)
 */
void acquire(int count)

/**
 * Get number of currently available permits
 */
int availablePermits()

/**
 * Acquire and return all available permits
 */
int drainPermits()

/**
 * Makes [count] more permits available
 * release() = release(1)
 */
void release(int count)

/**
 * Pseudo: acquire()
 */
void P()

/**
 * Pseudo: release()
 */
void V()
```

## Thread

```java
/**
 * Interrupts the thread; thread must abide by
 * interruption to actually be affected
 */
void interrupt()

/**
 * Checks if thread is interrupted
 */
boolean isInterrupted()

/**
 * Makes current thread wait for specified thread to die
 * Optionally add long parameter for max number of millis
 * to wait
 */
void join()

/**
 * Launches thread by making JVM call run()
 */
void start()

/**
 * Sleeps current thread for specified time
 */
static void sleep(long millis) throws InterruptedException
```

## Object

```java
/**
 * Wakes up single thread waiting on monitor
 * Often times, notifyAll() is preferred
 */
void notify()

/**
 * Wakes up all threads all threads waiting on monitor
 */
void notifyAll()

/**
 * Causes current thread to wait until notify()
 * or notifyAll() is called from this object
 * Optionally specify timeout (long millis)
 */
void wait() throws InterruptedException
```

# Lecture 1. 2018/01/09

* Parallelism
    * Control the ways things happen at the same time
* Concurrency
    * Define constraints on execution, which is influenced by other aspects such as the OS
    * Things may happen at the same time

* Process &mdash; large heavyweight with its own address space and handles
* Thread &mdash; lightweight with shared address space
    * Efficiently switched &mdash; changing threads may just involve changing some pointers, as the rest of the space may be the same

* Asynchronous Execution &mdash; threads execute at their own rate (dictated by OS)

* Thread Interactions
    * No interaction (independent) &mdash; "embarrassingly parallel"
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
    * Speedup: $\dfrac{1}{(1 &mdash; p) + \frac{p}{n}}$

* Threads are good for 
    * Hiding latency (cache miss, pipeline stalls)
    * Switching context efficiently
    * Keeping CPU busy
    * Increasing responsiveness
        * Eg long running execution + GUI thread for listening for inputs & interrupts

* Appropriate Parallelism
    * Web server &mdash; requests are naturally parallel

* Downsides
    * Overhead
    * May be difficult to debug

* Is concurrency fundamentally different?
    * We may reason that with Turing Machines, n TMs does not give any more power than 1 TM. However, with parallel execution, there are some subtle differences.
    * Example 1 &mdash; consider the following conversions & constraints:<br>
        a &rarr; ab<br>b &rarr; ab<br>
        There cannot be any sequence of `aa` or `bb`.

        If we started with `ab`, we would not be able to make any conversions.
        However, if we did both conversions in parallel and ignore the middle transition, we will be able to transition to `abab`
    * Example 2 &mdash; consider 5 items spaced evenly in a circle, with equal distance from the center point. Our goal is to rotate them all at the same time. If we were to do it sequentially, there will be a speed for which an item will cross over another. However, if we were to do it all in parallel, which would not be an issue.

# Lecture 2. 2018/01/16

## Hardware

* UP &mdash; Basic uniprocessor
    * CPU &mdash; cache &mdash; memory
    * Low level parallelism &mdash; modern, super-scalar processor, pipelined, multi-issue
* Time-sliced multiprocessor
    * Simulated parallelism
* MP &mdash; Multiprocessor
    * Many [CPU &mdash; cache] to shared memory
* UMA &mdash; Uniform memory access
    * All memory accesses cost the same (modulo cache)
    * Note some caches need to reflect the same view on memory
    * Caches need to be consistent
* NUMA &mdash; Non-UMA
    * Many [CPU &mdash; cache] to shared memory (slow) & many local memories (fast)
* SMP &mdash; Symmetric MP
    * Multiprocessor with same CPUs
    * Disadvantage &mdash; given that lots of programs are single threaded and the CPUs are independent, some of them may be doing wasted or duplicate work
* CMP &mdash; on-Chip MP
    * CPUs & caches are on a chip
    * Faster cache communication
    * Same disadvantage as SMP
* CMT/FMT &mdash; Coarse/fine grained multi-threaded
    * CMT &mdash; context switch every so many cycles
        * Adv &mdash; single threaded is effective
        * Disadv &mdash; no real parallelism
    * FMT &mdash; context switch every cycle
        * May be referred to as barrel-processing
        * Cray's TERA was FMT based
            * Had 70 threads
            * Had no data-cache, meaning data access involves 70 cycles. However, due to the threads, there is no idle
            * Not necessarily responsive, but has high throughput
* SMT &mdash; Simultaneous MT
    * Multiple functional units
    * Commercialized as hyper-threading

---

Example

T1 | T2 | T3
--- | --- | ---
add | load | fadd
load | add | fadd
add | add | fadd

Assume each process has 2 x ALU, 2 x FPU, 1 x LSU
int/float ops &rarr; 1 cycle
load &rarr; 2 cycles

---

UP

slot 1 | slot 2 |
--- | ---
T1.1 add | T1.2 load
&mdash; | &mdash;
T1.3 add | &mdash;
T2.load | &mdash;
&mdash; | &mdash;
T.2.add | T2.add
T3.fadd | T3.fadd
T3.fadd | &mdash;

---

SMP/CMP (2 processes)

| P0 | | P1 | |
--- | --- | --- | ---
slot1 | slot2 | slot1 | slot2
T1.add | T1.load | T2.load | &mdash;
&mdash; | &mdash; | &mdash; | &mdash;
T1.add | &mdash; | T2.add | T2.add
T3.fadd | T3.fadd | &mdash; | &mdash;
T3.fadd | &mdash; | &mdash; | &mdash; | &mdash;

---

### Waste

* Vertical Waste &mdash; waste on next cycle
* Horizontal Waste &mdash; waste for slots in a cycle
* Low-level instruction-level parallelism is in practice limited

---

* IPC &mdash; instructions per cycle
    * Need a good instruction mix
    * In practice, IPC &le; 3

## Atomicity

* Thread attribute definitions
    * Read set &mdash; set of variables read from but not written to
    * Write set &mdash; set of variables written to (and perhaps read from)
    * Independence &mdash; when each write set is disjoint from all other read & write sets

---

Example

Consider the case where x = y = z = 0, and where
* Thread 1 executes x = y + z
* Thread 2 executes y = 1, z = 2

Thread 1s execution is not atomic. Instead, it is:
* load r1, [y]
* load r2, [z]
* add r3, r1 + r2
* store r3, [x]

Given that no assumptions can be made about the speeds of either CPU, thread 2 may execute its two instructions in between any of the executions of thread 1. So instead of having the desired response of x = 0, thread 1 may product three different outputs.

---

Usually

* Assignment of constant to machine word sized value is atomic
    * Assignments to bigger sizes may be separated

In Java

* Assignment to 32-bit or smaller type is guaranteed atomic
    * Includes aspects like x = y + z
* 64-types (long, double, etc) are not necessarily atomic; can be declared as volatile

# Lecture 3. 2018/01/18

For word sized `x = y + z`, assignment is atomic, but computation of `y + z` may not be.
Note that if no other thread writes to `y` or `z`, then the computation will appear to be atomic

> An expression has a critical reference if it uses a variable that some other thread changes

Word sized expressions with "at-most-one" critical reference at a time are "effectively" atomic. The constraints are that:
1. An expr with at most one CR is not read by other threads
2. An expr with no CRs may be read by other threads

## Examples

---

x = y = 0 

Thread 1 | Thread 2
--- | ---
x = y + 1 | y = y + 1
1 CR, x not read | 0 CR, y is read

As AMO is satisfied in both cases, there are no unexpected values to be considered. The process will happen with one expression before the other without interleaving

---

x = y = 0

Thread 1 | Thread 2
--- | ---
x = y + 1 | y = x + 1
1 CR, x is read | 1 CR, y is read
load r1, [y] <br> inc r1 <br> str r1, [x] | load r1, [x] <br> inc r1 <br> str r1, [y]

Neither satisfy AMO, so there may be interleaving (eg resulting in x = 1, y = 1)

\# interleavings need to consider <br>
n threads, each with m atomic instructions
$\dfrac{(nm)!}{(m!)^n}$

For n = 2, m = 3 &rarr; 20 possibilities

To resolve this, we should only allow 1 thread to execute such changes at one time &rarr; critical section

Assume 2 threads with unique ids 0 and 1. <br>
We will go through the stages of `init`, `enter protocol`, `exit protocol`

---

```java
init()
    turn = 0

enter(int id)
    while (turn != id)  // spin

exit(int id)
    turn = 1 &mdash; id

```

In this case, given that the turn is initially for thread 0, if thread 1 shows up first and thread 0 has no intention of entering the CS, thread 1 will need to wait unnecessarily.

---

```java
init()
    flag[0] = flag[1] = false // indicates interest for thread[id]

enter(int id)
    while (flag[1 &mdash; id])  // spin
    flag[id] = true       // indicate self interest

exit(int id) 
    flag[id] = false
```

`enter` is not actually atomic. If both show up at the same time with both flags set to false, both will pass the spin and set their own flags to true

---

```java
init()
    flag[0] = flag[1] = false // indicates interest for thread[id]

enter(int id)
    // same as previous but with sequence switched
    flag[id] = true       // indicate self interest
    while (flag[1 &mdash; id])  // spin

exit(int id) 
    flag[id] = false
```

This case will now enforce ME, but there may be an issue when both threads show up, both threads set their flag to true, and both threads spin forever (deadlock).

---

```java
init()
    flag[0] = flag[1] = false // indicates interest for thread[id]

enter(int id)
    flag[id] = true       // indicate self interest
    while (flag[1 &mdash; id]) 
        flag[id] = false  // give up self interest
        randSleep()       // sleep for some random time
        flag[id] = true   // show self interest again

exit(int id) 
    flag[id] = false
```

For this to work, our delays cannot sync together. Though our sleep uses random durations, it is possible for both threads to wait the same time, set both their flags, then repeat (livelock)

Note that
* small delay &rarr; increased chance of lock-step behaviour
* big delay &rarr; more likely for long unnecessary wait

---

## Peterson's Algorithm

```java

init()
    turn = 0
    flag[0] = flag[1] = false

enter(int id)
    flag[id] = true  // show self interest
    turn = id        
    while (turn == id && flag[1 &mdash; id]) // spin

exit(int id)
    flag[id] = false
```

Thread 0 | Thread 1
--- | ---
flag[0] = true | flag[1] = true
turn = 0 | turn = 1
while (turn == 0 && flag[1]) | while (turn == 1 && flag[0])

Turn will be set to either `0` or `1` in all cases. Without loss of generality, we will assume `turn` ends as `1`. In this case, thread 0 has set `turn` first, and gets to execute first.

---

What we are looking for
1. ME over the CS
2. Absence of deadlock &mdash; if multiple threads try to get into CS, one succeeds
3. No unnecessary delay &mdash; if no one is in the CS, we should get in promptly
4. Eventual entry &mdash; if we try & get into the CS, we should eventually succeed (starvation free)

## Java & PThreads

POSIX - standard and standalone library - links to apps

Better if integrated into language

### Java

* Multithreading built in
* Core language/API
* Higher level API - `java.util.concurrent`
* | Thread | |
  --- | ---
  `runnable` | interface determining code to execute
  `start()` | native code - gets the thread running
  `run()` | runs `runnnable` if not null
* Threads may be created by subclassing thread to run what we want, or by creating a runnable object and passing it to the thread constructor. Typically the latter is used; the former is if you wish to change the behaviour of threads, not just the code it runs.
* Program stops when all threads are finished
* Subtlety - program exists when all non-daemon threads (default) finish
    * Daemon threads are intended as services, and terminate automatically when appropriate
* A thread that has been started may not necessarily be running - OS may choose to switch it to a scheduled or de-scheduled state
* Threads may also sleep, which goes to a waiting mode, or be woken up
* Threads may be terminated, leading to a stopped mode

# Lecture 4. 2018/01/23

## Java's Thread Model

* Priority based
* Nominatively priority-preemptive
* Threads at highest level is executed in preference
* For threads of same priority, should run with round robin time slices (but not guaranteed)

| Thread API | |
---|---
`sleep(millis)` | Lower bound idle time
`yield()` | Give up time slice
`Thread.currentThread()` | Get reference to current thread
`isAlive()` | returns `true` if thread could be scheduled. Always true if called on self (as it wouldn't be callable otherwise). If called on another thread, returns stale information on live state
`join()` | Wait for another thread to finish before continuing

Asynchronous termination is bad. `stop()` and `destroy()` are such methods and are deprecated.

### Basic synchronization

* Every object has a lock, for which only 1 thread can acquire at a time

```java
synchronized(lock) {
    // begin lock
    ...
    // end lock
}
```

Threads that attempt to access an already locked object will wait until it unlocks.

In Java, you can relock locks you own, on the condition that you unlock for the same number of times.

## Volatile Keyword

* Used for variables to indicate that it may change arbitrarily/asynchronously
* Helps avoid accidental optimization (eg when a thread checks for a flag and loops, and the thread itself never changes the flag)

## PThreads

* POSIX library
* `pthread.create(&threadHandle, attributes, startRoutine, args)`
* Detached (daemon)
    * May not be joined
    * Act as services
* Joinable (non-daemon)
    * Must join with them

| Scheduling | |
---|---
SCHED_RR | round-robin, time sliced, priority preemptive
SCHED_FIFO | run to completion, no time slice
SCHED_OTHER | offered by OS

## Mutual Exclusion

* Mutex objects
    * `acquire()` and `release()`
    * Up ot developer to
        * Acquire before release
        * Release in same thread
    * By default, no recursive acquire allowed

---

* Filter Lock
    * Generalization of the Peterson's 2-process tie breaker
    * n - stages, n threads, 1 thread "wins"
    * At each stage, ensure that at least one thread trying to get in is successful (ensure progress)
    * If more than 1 thread is trying to enter, at least one is blocked

```java
init:
    stage: id -> stage
    int stage[n]
    waiting stage -> id 
    initiation[n]
    stage 1 -> not trying to set n?

enter id:
    for s in 0 until n:
        stage[id] = s
        waiting[s] = id
        do:
            spin = false
            for j in 0 until n:
                if j == id continue
                if stage[j] >= s && waiting[s] == id:
                    spin = true
                    break // from for loop
        while spin

exit id:
    stage[id] = 0
```

# Lecture 5. 2018/01/25

From last class, part of the proof was by contradiction (at least one thread left behind)

Let $t_A$ be the last thread at level stage to write init
Waiting stage = $t_A$

Another thread is in $t_X$
We know that waiting[stage] = $t_X$ &rarr; waiting[stage] = $t_A$
We know $t_A$ writes into stage[t_X] = stage before writing init writing.

stage[tx] = tx &rarr; waiting[stage] = tx &rarr; waiting[stage] = ta

We know $t_A$ checks stage[j] after writing to wait


---

* filter lock &rarr; locking &rarr; doorway piece (finite # instructions), spinning piece
* fairness &rarr; FCFS
    * If $t_A$ finished doorway before thread $t_B$, then $t_A$ gets in CS before $t_B$
* filter lock
    * not FCFS
    * starvation free

---

### Ticket Algorithm

* classic locks
    * take next #
    * wait for # to be called

```java
init:
    next = 0
    int turn[n] = 0
    number = 0

enter id:
    turn[id] = next++        // needs to be atomic
    while turn[id] != number // spin

exit:
    number++
```
---

### Bakery Algorithm

* Broken ticket dispenser

```kotlin
init:
    turn[id] = 0

enter id:
    turn[id] = (0 until n).map { turn[it] }.max() + 1 // needs to be atomic
    (0 until n).filter { it != id }.forEach {
        while (turn[it] != 0 && turn[id] > turn[it])  // spin
    }
```

* be careful about wrap-arounds, as there is eventual overflow
* hardware primitive - special instructions

---

Test and set

```java
TS x y:           // all atomic
    temp = x
    x = y
    temp

init:
    lock = 0

enter:
    while (TS(lock, 1) == 1) // spin

exit:
    lock = 0
```

---

```java
enter:
    while (lock == 1)
    while (TS(lock, 1) == 1)
        while (lock == 1)
```

* Not FCFS
* Not necessarily starvation free

---

Fetch and Add

```java
FA x c:             // all atomic
    temp = x
    x += c
    temp
```

---

Compare and Swap

```java
CAS x a b       // all atomic, return type indicates success/fail
    if x != a
        false
    else
        x = b
        true
```

---

## Queue Locks

MCS

* Works for arbitrary # of threads
* Maintains explicit queue
    ```java
    class Node {
        Node next
        boolean locked
    }
    ```
    * Each thread has node and a static tail

```java
enter:
    me.next = null
    pred: Node = TS(tail, me)
    if pred != null
        me.locked = true
        pred.next = me
        while me.locked         // spin

exit:
    if me.next == null
        if CAS(tail, me, null)
            return
        while me.next == null   // spin
    me.next.lock = false
    me.next = null
```

# Lecture 6. 2018/01/30

MCS Cont
* (+) FCFS
* (+) Cache friendly
* (+) Space efficient
    * Every thread needs one node
* (-) Needs both TS & CAS
* (-) Can spin on exit

---

CLH Lock

```java
class Node {
    boolean locked
}

class Thread {
    Node me = new Node()
    Node myPred = null
}

enter:
    me.locked = true        // signifies to others that they should be locked
    while (myPred.locked)   // spin

exit:
    me.locked = false
    me = myPred
```

* Notice that nodes get moved around, and there's no spin on exit
* Still FCFS

---

## Java's Locks (synchronous)

"Thin" Lock (Bacon lock)
* Optimized lock, contention is rare
    1. Lock an unlocked object
    2. Recursive lock on lock you own (shallow)
    3. Deep recursive locking (over 256)
    4. Contention (shallow, deep)
* Java aims to make 1. and 2. fast, at the expense of 3. and 4.
    * Use mutex (pthread) for 3. and 4.
* Each object has lock word
    * Divided into 8, 8, 15, 1 bits
    * First 8 bits is reserved
    * Second 8 bits - recursive lock count (-1)
    * 15 bits represent thread id of owner
        * 0 represents no thread, and consequently no lock
    * Last 1 bit = lock shape - 0 = cheap (thin); 1 = expensive (fat) loc
* Lock done using `CAS(lock, id << 1, 0)`
    * true &rarr; locked, false &rarr; check ownership
        * ownership: true &rarr; locking again, add 1 to lock count. Make sure there is no overflow for the count
    * If fail occurs anywhere, transition into "fat lock"
        * Only owner can do that
        * If we don't own it, we spin until we do, or until it becomes a fat lock (known from shape bit)

"Fat" Lock
* Need mutex
* Lock divided into 8, 24, 1
* 24 bit - pointer to mutex
* 1 bit - shape bit (1)

---

Semaphore & Mutexer

* Spinning uses CPU
* Better if we went to sleep(), and someone else wakes us up
    * However, easy to get lost wakeup

Semaphore
* Blocking synch &rarr; sleep & wake
* Abstraction
* P(S) "down" (all atomic)
    ```java
    while (s == 0)
        sleep()
    s--
    ```
* V(s) "up" (all atomic)
    ```java
    s++
    wakeup()    // call some wakeup
    ```

Binary Semaphore
* Always 0 or 1
* Starts at 1

Counting Semaphore
* Not just 0 & 1
* Useful for representing resource

Producer/Consumer (bounded buffer)
* Data buffer[n]
* Semaphore spaces = n
* Semaphore filled = 0

```java
produce:
    while (true)
        Data d = produce()
        P(spaces)
        buffer[pindex] = d
        pindex = (pindex + 1) % n
        V(filled)

consumer:
    while (true)
        Data d;
        p(filled)
        d = buffer[cindex]
        cindex = (cindex + 1) % n
        V(spaces)
        consume(d)

```

Other Binary Semaphore
* Starts at 0 &rarr; signalling
    * Makes threads wait for each other

Drawbacks
* 2 ideas together - mutual exclusion & signalling
* P(), V() &rarr; separate, fragile design

# Lecture 7. 2018/02/01

## Monitors

* Dijkstra, Per Brinch Hansen
* Package data
* Operations are mutually-exclusive

```java
class Monitor {
    private int d1, d2, ...

    synchronized void foo() { ... }

    synchronized int bar() { ... }
}
```
* Condition variable for thread communication
    * Always associated with monitor (mutex)
    * Can have more than 1 (ie Pthreads)
    * In base Java &rarr; one, unnamed
    * 2 ops

        | Pthread | Java |
        --- | ---
        `sleep()` | `wait()`
        `signal()` | `notify()` (can only invoke inside monitor)

    * Calling `wait()` inside a monitor will give it up & sleep (atomic)
    * When another thread calls `notify()`, sleeping thread may be woken up. Note that a thread that is woken cannot continue on until it has reacquired the lock

How does it work?
* Have a queue (set) of threads trying to get into the monitor (mq)
* Each CV implies another queue &rarr; cvq

Atomic ops

```java
enter T:
    if no one is in T
        enter
    else
        mq & sleep

exit T:
    wake up thread in mq 

wait T cvq:
    add T to cvq
        sleep
    exit

notify cvq:
    take a thread from cvq & put to mq

notifyAll cvq:
    move all threads from cvq to mq
```

* Notice that we wake one thread with `notify()`
* Upon being woken up, conditions may not hold; hence conditions should be checked again (typically with while loop)
* Spurious wakeups - may be woken up without being notified
    * Also solved by waiting in a while loop

## Different semantics for CV
* Signal & Continue
    * Notifier retains control of monitor
    * Woken thread competes with other threads for entry
* Signal & Wait
    * Notifier transfers monitor control to the woken thread
    * Notifier needs to re-acquire lock to continue
* Signal & Urgent Wait
    * Same as signal & wait, except a woken thread will give control back to the notifier once finished
* Reader/Writer Lock
    * DB context - only 1 write at a time
    * Multiple concurrent readers

---

R/W Lock

```java
int readers = 0
BinarySemaphore r, rw // init to 1

reader:
    down r
    readers++
    if readers == 1   // acquire lock if first reader
        down rw
    up r
    read()
    down r
    readers--
    if readers == 0   // give up lock if last reader
        up rw
    up r

writer:
    down rw
    write()
    up rw

```

* Note that this gives preference to readers
    * A continuous stream of readers may starve waiting writers
* There are variants for writer's preference & fair solution

---

## Termination

* Asynchronous termination may easily corrupt the state
    * Eg terminating thread when it's in the middle of a syscall
    * Stop threads instead by using a polling mechanism
* Java does not have cancellation, but instead has interrupts
    * Many operations will capture it by default and throw an `InterruptedException` to be handled. Note that some exceptions may be thrown by spurious wakeups. Threads can also use `.interrupted()` to check its interruption status.

## Priorities

* Nominatively priority pre-emptive
* Java - 10 priorities
* Pthreads - RR, FIFO
* NT - 7 levels

# Lecture 8. 2018/02/06

## Priority Inversion

* Low level thread locks and executes &rarr; high priority thread enters and attempts to acquire lock &rarr; medium priority thread comes in as well and acquires lock from low priority &rarr; high priority thread must wait for medium priority thread to finish before the lock can be acquired 

* Mars Pathfinder
    * High priority thread - bus manager
    * Medium priority thread - communication
    * Low priority thread - meteor logical
    * Once priority inversion occurs, another watchdog thread will reset everything

---

Solutions

Priority Inheritance

* Thread holding a lock will temporarily acquire the priority of the highest priority thread waiting for the lock

Priority Ceilings

* Locks are associated with priority
    * High priority lock &rarr; high priority thread

Barrier

* Want thread to wait for each other

For more than 2 threads

```java
volatile int numThreads = n

// for each thread
while true
    // work
    if FA(numThreads, -1) == -1
        numThreads = n
    else
        while numThreads != 0
            yield()
```
Sense Reversing Barrier

```java
boolean phase = true
boolean phases[n] // all false

if FA(numThreads, -1) == -1
    numThreads = n
    phase = phases[id]
else
    while phases[id] != phase
        yield()

```

---

TSD/TLS
* Stack data - local to threads
* Global data - shared
Sometimes convenient to have thread-specific versions of global data

errno in C
* Global data - could get modified by different threads and be inconsistent
* Less confusion if each thread has own errno

TSD - pthread
TLS - Java

```java
// Java TLS
static fls = new ThreadLocal()

// per thread; independent
tls.set(2) // t0
tls.set(1) // t1
```

TSD
* Allocate
* pthread key-create (&keydestination)

--- 

Dining Philosopher Problem

5 philosophers at a round table with 5 plates and 5 utensils. Each will think, eat, and repeat. Eating requires getting two utensils adjacent to the philosophers. Goal is to avoid deadlock.

Solutions

---

Single Global Mutex

```java
think()
P(global)
eat()
V(global)
```

Works, but not very concurrent

---

Mutex per Utensil

c = mutex[5]

```java
think()
P(c[i])
P(c[(i + 1) % 5])
eat()
V(c[(i + 1) % 5])
V(c[i])
```
Doesn't actually work. If everyone tries to grab left utensil, no one will be able to grap right utensil and complete `eat()`

---

Create Global Lock

```java
lock = mutex // global lock
c = mutex[5] // lock per utensil

think()
P(lock)
P(c[i])
P(c[(i + 1) % 5])
V(lock)
eat()
V(c[(i + 1) % 5])
V(c[i])
```

Works, but still not very concurrent.
If philosopher 1 eats, and philosopher 2 attempts to eat, philosopher 2 will hold the global lock and block others who could have eaten from eating.

---

Order the Locks

```java
think()
j = ((i + 1) % 5)
P(min(i, j))
P(max(i, j))
eat()
V(max(i, j)) // order here isn't as important
V(min(i, j)) // but reverse unlock is good practice
```

# Lecture 9. 2018/02/08

## Deadlock

Solutions
* Order resources

Coffman's Condition
* 4 necessary conditions 
    1. Serially reusable resources
    2. Incremental acquisition
    3. No preemption
    4. Dependency Cycle

Livelock

* Threads are not stopped, but are also not making useful progress

Race Condition
* Happening due to lack of ordering guarantees
* Note: different from non-determinism & atomicity

Concurrent Pros
* 2 ordering relations
    1. Intra-thread ordering - program order
    2. Inter-thread - synchronization order
* A data-race in a multithreaded program occurs when two of more threads access the same memory location, with no ordering constraints and at least on of them being a writer

Consensus

* Lots of synch primitives  (TS, FA, CAS)
* We can build locks with any/all of those

```java
caslock

CAS x a b:
    bool rc
    while TS(caslock, 1) == 1; // spin
    if x == a
        x = b
        rc = true
    else
        rc = false
    caslock = null
    return rc
```

* CAS original - fixed amount of time to execute (wait free)
* Simulate CAS - spins, potentially indefinitely
* Wait free
    * Finite # of steps
    * Fault-tolerant
* Consensus problem
    * n threads, each with different values
    * Want to agree on the value
    * Requirements
        * Consistent - all agree in the end
        * Valid - agreed value is one of the starting values
        * Wait-free - finite # steps, fault tolerant

* Consensus number of a sync primitive is the max # of threads for which they can solve the consensus problem

* Binary consensus `{0, 1}`
    * Show we cannot solve 2-consensus
    * Start in a bivalent state
        * System &rarr; `{0, 1}` 
    * End up in a univalent state
        * `{0}` or `{1}`

(I got tired after this part)

* T0: reads a var
    * T1 &rarr; might read or write
    * T1 tree also necessarily exists before T0's action - not univalent
* Therefore both T0 & T1 must both write
    * Could write different vars
* T0 & T1 write different vars
* They both write the same var x
    * Cannot be univalent &rarr; cannot be critical
* R/w primitives have a consensus # of 1

# Lecture 10. 2018/02/15

R/W - consensus #1

---

FA, TS, consensus #2
```java
int decide (int v):
    x = TS(decider, v) // x is old value
    if x == 1:
        return v 
    return x
```

Solves 2 consensus, but not 3

---

CAS, consensus # &infin;

```java
int decide (int v):
    CAS(decider, 1, v)
    return decider
```

## Linearization

* Concurrent programs
    * In general, not functional
    * Output can depend on timing/scheduling

* Correctness
    * If whatever happens in our concurrent program has an equivalent sequential program producing the same output

---

Example - 2 queues p, q - enqueue, dequeue

T0 | T1
--- | ---
1: p.enq(x) | 4: q.enq(y)
2: q.enq(x) | 5: p.enq(y)
3: p.deq() -> returns y | 6: q.deq() -> returns x

(numbers are just for future reference and do not refer to runtime order)

is this linearizable?

* Since p returns y, 5 must occur before 1 (FIFO)
* Since q returns x, 2 must occur before 4
* However, given that the calls in within each thread is sequential, we know that this result isn't possible

--- 

Memory models

T0 | T1
--- | ---
x = 1 | y = 2
b = y  | a = x

(variables start at 0)

Possibilities: (a, b) = (1, 0), (0, 2), (1, 2)

Note that cases like (0, 0) is not possible; invalid interleaving 

--- 
Write-buffering


| P0 | WB0 | Mem | P1 | WB1
| --- | --- | --- | --- | ---
| x = 1 | &rarr; x = 1 | x = 0 | y = 2 | &rarr; y = 2 
| - | - | y = 0 | - | -
| b = y | &rarr; b = 0 | a = 0 | - | -
| - | - | - | a = x | &rarr; a = 0
| - | writes x | x = 1 | - | -
| - | - | y = 2 | - | writes y
| - | - | a = 0 | - | -
| - | - | b = 0 | - | -

As a result, with buffering, we can have (0, 0).

&therefore; we cannot just think of interleavings

* Model types
    * Strict consistency - operations necessarily follow program order (intra-threads)
    * Sequential Consistency (SC) - operations appear to execute in program order
    * Both cases result in a global timeline for operations

* Coherence
    * The write to a given variable must be seen in the same order by all threads
    * Doesn't require sequential consistency. Every variable has their own timeline

* Process Consistency (PC)
    *  T0 | T1 | T2 | T3
       ---|---|---|---
       x = 1 | x = 3 | a = x(1) | d = x (3)
       y = 2 | y = 4 | b = y (2) | e = y (4)
       | - | - | c = x (3) | f = x (1)

    * T2 sees T0 before T1
    * T3 sees T1 before T0
    * Note that this is not coherent

* Note
    * SC implies cohrerence and PC
    * PC does not imply coherence
    * Coherence does not imply PC

# Lecture 11. 2018/02/20

No class

# Lecture 12. 2018/02/22

Intel/AMD
* Memory management implied in the hardware manual
* White paper
    * Informal rules
    * "litmus" tests
* Some kind of casual consistency
* IRIW - independent read independent write
    * Probably don't want, but not ruled out
  <br>

  P0 | P1 | P2 | P3 
  ---|---|---|---
  x = 1 | y = 1 | eax = x, ebx = y | ecx = y, edx = x

  For P2, it sees eax = 1, ebx = 0, meaning P0 happened before P1
  For P3, it sees ecx = 1, edx = 0, meaning P1 happened before P0

* Also cases that should not happen, but can be obsered in practice
  n6 <br>

  P0 | P1 
  --- | ---
  x = 1 | y = 2
  eax = x | x = 2
  ebx = y | |

  Could observe that eax = 1, ebx = 0, x = 1

* Could happen with write buffers
    * Order for which they are committed to main memory is undefined
* IRIW becae disallowed
* MFENCE - memory fence to monitor read write access
* Same processor writes are ordered and observed in the same order by all others
* Constraints on inter-process ordering
    * Any 2 stores are seeing consistent ordering by processes other than those doing the write. Leaves opens another case n5
    * n5

      P0 | P1
      ---|---
      x = 1 | x = 2
      eax = x | ebx = x

      eax = 2, ebx = 1
      not disallowed, but also not observed
* x86-TSO - abstract model by academics
    * Allow everything observed
    * Respect litmus tests
    * Every hardware thread has its own write buffer
        * All writes stored in order
        * Committed in order
        * Has no overwrites
    * Global lock that can be acquired by any hardware thread (with constraints)
    * MFENCE
        * All WB flushes must be done before
    * Some instructions
        * LOCK: prefix - thread must acquire global lock
            * While lock is held, no other thread may read
            * Buffered write can be committed to memory at any time except when another thread holds the lock
            * Before releasing lock, WB must be empty
            * A thread is _blocked_ if it does not hold the lock & someone else does
        * Rp[a] = v : `p` can read value `v` from address `a` if `p` is not blocked; there are no writes to `a` in WB<sub>p</sub> and mem[a] = v
        * Rp[a] = v : `p` can read `v` from address `a` if `p` is not blocked, and p has `a` (latest) store "a = v" in WB<sub>p</sub>
        * Wp[a] = v : `p` can write `a = v` into WB<sub>p</sub> at any time
        * &tau;p : if `p` is not blocked, it can silently send the oldest write in WB<sub>p</sub> to memory
        * Fp : if WB<sub>p</sub> is empty, `p` can issue an MFENCE instruction
        * Lp : if the lock is not held by another process, `p` can acquire it
        * Up : if `p` has the lock & WB<sub>p</sub> is empty, we can release the lock
        * progress condition : all buffered writes are eventually committed
        * Example

          | P: WB<sub>p</sub> = [0x55] = 0 | Q: WB<sub>q</sub> = [0x55] = 7 |
          |---|---|
          | Lock : Inc [0x55] | |
          | Lp | |
          | Rp[0x55] = 0 | |
          | Wp[0x55] = 1 | |
          | &tau;p (0x55 = 0) | |
          | &tau;p (0x55 = 1) | |
          | Up | &tau;q |

            * Without lock, p can begin increment, q can set to 7, and p can increment the new value by 1 &rarr; 8
        * spinlock
            * Address of lock is eax
            * Start: Lock : Dec[eax]
              JNS : enter (jump no sign)
            * Spin: CMP[eax], 0
              JLE : spin
              JMP start (jump)
            * Exit : MOV[eax], 1

# Lecture 13. 2018/03/13

Missed class

# Lecture 14. 2018/03/15

Lock free designs make use of CAS, LL/SL, etc as opposed to locks

```java
tryAdd(Node n, Node prev):
    n.next = prev.next
    return CAS(prev.next, n.next n)
```

Sadly these naive methods do not work.
Given a list H &rarr; `x` &rarr; `y` &rarr; `z` &rarr; T:

1. If one thread tries to remove `x`, and another thread tries to add `w` between `x` and `y`, `w` will be lost.
2. If onne thread tries to remove `x` and another thread tries to remove `y`, both may succeed with `y` remaining in the list.


Various solutions exist
* Valois - "auxiliary nodes"
* Time Harris - lazy solution - mark node to be deleted then delete lazily

---

```java

tryAdd(Node n, Node prev):
    next = prev.next
    return CAS(prev.next, n.next to false, n to false)

tryRemove(Node n, Node prev):
    Node succ = n.next
    if CAS(n.next, succ to false, succ to true): // mark first
        CAS(prev.next, n to false, succ to false)  // delete is ok to fail
        return true
    return false

find(int data):
    while(true):
        pred = H
        curr = pred.next
        while curr != T: @restart
            succ = curr.next
            while curr.marked:
                if !CAS(pred.next, curr to false, succ to false):
                    continue@restart
                curr = succ
                succ = curr.next
            if curr.data == data:
                return curr
            pred = curr
            curr = succ
        return null

```

### Elimination Stack

With a lock-free stack, we still have a lot of contention. Stack ops are fundamentally sequential. However, if `push()` and `pop()` show up at the same time, it might be better to just short-circuit the whole thing. ie, `push()` gives the value to `pop`; `push + pop` cancel/do nothing.

---

Lock free exchanger (2 threads exchange data)
* state info (pair of <value, state>)
* need atomic operators to r/w pair atomically
* value: data exchange
* state: `EMPTY`, `WAITING`, `BUSY`
    * `EMPTY` - ready to do the swap <br> CAS(pair, null to EMPTY, A to EMPTY)
        * CAS to set the slow to item & state `WAITING`, but only if the state is `EMPTY`
        * If successful:
            * wait for the first thread to show up
            * spin until we see the state as `BUSY`
            * grab item & set state to `EMPTY`
        * If we wait for too long
            * Try & give up
            * Use CAS to set back to `EMPTY` <br> CAS(pair, A to `EMPTY`, null to `EMPTY`)
                * If successful, we go & do push/pop
                * Else complete the exchange    
    * `WAITING` - one thread (second thread to show up)
        * check the state &rarr; not `EMPTY`
        * grab item
        * try CAS(pair, A to `WAITING`, B to `BUSY`)
            * If successful, we have done our part
            * If fail, restart to resolve push/pop
    * `BUSY` - two threads (third thread to show up &rarr; give up)
        * second thread has completed the exchange
        * grab value `B` 
        * set state to `EMPTY`

Can associate an exchange for the state
* push(x) is expected to exchange x for null
* pop() is expected to exchange null for x
* if successful, don't need to actually go through the state
* in fact, we can associate an array of exchangers
    * threads above random index to try for an exchange
* try for a while, if a matching push/pop does not show up or a non-matching situation
    * push/posh or pop/pop occurs, give up & resort to the lock free stack
* Java's exchanger is based on an array of exchangers

# Lecture 15. 2018/03/20

Lock Free algorithms are problematic in the way that references from deallocated objects may be resued unknowingly

Universal construction - almost any data structure can be made into a lock free version
* Assume data stracture has some interface. We can make another interface that wraps the original to ensure that the invocations are sequential
* Need threads to agree on the order of operations in the log &rarr; consensus 

```java
newInvoc(...):
    do:
        j = consensus i
    while i != j
    // we are now the next op

    s = tail
    r = tail.state
    do:
        r = r.apply s  // without modifying data, check the previous ops to update the state
        s = s.next
    while s != i

    return r
```

One concern is that our consensus algorithm is one shot and not reusable. However, knowing that we can construct a new consensus object with each invocation, this is not an issue.

## Open MP

Not a language, but rather a set of directives (structured comments: pragma) on top of an existing language that makes parallelism easy

| | |
| --- | --- |
`#pragma omp parallel` | For single statements
`#pragma omp for` | For loops; will be partitioned amongst the thread team
`#pragma omp sections` | Another way of partitioning work
`#pragma omp single` | Part within section that should only be executed by one thread
`#pragme omp master` | Part that must be executed by a specified thread (master)

## Data Model

Threads share static, heap data

* `shared(x, y, z)`
* `private(x, y, z)` - each thread has its own copy; uninitialized, not persistent
* `threadPrivate(x, y, z)` - like private, but persistent & presumably initialized
* `firstPrivate` - var is initialized from the present scope
* `lastPrivate` - value is given back to the parent
* `reduction(opList)` - opList can be + (init at 0) or * (init at 1)

...

* flush - mian maechanism for synchronzing cache & memory
    * commits any pending writes
    * invalidates cached copies
    * rules
        * if intersection of 2 flush sets is non-empty, flushes must be sseen in same order by everyone
        * if thread redds, writes, modifies in flush set, program order is respected
        * atomic ops have implicit flush of the vars involved

# Lecture 16. 2018/03/22

## PGAS

* Various parallel models
    * Shared memory
    * Message passing
    * SIMD/SPSMD
        * Data parallel
    * Partitioned Global Address Space
        * Locality of computation is important

## Titanium
* Based on Java: compiler &rarr; C &rarr; executable
* spmd language - processes execute the same code
* To synchronize, add a barrier
    * All threads must reach barrier before any proceed
    * Problematic if we create barriers on many threads and none on others. Some threads may end up stuck indefinitely.
        * Titanium has an analysis tool
            * Single value data - x expr is a constant or function of only single-valued data
        * Barrier must (only) be reachable through single-valued computations/tests

XIO
* PGAS
* APGAS - asynchronous

Basic mechanism:

```java
async {
    ... content
}
```

No guarantee as to when async is done, if at all

```java
finish {
    ... content
}
```

All async's inside the finish block (including nested async's) must be done before this continues

Async indicates that a new thread may be created for the code to run. Often times, the operations may be small, and making a new thread would be extremely inefficient. Some optimizations will be done to see when it is worth making new threads.

Java has executor mechanism:

```java
execute(Runnable r)
```

Given runnables take in nothing and output nothing, they are not always enough. There also exists `Callable<V>` which returns `V` and allows exception throwing

ExecutorServie gives different ways of executing. ThreadPoolExecutor allows for specifications for pools of threads