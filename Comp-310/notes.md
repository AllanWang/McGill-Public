# Comp 310

> [Rola Harmouche](mailto:rola.harmouche@mcgill.ca?Subject=Comp%20310)

# Lecture 1 • 2017/09/06
* Midterm – Wed Oct 18 1:05PM – 2:25PM
* Office hours: Mondays 3:30 – 4:30, Wednesdays 2:35 – 3:35
* Topics – processes, inter-process communication, scheduling, memory managemet, virtual memory, storage management, network management, security
* Operating System – Trusted software interposed between the hardware and the application/utilities
* Computers were very expensive, so utilization needed to be maximized; it was okay for humans to be idle, but was very expensive for computers
  * Batch processing devised; programming was done with punch cards, which were loaded and returned with the output. However, the computer was still idle during loading
* Goal of a computer is to read input, output, then schedule jobs
* Design Concerns
  * Personal/Embedded Systems (eg PDAs)
  * Energy efficiency
  * Compatibility with hardware
  * Ease of use
  * Time Sharing Systems
  * CPU schedules
  * Security/access restriction
  * Batch System
  * Maximize cpu usage
* Access Problem – user wants to access the OS
  * We must ask ourselves
    * Why? (Perhaps to access connected devices)
    * Is the user privileged enough?
* Handling I/O
  * Programmed I/O – CPU transfers data (starts I/O operation) → I/O in progress; CPU is idle and is doing nothing but checking whether the device is free → I/O finishes; CPU resumes work
  * Interrupt-drive I/O – As I/O is in progress, CPU can do other work until an interrupt is issued
    * Slow speed, character device – interrupts result in overhead
* OS service interrupts – interrupt occurs, 'branch' to OS → locate interrupt service routine (ISR) via interrupt vector → execute ISR → return to interrupted program
* Control Access to OS is provided through two levels of architecture: trusted mode and untrusted mode
  * OS (at least the core part (Kernel)) runs in trusted mode
  * Applications/utilities run in untrusted mode
* System call process – system service requested (call) → switch mode; verify args & service → branch to service function via call table → return from service function; switch mode → return from system call

# Lecture 2 • 2017/09/11
* Tutorials are requested for Thursday 5:30 – 6:30
* Processor time – primary resource managed by OS
  * Depends on batch vs time-sharing; uniprogramming vs multiprogramming
    * Batch – devised sequence used to run each program one at a time
    * Time-sharing – set time allotted for each process, delegated by the OS
    * Uniprogramming – one program running at a time; rest may be in memory
      * During wait times (eg IO processing), CPU is idling
    * Multiprogramming – programs seem to be running simultaneously
      * Given that CPU is very fast, processor may swap between programs.
      * CPUs idle time in uniprogramming can be used to execute other programs
* <b>Process Scheduling</b>
  * Each process want to finish as soon as possible, and requires the CPU to finish the task;\nThe CPU will decided which process to run:
    * The process in consideration must be ready to run (known through the ready queue)
    * The dispatcher will look through the ready queue and assign priorities to each process. One of them will be sent to the CPU
  * <b>Process Scheduling Objectives</b>
    * Fairness – give equal & fair access to resources (despite priorities)
    * Differential responsiveness – discriminate among different classes of jobs (eg prioritize services serving immediate user requests)
    * Efficiency – maximize throughput, minimize response time, accommodate as many users as possible
      * Also notes that switching processes takes time
* <b>Memory Management</b>
  * Multiple programs should co-exist in memory so that we don't need to fetch data from disk when swapping
  * Provides <b>protection & relocation</b>
    * Necessary to protect co-residing programs from each other; don't want one program to write over another program's data
    * Program can be placed anywhere in the memory, depending on where it's available
  * <b>How does OS manage memory?</b>
  * Divide memory into partitions & allocate them to different processes
  * Partitions may be <b>fixed</b> or <b>variable</b> size
  * A process
    * Cannot access memory not allocated to it
    * Can request more memory from OS
    * Can release already held memory to OS
    * May only use small portion of allocated memory
