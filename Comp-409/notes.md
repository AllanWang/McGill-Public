# Comp 409

> Clark Verbrugge 

> [Course Webpage](http://www.sable.mcgill.ca/~clump/comp409/)

# Acronyms

| | |
--- | ---
UMA | Uniform Memory Access
NUMA | Non-Uniform Memory Access
CS | Critical Section
UP | Uni-Processor
MP | Multi-Processor
SMP | Symmetric Multi-Processor
CMP | on Chip Multi-Processor
CMT | Coarse-grained Multi Threaded
FMT | Fine-grained Multi Threaded
SMT | Simultaneous Multi Threaded
IPC | Instructions Per Cycle
AMO | At Most One
ME | Mutual Exclusion
FA | Fetch and Add
CAS | Compare and Swap
TS | Test and Set
CV | Condition Variable

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
    waiting stage ->id 
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

Let $t_A% be the last thread at level stage to write init
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
    while(lock == 1)
    while (TS(lock, 1) == 1)
        while(lock == 1)
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
    while(true)
        Data d = produce()
        P(spaces)
        buffer[pindex] = d
        pindex = (pindex + 1) % n
        V(filled)

consumer:
    while(true)
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