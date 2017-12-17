# Comp 310 Final Notes

> Some key concepts and bullet points

| Acronyms | |
| --- | --- |
DAG     | directed acyclic graph
FAT     | file allocation table
FCFS    | first come first serve (also FIFO)
FIFO    | first in first out (also FCFS)
LIFO    | last in first out
LRU     | least recently used
MBR     | master boot record
MMU     | memory management unit
OPT     | optimal
OS      | operating systemt
PCB     | process control block
SSTF    | shortest service time first
TCB     | trusted computing base
VM      | virtual maching
VMM     | virtual machine monitor

## OS

* Major OS Functions
    * Control access and provide interfaces
    * Manage resources
    * Provide abstractions
* Traps - allows switch from user mode to system mode
* System Call Process
    * System call
    * Switch mode; verify arguments & service
    * Branch to service function via system call table
    * Return from service function; switch mode
    * Return from system call
* Process Scheduling Objectives - fairness, differential responsiveness, efficienty
* Memory Management - provides protection & relocation
* Processes
    * Cannot access memory not allocated to oit
    * Can request more memory from OS
    * Can release already held memory to OS
    * May use small portion of allocated memory
* Inter-process Communication - done through shared memory or message passing
* Layered Kernel - more in kernel mode, programs have a greater chance of affecting other data and crashing the system
* Microkernel - greater user mode - programs have independent data spaces, and likely won't affect other programs/crash the system if they fail

## Processes & Threads

* Process Creation
    * System initization
    * Execution of process creation system call
    * User requests to create new process
    * Initiation of batch job
* Process Representation
    * Info: state & control
    * Process Control Block (PCB)
        * Identifier
        * State vector
        * Status
        * Creation tree
        * Priority
        * Other info
* Lifecycle Creation
    * Build from scratch (windows)
    * Clone existing (UNIX)
        ```c
        if (fork()) {
            // parent execution; returned pid != 0
        } else {
            // child execution; returned 0
        }
        ```
* Process State Diagram
    * States - new, ready, stopped, blocked, active, exiting
    * Internal transitions - create, events (x2), time-out, dispatch, exit, error
    * External transitions - resume, suspend, kill (x2)
* Tiny Shell
    ```c
    while (1) {
        printf("Shell > ");
        getline(line);
        if (strlen(line) > 1) {
            if (fork() == 0) {
                exec(line);
            }
            wait(child);
        }
    }
    ```
* File Descriptors - 0 stdin, 1 stdout, 2 stderr
* Remapping can be done with `dup2(fd, 1)`, which will make stdout go to `fd`
* Parellelism - performing multiple tasks simultaneously
* Concurrency - making progress in multiple tasks
* Amdahl's Law - speedup <= 1 / (S + (1 - S)/N)
    * N - # of cores
    * S - serial portion
    * (1 - S) - parallel portion
* Threads (compared to processes):
    * Are lighter
    * Share memory, but have their own registers and stack
    * Are less fault tolerant
    * Can introduce many synchronization issues
    * Live within processes
* Thread Levels
    * User - many user to one kernel
        * One block blocks all
    * Kernel - one to one
        * More concurrency, greater overhead
    * Hybrid - many to many
        * Allows enough kernel threads to be created
* Pthreads are specifications, not implementations
    * `pthread_create`, `pthread_exit`, `pthread_self`, `pthread_equal`, `pthread_join`, `pthread_detach`


## Deadlocks

*  Deadlock Conditions
    *  Mutual exclusion - requires exclusive control of resources (without sharing)
    *  Hold & wait - process may wait for resource while holding others 
    *  No preemption - process will not give up resource until it is finished with it
    *  Circular wait - each process in chain holds a resource requested by another
*  Deadlock Occurrence
    *  Cycle is necessary, but not sufficient (only indicated unsafe state)
    *  For single resources, a knot is required (in resource allocation graph)
    *  For multiple resource instances, use Banker's Algorithm
        *  Max matrix, hold matrix, available vector
        *  Need = max - hold
        *  For each process, check if need <= available
            *  If yes, add hold to available and mark process as complete
            *  Continue until no further needs can be met, or if all processes are complete
        *  Order of completion marks safe order for process
*  Deadlock Strategies
    *  Ignorance
    *  Prevention - ensure deadlocks can never happen; contains a lot of process limitations
        *  Eg request all resources at once, preemption, resource ordering
    *  Avoidance - dynamically avoid potential deadlocks - requires knowledge of future requests
        *  Eg find safe path
    *  Detection - allow deadlock to occur, detect occurrence, and recover accordingly
        *  Eg periodic checks
*  Deadlock Recovery
    *  Preemption - take resource away
    *  Rollback - revert to a time without deadlock
    *  Termination - kill process

## Synchronization

* Processes Can
    * Compete - deterministic without shared memory; can stop & restart without side effects
    * Cooperate - have shared data; nondeterministic; subject to race conditions