* <b>Virtual Memory</b>
  * Allows us to load more processes than that fitting the memory
  * Memory is split into chunks called <b>pages</b>
  * A program does not need all of its pages to be used; some can reside on disk (virtual)
  * OS responsible for retrieving pages from & flushing pages to disk
* <b>Storage Management</b>
  * Needs to be persistent (not affected by process creation/termination), easily accessed, & protected
* Challenges – performance (secondary storage is slow), heterogeneity (different file types and formats), protection
* Data View – user (files & directories) > file system (blocks of data) > disk system (stream of bits)
  * Layers of abstraction offer simpler ways of accessing storage
* Component View – users (logical view) &rarr; access control (directory management) &rarr; file structure &rarr; access methods (file manipulation) &rarr; records (end of logical view) &rarr; buffering &harr; block caches (buffer data blocks to/from disk) &larr; file allocation &harr; free space management &rarr; controller caches &harr; disk scheduling (translates into physical space)
* Abstractions provided by OS
  * Processes or threads
  * Handles lifecycle management, resource management, inter-process communication
    * Processes compete with one another for resources
    * Inter-process communication is the key for cooperating processes that depend on each other; can be done through shared memory approach or message passing approach
* <b>UNIX System Structure</b>
  * Users
  * Shells & commands, compilers & interpreters, system libraries
  * Kernel
    * System-call interface to kernel
    * Terminal handling, I/O, file system I/O, disk & tape drivers, CPU scheduling
    * Kernel interface to hardware
  * Terminal controllers, terminals; device controllers, disks & tapes; memory controllers, physical memory
* <b>Kernel Structures</b>
  * Layered – layers of hierarchy; lower it is, closer to hardware (lower the level of abstraction)
    * Layered structure allows for lower levels to address bugs from higher levels
  * Microkernel – one microkernel; all other processes can be interfaced with the user and the kernel
* Virtual machines emulate another machine on top of a physical machine
  * Multiple kernels on one machine

# Lecture 3 • 2017/09/13
* Process – abstraction of running program; allows for pseudo concurrent operation
  * Eg Web Server
  * Once request is made, check cache, or disk if not found
  * If disk request is served, process may be idle. At this time, other requests may execute through other processes
  * If a process can be satisfied without accessing the disk, it may be executed as another process is fetching from the disk
* Key Elements of a Process
  * Program Counter – points to currently executing statement of the program
  * Input Data – to start the program
  * Registers – to keep track of states
  * Program – for list of commands to execute
  * Output Data
* When switching programs in multiprogramming, we need to keep track of and swap between the program counter and variables for each program
* In uniprogramming, an entire program must be completed before proceeding. There is therefore no need for the concept of processes
* Process Management Issues
  * Lifecycle Management – process creation, state changes, reasons, termination
  * Precedence (flow) management – consider whether process requires something else to run first
* Process creation – system initialization &rarr; execution of process creation system-call &rarr; user request to create a new process (typing command) &rarr; initiation of batch job
* Process Represented using Process Control Block (PCB)
  * Identifier
* State Vector – information necessary to run process
  * Status
  * Creation tree
  * Priority
  * Each process has access to its own memory, and cannot access that of others
* We can create a new process by
  * Building one from scratch (windows approach)
    * Load code & data into memory, create empty heap, initialize PCB, send to process scheduler (dispatcher)
  * Clone an existing one (UNIX approach)
    * Stop current process, save state, copy code, data, heap, PCB, send to dispatcher
* UNIX process creation is done through fork(). Once the child is created, both the child and parent run concurrently, competing for the CPU
  * Note that forking effectively executes twice, one for each process. Allows for an if (fork)) { parent } else { child } pattern
    * Fork returns the pid of the child process to the parent, then 0 to the child process
    * If there is an error, the fork will return -1