* Race Condition Avoidance
    * Mutual exclusion - prohibit multiple processes from reading/writing shared data at same time
* Critical Section
    * No two processes may simultaneously enter their critical sections
    * No assumptions can be made about speeds or # of CPUs
    * No process running outside critical section may block other processes
    * No process should have to wait forever
    * Should be atomic
    * Should not be interrupted in the middle
    * Should be short
* Deadlock - when processes are blocked by eachother in a way where no process can continue
* Livelock - when processes allot some time for other processes to run (before checking if they can run themselves), and repeatedly wait for each other
* Dekker's Algorithm
    ```c
    /* Process 0 */
    ...
    flag[0] = true;
    while (flag[1]) {
        if (turn == 1) {
            flag[0] = false;
            while (turn == 1);
            flag[0] = true;
        }
    }
    /* critical section */
    turn = 1;
    flag[0] = false;
    ...
    /* For process 1, switch 0s and 1s */
    ```
* Peterson's Algorithm
    ```c
    /* Process 0 */
    ...
    flag[0] = true;
    turn = 1;
    while (flag[1] && turn == 1);
    /* critical section */
    flag[0] = false;
    ...
    /* For process 1, switch 0s and 1s */
    ```
* Mutex - locking mechanism - can enforce synchronous access to a given resource
* Semaphore - signaling mechanism - allows transmission of simple messages for signalling, sleeping, waking, etc
    * Can be used to represent a mutex (1 being an object in use, 0 being free)
    ```c
    sem_wait(&mutex);
    // act on data
    sem_post(&mutex);
    ```

## Secondary Storage

> Non-volatile repository for data & programs, managed by the file system (part of OS)

* User > File System > Disk System
* Directory
    * Single-level - world accessible
    * Two-level - level per user; should have login
    * Tree - subtree per user; login required
* File System Layout
    * Disk
        * Partition Table
            * MBR (master boot record)
        * Disk Partitions
            * Boot Block - code to boot system
            * Super Block - critical info on layout
            * I-nodes - file attributes, except name; first block points to root
            * Files & Directories
* File Operations - create, write, read, delete, seek, truncate (rare)
* File Access Methods - sequential (ordered), direct (random), indexed (by key)
* File allocation 
    * Contiguous <br> (+) simple, few seeks <br> (-) external fragmentations, don't know size
    * Chained <br> (+) no external fragmentation, easy growth <br> (-) lots of seeking, random access difficult <br> Can be enhanced with FAT (file allocation table)
    * Index <br> (+) small internal fragmentation, easy sequential & random access <br> (-) lots of seeks for big files
* Free Space Management
    * Bit vector - one bit per block, 1 = free, 0 = used
    * Chains - pointer within block to next free space, starting at block 0
    * Indexed - index of free regions (sorted by size) stored in block 0
* UNIX File Access Through
    * File descriptor table - one per process; keeps track of open files
    * Open file system - one per system, keeps track of all open files
    * I-node table - one per system, tracks all files

## Disks

* Components
    * Spindle
    * Platter - holds data
        * Tracks - to read from
        * Recording area - radial line
        * Sector - sectino of platter
    * Arm - has r/w head
    * Actuator - holds arms
* Access Time 
    * Seek - 0-10ms - moves head to right track
    * Rotation - 0-10ms - moves right sector to head
    * Data transfer - <1ms - rotation until sector passes head
* Disk Scheduling Strategies
    * Random
    * FIFO - no starvation, approaches random as competing process count increases
    * Priority - optimizes throughput, not disk usage
    * LIFO - useful for sequential files, danger of starvation <br><br>
    * SSTF - better time seeker than FIFO, random tie breaker if needed
    * SCAN - move in one direction until last track is reached, then reverse
    * C-SCAN - one way SCAN and fast return
    * LOOK - move in one direction until no more requests in that direction, then reverse
    * C-LOOK - one way LOOK and fast return

## Memory Management

* Issues with Sharing Memory - transparency, safety, efficiency, relocation
* Storage Allocation Classification
    * Program (code) & data (varaibles, constants)
    * Read-only (code, constants) & read-write (variables)
    * Address (pointers) or data (other), with static/dynamic binding
* Creating Executable
    * Compiling - generate object code
    * Linking - combine to single executable
    * Loading - from disk + relocation
    * Executing - dynamic memory allocation
* Address Binding
    * Static - locations determined before execution
        * Compile time - symbolic to absolute address by compiler/assembler
        * Load time - symbolic to relative address by compiler; relative to absolute address by loader
    * Dynamic - locations determined during execution
        * Run time - program retains relative addresses; absolute generated by hardware
* Linker Deals With
    * Relocation - where to put pieces
    * Resolution - where to find pieces
    * Re-organization - how to arrange new memory layout
* Dynamic Linking
    * Allows load/unload at runtime
    * Useful when handling lots of code that is infrequently used