* Lifecycle Conditions After Creation
  * No resources to run (eg no processor, memory)
  * Waiting for resource/event
  * Completed task > exit
  * Temporarily suspended waiting for a condition
* Process State Diagram
  * New process is created > ready
  * Ready processes may be dispatched > active
  * Active processes may be externally suspended > ready or exiting
  * Active processes may wait for events/resources > blocked
  * Active processes may timeout > ready
  * Active processes may be killed externally, or exit internally > exiting
* Stopped processes may be externally resumed (> ready) or killed (> exiting)
* Process termination lifecycle
  * In normal completion, process executes system call for termination (exit() in UNIX)
  * May exit by abnormal termination through programming errors (run time, I/O) or through user intervention
* Dispatcher can control the CPU through
  * Sleeping beauty approach – trust process to wake up dispatcher when done
  * Alarm clock approach – provide mechanism to wake up the dispatcher
  * Alarm clock is better as we can't trust the process to relinquish the CPU on its own
  * Alarm event is handled by saving the state of the active process and restoring the state of the interrupt service routine. The CPU switches to supervisory mode, and all other interrupts are disabled.

# Lecture 4 • 2017/09/18
* Simple I/O example – write until num of bytes written = num of bytes read, else throw error
* Process I/O Handles – file descriptors – array structure maintained and held xby kernel for each process
* Address Spaces – instead of sharing memory space, give each process the full address space
  * Linux Memory Split: 1GB Kernel, 3GB User Mode (user programs here)
  * User space may be abstract, whereas kernel space is always physical
  * Address Space switches happen on process switches
  * Layout
    * Stack
    * Dynamic
    * BSS – block started by symbol – space for uninitialized variables
    * data
    * text – read only segment containing program instructions
  * Kernel space is constant & is suitable for sharing info between processes
* Output Redirection
  * Processes typically have stdin, stdout, stderr
  * Redirection involves remapping stdout to the stdin of another process
  * Create pipe (has two ends & unidirectional data flow)
* Concurrency – supports more than one program making processes
* Parallelism – system can perform more than one task simultaneously (subset of concurrency)
* Amdhal's Law – performance improvement is limited by the fraction of time for which it may be implemented
* speedup &le; 1/(S + (1 – S)/N), where S is serial portion, 1 – S is parallel portion, N is # of cores added
* Note that as N &uarr; &rarr; speed &uarr;, S &uarr; &rarr; speed &darr;
* Modern applications are multithreaded to allow decoupled activities to be executed simultaneously
* Why are process creations heavy?
  * Requires new address space & allocated data structures
* Why are threads lightweight?
  * Threads live within processes & share resources with other threads within process (minus stack)
* Threads typically don't compete and have the same goal, whereas processes typically compete for resources
* User Threads
  * Managed by user-level thread library (eg Pthreads, Windows threads, Java threads)
  * Many mapped to single kernel thread
  * One block causes all to block
  * No parallelism; only one may be in kernel at a time
* Kernel Threads
  * Supported by Kernel
  * One to one mapping
  * Number of threads per process restricted due to overhead
* Hybrid Threads
  * Many user level threads mapped to many kernel threads
* Thread Cancellation
  * Target thread = thread to be cancelled
  * Asynchronous – terminate target thread immediately
  * Deferred – default; target thread periodically checks if it should be cancelled

# Lecture 5 • 2017/09/20
* Review from last class
* Dup – duplicates existing file descriptor
  * Descriptor returned is the lowest numbered descriptor currently not in use by process
* Rewiring File Descriptors – Create a pipe &rarr; fork process (cloning the pipe) &rarr; close writing side of pipe &rarr; wire writing side of pipe to new location
* Pthreads
  * User-level or kernel-level
  * POSIX standard API for thread creation & synchronization
  * Specification, not implementation; varies on devices
  * include &lt;pthread.h&gt;
  * Useful methods
    * pthread_create – returns id of new thread
    * pthead_self – returns id of caller
    * pthread_equal – checks if two threads are equal
    * pthread_exit – closes given thread if caller is authorized
    * pthread_join – wait for termination of target thread before completion; returns 0 for success, > 0 otherwise
      * joinable threads must be joined to, otherwise 'zombie' threads will be created
      * threads for which we are interested in their returns are joinable. If we don't care about the thread, we may detach it with `pthread_detach` to inform the system to do the proper garbage collection
    * pthread_mutex_lock/pthread_mutex_unlock – prevent multiple threads from modifying the same variable during concurrent executions