* Loader Deals With
    * Absolute loading - placing code into designated memory location
    * Relocatable loading - loading to different memory location
    * Dynamic loading - loading when first called, if ever
* Simple Management Schemes
    * Direct placement - no relocation
    * Overlays - root always loaded; remaining loaded as needed
    * Partitioning - allows several programs at once
        * Static - memory divided into fixed sizes, with queues to run in partitions
        * Dynamic - programs loaded as long as their is room; given exactly what it needs
            * First Fit, Next Fit, Best Fit, Worst Fit
* Fragmentation - unused memory that cannot be allocated to
    * Internal
        * Within partition
        * Difference between partition size & process size
        * Severe in static partitioning
    * Eexternal 
        * Between partitions
        * Scattered noncontiguous free space
        * Severe in dynamic partitioning
* Memory Protection
    * Hardware - address translation
    * Software - strong typing, fault isolation
* Paging
    * Frames - blocks of physical memory
    * Pages - blocks of logical memory
    * Page table - map of page base addresses for each frame
    * Hardware support - dedicated registers, memory page table, PTBR (page table base register)
    * Inverted page table - mapping of frame to page; smaller size, but slower
* TLB - translation look-aside buffer
    * Directly maps page number to frame number
    * Few exist to help speed up retrieval
* Memory Organization
    * Stack - free reverse from allocation; predictable
    * Heap - random; 0.5N blocks lost per N allocated due to fragmentations (fifty percent rule)
* Free Memory Management
    * Bit maps - bit per block
    * Linked lists - free list for unused memory
    * Buddy system - divide by half for best fit, merge doubles to restore
* Reclaiming Memory
    * Reference counts - tricky for circular structures
    * Garbage collection - often expensive
* Principle of Locality
    * Locality of reference - processes favour subsets of address space during execution
    * Locality - cluster of pages which most memory references are made during brief time period
    * Sptial locality - loading part of array is correlated with the rest of the array being used
        * Pre fetch data
    * Temporal locality - tendency to reference memory locations that have been used before (eg loops)
        * Have sufficient room in cache to hold relevant memory locations

## Virtual Memory

> Virtual memory allows us to make use of signicantly more space by storing and retrieving to the disk, on the basis that we tend to use only small portions of a program at a given time (principle of locality)

* Page table entry - caching disabled, reference, modified, protection, present/absent, page frame number
* Address Lookup
    * Look in TLB
    * If not found, look in memory, and add to TLB
    * If not found, do a page table walk
    * If truly invalid, seg fault
* Allocation Policy
    * Fewer frames per program - higher page fault rate, but more programs in memory (less swapping)
    * After a certain size, more frames will only marginally improve performance
* Resident Set Size - # of allocated pages
* Fetch Policy
    * Demand paging - load when necessary (lots of faults in beginning)
    * Request paging - let user identy which pages are needed (faulty)
    * Pre-paging - start with few pages pre-loaded, then load when needed
* Replacement Policy
    * FIFO - first in first out
    * LRU - least recently used
    * OPT - optimal
    * Random
* Clock/2<sup>nd</sup> Chance Algorithm
    * Have `last` pointer to last change frame
    * When new frame is needed, iterate from `last` to the first frame with a zero used bit using `next` pointer
        * As `next` pointer passes frame, clear used bits
        * Once victim is found, replace frame and mark as used
    * Hardware sets used bit each time address in page is referenced
* Thrashing - high page fault frequency to the point where it is hardly doing anything useful
* Denning's Working Set Principle
    * Program should run iff working set is in memory
    * Page may not be victimized if it is a member of the current working set of any runnable (not blocked) program
* Page Fault Frequency = # of faults / specified time

## Virtual Machines

* Components
    * Host - underlying hardware
    * VMM - create interface identical to host
    * Guest - process provided with virtual copy of host (usually an OS)
* Benefits
    * Protection - less likely for virus to spread
    * Freeze, suspend VMs
    * Clone, snapshot VMs
    * Run multiple VMs simultaneously
    * Live migration
    * Cloud computing
* Hypervisor Types
    * Type 0 - hardware-based solution
    * Type 1 - OS like software
    * Type 2 - run on OS but provide VMM features to guest operating systems
    * Paravirtualization, programming-environment virtualization, emulators, application containment, etc
* Not safe for guest to run in kernel mode, so there will be a user & privileged mode, both running in the actual user mode

## Protection

* Protection Domain
    * Specifies resources that can be accessed
    * Defines set of `<object-name, rights-set>`
* Sandboxing - restricting access to limited resources
* Access Matrix - specifies operations D<sub>i</sub> is allowed for each object F<sub>j</sub>
    * Can be implemented by column (access control list) or by row (capability lists for domains )
* Trusted System
    * Needs to be simple, easily understood, and verifiable
    * Contains minimal TCB, hardware & software to enforce rules
* TCB - trusted computing base
    * Should be separate from OS
    * Contains reference monitor, through which all processes go through