* In concurrent programming, we want to avoid a sequence of interruptible and mutable operations. For instance, i++ involves 3 operations (load, add, save), which may be interrupted from another thread. We may address this by saving i locally first, incrementing the new value, then saving it. That way, other threads that read i in the process will still get the old value. One example of this implementation is Atomic integers

# Lecture 6 • 2017/09/25
* Competing processes
  * Do not affect execution of each other, but compete for devices & resources
  * Deterministic & reproducible – can stop & restart without side effects
* Cooperating processes
  * Aware of each other, and directly (exchange message) or indirectly (share common object) work together
  * Non-deterministic – may be irreproducible
  * Subject to race conditions (eg A = B + 1; B = B * 2)
* Race Conditions
  * When multiple processes are reading/writing from shared data & result depends on who runs when
  * Avoid by prohibiting simultaneous reading to & writing from shared data
  * Mutual exclusion – when one processes is reading/writing shared data, other processes should be prevented from doing the same
* Critical Section
  * Part of program that accesses shared data
  * For multiple programs to cooperate correctly & efficiently
    * No two processes may be simultaneously in their critical sections
    * No assumptions may be made about speeds or number of CPUs
    * No processes outside its critical section may block other processes
    * No process should have to wait forever to enter critical section
  * Solution
    * Disable all interrupts &rarr; not practical as OS operation will be hindered as well
* Strict Alternation
  * Two processes take turns in entering critical section using a global variable swap
* <details>
  <summary>Algorithm</summary>

  ```c
  /*
   * Dekker's Algorithm
   */
  
  int turn;
  /* process 0 */
  ...
  flag[0] = true;
  while (flag[1]) {
     if (turn == 1) {
         flag[0] = false;
         while (turn == 1);
         flag[0] = true;
     }
     /* critical section */
     turn = 1;
     flag[0] = false;
  }
  /* process 1 */
  ...
  flag[1] = true;
  while (flag[0]) {
     if (turn == 0) {
         flag[1] = false;
         while (turn == 0);
         flag[1] = true;
     }
     /* critical section */
     turn = 0;
     flag[1] = false;
  }
  
  /*
   * Peterson's Algorithm
   */
  
  /* process 0 */
  ...
  flag[0] = true;
  turn = 1;
  while (flag[1] && turn == 1);
  /* critical section */
  flag[0] = false;
  /* remainder */
  
  /* process 1 */
  ...
  flag[1] = true;
  turn = 0;
  while (flag[0] && turn == 0);
  /* critical section */
  flag[1] = false;
  /* remainder */  
  ```
  </summary>

# Lecture 7 • 2017/09/27
* Algorithms above are software solutions for alternations
* Microprocesses have hardware instructions supporting mutual exclusion
* Test & Lock – TSL RX, LOCK
  * Read LOCK into RX; store non-zero value at LOCK
  * Operations of reading & writing are indivisible (atomic)
* Advantages
  * Applicable to any # of processes
  * Simple & easy to verify
  * Can support multiple critical sections
* Disadvantages
  * Busy waiting is employed – process waiting to get into critical section consumes CPU time
  * Starvation is possible – selection of entering process is arbitrary when multiple processes wish to enter
* Priority Inversion Problem – high priority process pauses, allowing a low priority process to run. High priority process then resumes and needs a resource taken up by the priority process and wait, effectively treating itself as a lower priority process.
* Semaphores

# Lecture 8 • 2017/10/02
* Deadlock – permanent blocking of set of processes that compete for system resources
* Resource Classification I
  * Reusable – something that can be used by one process at a time without depletion (CPU, memory, files
  * Consumable – can be created then destroyed (eg interrupts, messages, signals)
* Resource Classification II
  * Preemptable – can be taken away from owner without side effects (eg memory, CPU)
  * Non-preemptable – cannot be taken away without computation to fail (eg printer, floppy disk)
* Deadlocks typically occur by using reusable & non-preemptable resources
* Deadlocks satisfy the following conditions
  * Mutual exclusion – cannot share resources
  * Hold & wait – process waits until resource is freed
  * No preemption
  * Circular wait – each process holds resource requested by another
* Resource Allocation Graphs
  * Process &rBarr; resource – (dashed arrow) process waits for resource
  * Process &larr; resource – resource allocated for process
* Deadlock Prevention
  * Designs to exclude possibility of deadlock
  * Very conservative – limits resources & imposes restrictions
  * Eg hold and wait – only run process when all requested processes are free
* Simplest model – require each process to declare maximum number of resources of each type it may need
  * Dynamically examine resource-allocation to ensure that wee can never have circular-wait condition
* Safe State
  * Safe when a process P<sub>i</sub> can be satisfied by the available resources and the resources of the processes before it (< i)
    * P<sub>1</sub> finishes with available resources, P<sub>2</sub> finishes with available resources & resources freed by P<sub>1</sub>, etc
    * If in safe state, guaranteed no deadlock; if not in safe state, possibility of deadlock
    * Avoidance involves ensuring the system never enters unsafe state
* Avoidance Algorithms
  * In between of detection & prevention
  * Single instance of resource type – use resource-allocation graph
    * Requests can only be granted if conversion of dashed line to solid line does not result in a cycle
  * Multiple instances of resource type – use banker's algorithm
    * Processes requesting a resource may have to wait
    * Process granted resources must return them in a finite amount of time
    * Banker's algorithm
      * Given N processes {P<sub>i</sub>} & M resources {R<sub>j</sub>}:
        * Let [Max<sub>ij</sub>] be N x M matrix, with Max<sub>ij</sub> representing max requests of R<sub>j</sub> for process P<sub>i</sub>
        * Let [Hold<sub>ij</sub>] represent units of R<sub>j</sub> currently held by P<sub>i</sub>
        * Let [Need<sub>ij</sub>] represent remaining R<sub>j</sub> needed by P<sub>i</sub>
      * Need<sub>ij</sub> = Max<sub>ij</sub> – Hold<sub>ij</sub> for all i & j

# Lecture 9 • 2017/10/04
* Deadlock Detection
  * Does not prevent deadlocks, but periodically checks for circular waits and resolves them if found
  * Request resources are granted wherever possible
  * Recovery methods
    * Preemption – sometimes possible to reassign resources
    * Rollback – undo transactions to a valid checkpoint
    * Termination – kill process in cycle; irrecoverable losses may occur
* Secondary Storage
  * Non-volatile location for data & programs
  * Managed by file system in OS
  * Requirements – should be persistent, be able to handle large information, be accessible concurrently
  * Storage management – user (what you see) &rarr; file system (data blocks) &rarr; disk system &rarr; bit stream
* Directories
  * Symbol table containing info about files, implemented as a file itself
  * UNIX uses DAG (directed acyclic graphs) structure
* File Operations – create, write, read, delete, reposition r/w pointer (seek), truncate

# Lecture 10 • 2017/10/11
* (Oct 9 was Thanksgiving; no class)
* File Access Methods
  * Sequential – in order (eg magnetic tape)
  * Direct (random) – any order, skipping previous records
  * Indexed – any order, but accessed using particular keys (eg hash tables, dictionary, database access)
* File Allocation Problem
  * Allocating disk space for files
  * Allocation impacts space & time (fragmentation, latency
    * Techniques – contiguous, chained (linked), indexed
    * Bigger block allocations allow for faster speeds as you reduce overhead, but results in more empty space if files are smaller than their allotted blocks
  * Contiguous Allocation
    * Easy access, can access block without following sequential chain (few seeks), simple
    * External fragmentation (eg after deleting some files), may not know file size in advance
  * Chained (linked) allocation
    * No external fragmentation, files can grow easily
    * Lots of seeking, difficult random access
    * Can be enhanced through File Access Tables (FAT) – next address stored in table rather than in block
  * Indexed allocation
    * Allocate array of pointers during file creation which holds indices of disk blocks
    * Small internal fragmentation, easy sequential & random access
    * Lots of seeks if file is big, maximum file size limited by size of block
    * Used in UNIX file system
* Free Space Management
  * Disk space is fixed; need to reuse space freed by deleted files
  * Techniques
    * Bit vectors, linked lists/chains, indexing
    * Bit Vectors – 1 bit per fixed size of free area; 1 indicates free, 0 indicates allocated block
    * Chains – pointers are stored in each disk block, indicating the next free block
      * No longer requires additional map space, but is hard to gauge size of free space
    * Indexed – index pointing to all free blocks
      * Only store indices pointing to beginning of series of free blocks
      * Indices may be stored by free block sizes
* Other System Issues
  * Disk blocking – multiple sectors per block for efficiency (faster data rate, increase addressable space)
  * Disk quotas
  * Reliability – backup/restore (disaster scenarios), file system (consistency) check
  * Performance – block/buffer caches
* Disk Performance – blocks may be read out of order to shorten total time required to read disk
* Disk Scheduling Strategies
  * Random – worst performer, useful as a benchmark
  * First Come First Serve (FCFS, FIFO)
    * Fairest; no starvation; requests are honoured
    * Works well for few processes
    * Approaches random as  of processes competing for given disk increases
  * Priority
    * Based on processes' execution priority
    * Desiged to meet job throughput criteria; not to optimize disk usage
  * Last In First Out (LIFO)
  * Strategies for Disk Performance
    * Shortest Service Time First (SSTF)
      * Select item requiring shortest seek time from given point
      * Random tie breaker used if needed
      * No guarantee for improved seek time, but generally better than FIFO
    * SCAN – back & forth
      * Only moves in one direction until last track is reached before reversing
      * No starvation, but biased against most recently used area on disk

# Lecture 11 • 2017/10/16
* 13 short answers (definitions & problem solving
* 2 long answers (algorithms, pseudocode)
* Know steps to algorithms & be able to modify them
* Banker's algorithm – understand & know major steps
* Sample Midterm
  * Thread vs Process
  * Steps for system call
  * Command piping (goal, problem, idea)
  * Implement piping between two processes
    * Pipe exists in global memory & shared between processes
  * Single & Multithreaded Processes
    * Share code & data; but each thread has its own registers & stack
  * What is a race condition
  * What are conditions of critical section
  * Strict Alternation
  * Starvation, live lock, etc
  * Deadlocks (cycles, knots, Banker's algorithm)

# Lecture 12 • 2017/10/18
* Midterm

# Lecture 14 • 2017/10/25
* Review previous class
* Scheduling Approaches
  * Non-preemptive
    * FCFS (First Come First Serve), SJF (Shortest Job First)
    * Good for background jobs
* FCFS
  * Simplest scheduling policy
  * Performs better for long jobs
  * Importance measure purely by arrival time
* SJF
  * Need to know/estimate processing time of each job
  * Long running jobs may starve if there is a steady supply of short jobs
  * Preemptive SJF is also called SRTF (Shortest remaining time first)
    * When a new job comes in, run the job with the least amount of remaining time (jobs can be swapped
* Estimatinng length of next CPU burst
  * t<sub>n</sub> – actual length of n<sup>th</sup> CPU burst
  * &tau;<sub>n+1</sub> – predicted value for next CPU burst
  * &alpha;, 0 &le; &alpha; &le; 1
  * Define: &tau;<sub>n+1</sub> = &alpha;t<sub>n</sub> + (1 – &alpha;)&tau;<sub>n</sub>
  * &alpha; commonly sets to 1/2
  * More weight is given to new information
* (RR) Round Robin
  * CPU suspends current job when time-slice (quantum) expires
  * Job is rescheduled after all othe ready jobs are executed at least once
  * Small quantums &rarr; a lot of process switches
* Other classification of schedulers
  * Long-term – scheduling done when new process is created. Controls degree of multiprogramming
  * Medium-term – involves suspend/resume processes by swapping them out of or in to memory
  * Short-term – scheduling occurs most frequently & decides which process to execute now
* Multi-level feedback queue scheduler
* Design depends on system used
* <b>TODO</b>
  * How to set priority
    * Depends on system & interactive workstations
    * Interactive jobs tend to be IO bound

# Lecture 15 • 2017/10/30
* Memory Management
* Memory contains both program & data
* Multiprogramming systems can store more than one program + data in memory at same time
* Provides memory sharing & memory protection
* Issues in sharing memory
  * Transparency – processes may co-exist, unaware of each other
  * Safety – processes must not corrupt each other nor the OS
  * Efficiency – CPU utilization must be preserved & memory ust be fairly allocated
  * Relocatino – abaility of program to run different memory locations
* Main memory information classification
  * Program (code) & data (variables, constants)
  * Read-onlly (code, constants) & read-write (variables)
  * Addresses (eg pointers) or data (other variables); binding (memory allocation) can be static or dynamic
  * Managed by compiler, linker, loader, & run-time libraries
* Creating an executable program
  * Compiling (translating) – generates object code
  * Linking – combines object code into single self-sufficient executable code
  * Loading – copies executable code into memory
  * Execution – dynamic memory allocation
* Address binding (relocation)
  * Static – new locations determined before execution
    * Compile time – compiler/assembler translates symbolic address to absolute address
    * Load time – compiler translates symbolic address to relative (relocatable) addresses; loader translates these to absolute addresses
  * Dynamic – new locations determined during execution
* Linker
  * Collects all pieces together to form executable code
  * Issues
    * Relocation – where to put pieces
  * Resolving references – where to find pieces
  * Re-organization – new memory layout
* Loader
  * Places executable code in main memory starting at pre-determined location
  * Absolute loading – always load programs into designated memory location
    * Problematic if two programs have an overlap; fine for uniprogramming
  * Relocatable loading – allows loading programs in different memory locations
  * Dynamic loading – loads functions when first called (if ever)
* Simple management schemes – for contiguous memory allocation
  * Needs to make sure that there is enough space before allocation
  * Direct placement, overlays, partitioning
  * Direct placement
    * No relocation
    * Programs always sequentially loaded into same memory location (absolute loading)
    * Linker produces same loading address for every user program
    * Eg early batch monitors, MS-DOS
  * Overlays
    * Allows for large programs to executes in smaller memory
    * Program organized into tree of objects called overlays
    * Root overlay always laded; subtrees reloaded as needed
  * Partitioning
    * Allows several programs to be in memory at same time
    * Programs are separated into several contiguous blocks
    * Static
      * Memory divided into fixed number of partitions
      * Programs queued to run in smallest available partition
      * Program prepared for one partition may not be able to run in another without being re-linked (absolute loading)
    * Dynamic
      * First fit – allocate first hole that's big enough
        * Shorter elapsed time than BF/WF
        * Better memory utilization than WF
        * Comparable emory utilization to BF
      * Next fit – first fit using circular free list
        * Starts with memory after last one selected
      * Best fit – allocate smallest hole that is big enough
        * shorter elapsed time & better memory utilization than WF
      * Worst fit – allocate to largest hole
* Fragmentation
  * Unused memory that cannot be allocated
  * Internal fragmentation – waste of memory within partition – severe in static partitioning schemes
  * External fragmentation – waste of memroy between partition – caused by scattered noncontiguous free space – present in dynamic partitioning