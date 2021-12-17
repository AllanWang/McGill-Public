# Comp 273

> [cs.mcgill.ca/~jvybihal/](http://cs.mcgill.ca/~jvybihal/) &bull; [TA Information](https://docs.google.com/spreadsheets/d/1mKpXd_7QHxUuO6tqi3UbeZmuEPN3Lk-W68MPcIN-gkQ/edit?usp=sharing) &bull; [Textbook (4<sup>th</sup> ed, Right click to save)](http://nsec.sjtu.edu.cn/data/MK.Computer.Organization.and.Design.4th.Edition.Oct.2011.pdf)

[Terms & Concept Cards Here](https://www.allanwang.ca/notes/mcgill/comp273/practice/) <!-- TODO update>

# Circuits

The following diagrams were drawn with [Digital](https://github.com/hneemann/Digital). Feel free to download it to test the [circuits](circuits) directly.

---

Gates

| | NOT | AND | OR | XOR | NAND | NOR |
---|---|---|---|---|---|---
A | B | ![invert](circuits/gates/invert.svg) | ![and](circuits/gates/and.svg) | ![or](circuits/gates/or.svg) | ![xor](circuits/gates/xor.svg) | ![nand](circuits/gates/nand.svg) | ![nor](circuits/gates/nor.svg)
0 | 0 | 1 | 0 | 0 | 0 | 1 | 1
0 | 1 | X | 0 | 1 | 1 | 1 | 0
1 | 0 | 0 | 0 | 1 | 1 | 1 | 0
1 | 1 | X | 1 | 1 | 0 | 0 | 0

---

RS Flip FLops

![rs flip flops](circuits/sr-flipflop.svg)

Basic reset set flip flop to save bit data; a clock can be connected to the inputs of both nor gates for synchronization

R | S | Q | Q' | Result
---|---|---|---|---
0 | 0 | Q | Q' | No change
0 | 1 | 1 | 0 | Set
1 | 0 | 0 | 1 | Rest
1 | 1 | 1 | 1 | Avoid

---

D latch

![d latch](circuits/d-latch.svg)

An addition to the RS flip flop to accept a single input. Together with the clock (E), the input (D) directly changes the output of the latch. This also eliminates the Reset = 1 & Set = 1 issue.

E | D | Q | Q' | Result
---|---|---|---|---
0 | 0 | Q | Q' | Latch
0 | 1 | Q | Q' | Latch
1 | 0 | 0 | 1 | Reset
1 | 1 | 1 | 1 | Set

---

JK Flip Flop

![jk flip flop](circuits/jk-flipflop.svg)

JK flip flops cycle at half the speed of its input, as only one SR flip flop is enabled at a time and it takes two clicks to pass data to the output.

J | K | Q | Q' | Reseult
---|---|---|---|---
0 | 0 | Q | Q' | Unchanged
0 | 1 | 0 | 1 | Reset
1 | 0 | 1 | 0 | Set
1 | 1 | Q' | Q | Toggle

---

Multiplexer

![multiplexer](circuits/multiplexer.svg)

Takes many input signals and a selector address with its own signals. Selector address chooses which of the input signals to output (by index).

A | B | Y
---|---|---
0 | 0 | D0
0 | 1 | D1
1 | 0 | D2
1 | 1 | D3

---

Half Adder

![half adder](circuits/halfadder.svg)

Adds two bits and returns the sum and carry; used for the least significant digit of numerical additions

---

Full Adder

![full adder](circuits/fulladder.svg)

Adds three bits (includes carry) together and produces a sum and carry; can be strung together to add numbers with many digits.

# Lecture 0 • 2017/01/06
* System board parts
  * Power Supply – Converts AC/DC from home into steady current needed in PC
  * CPU – Central Processing Unit – Math, logic, data, movement, loops
  * CMOS – complementary metal-oxide semiconductor – stores BIOS (basic input/output system) settings of computer
  * ROM – Read Only Memory – Stores built-in instructions (eg CMOS) & additional instructionss for CPU
  * Battery – Helps keep CMOS parameters, including time
  * RAM – Random Access Memory – Volatile main memory bank, large & slow
  * Cache – fast memory (pipeline) connected to RAM
  * Bus – Common road for data that interconnects all devices on motherboard
  * CLK – Clock – Beats the processing cycle (2 of them)
  * Slot – Connects devices external to motherboard through cards
  * ISA – Instruction Set Architecture – provides commands to processor to tell it what it needs to do (eg ADD, COMPARE, LOAD, OUT)

# Lecture 1 • 2017/01/09
* Traditional system board schematic has one bus connecting cache, CLK, CPU, ROM to RAM
* Having more buses allows for multithreading
* Slots allow connections to external devices
  * PCI (peripheral component interconnect), ISA (instruction set architecture)
* CLK – clock – one controls bus, one controls CPU (min 2 CLKs per device)
  * CLK for bus is one or two orders of magnitude slower than CPU CLK
* PCI can run at higher clock speeds
* Data bus – connects CPU to Cache
* Addressing – every component on system board has a unique integer number that identifies it
  * Eg opening & closing of gates towards various components that control data passage.
* Communication Pathways
  * Composed of multiple wires, each wire for 1 bit
  * In parallel, independent execution
  * One byte per bus per tick
* Bus
  * 8 wires
  * Grounded on both sides
* How would a 10 byte string travel from RAM to a slot, assuming traditional system board
  * Assume CPU is not present
  * Supervisor opens gates 0 & 1 and closes all other gates
  * Wait for tick
  * One char pass
  * Go back to step 2
  * Supervisor closes all gates
* If single byte in RAM & single CPU instruction in RAM both need to exit RAM at same time (one to CPU, other to slot), what do we do? Assume traditional system board
  * Not possible; one bus can only carry one process at a time
* In traditional system board, what would happen if the CPU & slot need to save a single byte into RAM at the same time?
  * Like before, we only have one bus. We’ll either lose data or one of the processes has to wait
* CPU
  * ALU – Arithmetic logic unit: + – > < == etc
    * L, R, A-out & status are specific purpose registers
      * L & R – inputs to ALU
      * A-out – result of operation
      * Status – input & output flag bits
        * input to tell what operation to perform
        * output to report errors (eg overflow, divide by zero)
  * Registers – Fast live memory locations
    * N general purpose registers 8, 64, or 128 bits long
    * Temp variables for CPU
  * IP – Instruction pointer, aka IC (Instruction counter) – points to next instruction
  * IR – Instruction register – stores current instruction
* Cannot distinguish variables, addresses, operations
  * Instructions usually have different OP-codes depending on data types
* CPU loop
  * Get instruction: IR &larr; RAM (slow bus, no cache)
  * Sequencer &larr; IR[OP-CODE]
  * Selected gates open
  * Clock ticks
  * All gates close
  * Increment to next instruction

# Lecture 2 • 2017/01/11
* Bit – machine 5V ≡ 1, 2V ≡ 0, 0V ≡ OFF
* Pathway – voltages can be passed through wire; whole wire becomes given voltage
* Bus ≡ n-wires ≡ one “unit” of Data
  * Also a pathway (of n going in the same direction)
* Gate
  * Has in and out direction
  * Freezes if other direction used
  * Computer freezes because of infinite loops or electricity going the opposite direction
* CPU
  * Fast bus, fast clock
  * IP – instruction pointer – keeps track of where we are in a program
    * Loaded into/used with address register
  * IR – instruction register – sends instruction to sequencer
    * Received from data register
    * Eg application opened &rarr; instructions sent to RAM &rarr; instructions sent one at a time to CPU
  * Seq – sequencer – opens all gates
  * CPU Clock
    * Beats to move data across CPU bus or move code from IP to sequencer
  * Sequencer
    * Table of codes with circuits
    * Each circuit is system of gated triggers
    * Triggers permit data to flow in predetermined order
* CPU Loop
  * IR &harr; RAM[IP]
  * IR &rarr; Seq, IP+
* Data – information
  * Eg characters, symbols, numbers
* Real data translated to code using properties of medium
  * Which medium should we pick?
bulletTablePair("Real Data &rarr; Numbers", "Encoded Data &rarr; everything else", 20),
  * INT ≡ Binary
* ISO IEEE
* RAM access register system
  * Allows communication between CPU & RAM
  * Address register – where to get/put data
  * Data register – where to put the data, or the data to put elsewhere
  * Mode register – flag for get or put
  * Zero page – like a sourcebook table; data should not overwrite things here
    * Bigger zero page &rarr; more stuff pluggable into machine
* CPU Boundary Register – keeps track of addresses used; addresses requested must never be greater than boundary address

# Lecture 3 • 2017/01/16
* Claude E. Shannon
  * Entropy – how much work does it take to communicate one letter to someone?
  * Medium – how can we transmit that single letter?
  * Realization – the medium is the message
  * In computers
    * Entropy – how many bits do we need to represent a single character?
    * Medium – Light (optics), sound (WiFi), signals(wire)
    * Realization – message is characterized by medium
* RAM
  * Usually, register size = address size
* Two types of basic information
  * Table encode – address/variable name on one side, data on the other (in bytes)
  * Natural binary number
  * Addressing schematic
    * Address column (32 bits) with cell addresses
    * Data column (8 bits) with OS, video buffer, program space, zero page
* ROM – read only memory – often sits between RAM and another part of the machine
* C – char a = ‘b’		compiler → w/ ASCII table → to byte
* Binary – size – register, RAM
  * Register – left most significant, right least significant
* Data = choice = cost
  * Having the leftmost bit hold the sign reduces the space for the actual numbers by two
  * A way to “double” the max integer would be to keep it unsigned

# Lecture 4 • 2017/01/18
* ASCII/UNICODE – unsigned bit (no sign bit), 8-bits long
* Char x = ‘A’	00100001
* Strings – contiguous sequence of characters terminated by NULL or contiguous sequence of chars proceeded (example had count in the front?) by a byte count
  * Composed of char
  * Char is built in property of CPU, not strings
  * Strings supported through software

* Integer
  * Number is represented in raw signed binary or 2’s complement for the bit size
    * 5: signed 00000101	2’s comp 00000101
    * 5: signed 10000101	2’s comp 10 – 5 ≡ 10 + (-5)
  * Start: 00000101
  * Flip: 11111010
  * Add 1: 11111011 &larr; -5
* Fixed Point – sign | exponent | mantissa (not two’s complement)
  * Bias is the 0, offsets up for positive, down for negative
  * ∵ all fixed point numbers are written as 1.xxx, \"1.\" May be deleted &rarr; extra bit &rarr; double the range
  * IEEE format

    Precision | Sign | Exponent | Fractional Mantissa | Total | Bias
    ---|---|---|---|---|---
    Single | 1 | 8 | 23 | 32 | 127
    Double | 1 | 11 | 52 | 64 | 1023
    Quad | 1 | 15 | 111 | 128 | 16383

# Lecture 5 • 2017/01/23
* Logic circuits
  * Circle &rarr; not
  * Extra line &rarr; exclusive
* nand &rarr; not and, nor &rarr; not or, xor &rarr; exlusive or
* For two overlapping but disconnected wires, draw a small bump at the intersection
* And gate is like a door with a lock – putting 0 on one end will stop the other end from passing through
* Or gates can pass data as soon as one side has 1
* Bit set reset, 1 &rarr; set &rarr; write 1, 0 &rarr; reset &rarr; write 0
* RS Flip-Flop
  * R &rarr; reset, S &rarr; set
  * Constructed by feeding outputs of two NOR gates back to each other's input
* D Latch
  * D &rarr; data
* RS Flip-flop with preceeding and gates and one inverter
  * Requires only one data input
  * Input from D results in that value as output for Q
  * Also includes clock input C
    * When C is 0, and gates used to pass inputs are 0, so no change occurs and Q holds its values
    * When C is 1, D value is passed through and set

# Lecture 6 • 2017/01/25
* End goal is addres &harr; read/write &harr; sync
  * Solution is gate/lock, eg and gates around SR flip flop
* To retrieve/send to correct address, use and gates with negations to check for matches.
* JK flip flop – two RS flip flops w/ clock and other gates
  * Adds a delay to output (first flip flop changes when clock is 1, other one outputs when clock is 0 &rarr; half the outputs as input)
* Half adder only contains A and B inputs
  * When doing addition, only least significant digit is half adder, others are full adders as there are carries
* Full adder = two half adders glued with or gates
* Status register has a few bits for unusual situations &rarr; overflow, dividing by 0, sign change
* To build an ALU, we need to know size of inputs and outputs, format, etc
* How would ALU design change when upgrading?
  *  4 &rarr; 8, adding 4 more full adders
* Subtraction – need to decide how we are doing the operation
  *  5 – 3, 5 + (-3), 5 + (3 * -1)
* ALU has its V like shape because there are 2’s complement holders for L & R followed by operation section
* Reminder: 2’s complement – invert all bits and add 1

# Lecture 7 • 2017/01/30
* Making a calculator: get method to check which digit you need, then turn on appropriate sections accordingly.
* Multiplexers 2<sup>a</sup>-to-1 mux has 2<sup>a</sup> inputs x<sub>0</sub>, … x<sub>n-1</sub> & single output z. 
  * Selector address ‘a’ composed of input signals y<sub>0</sub>, …, y<sub>a-1</sub> selects which x<sub>i</sub> signal passes through z
  * Like a router &rarr; multiple data, has to take turns
* Decoder – a-to-2<sup>a</sup> decoder asserts one and only one of its 2<sup>a</sup> output lines
  * CPU sequencer is decoder
  * Input is an index; outputs signal on wire of that index
* Encoder – outputs an a-bit binary number equal to index of single 1 signal among 2<sup>a</sup> inputs
  * Input from one of the wires; outputs index of that wire
  * Active output used to tell if x<sub>0</sub> is ON as compared to an encoder that is off (otherwise both would be 0000)
* Programmable Combinatorial Parts
  * Type 1 – VIA fuses can be “blown” given sufficient current
  * Type 2 – VIA anti-fuse “sets” given sufficient current (chemical)
  * Drawn as a square, becomes circle 
* Blown fuses connects the wires?
  * Fuses represented by square
* !!!ROM & PROM shorthand
* PROM – programmable read only memory
* PAL – programmable array logic
  * Pairs that go down
* PLA – programmable logic array
  * Individual lines and or gates forming a hash
  * Both arrays programmable

# Lecture 8 • 2017/02/01
* Encoder/Decoder (see previous lecture)
* Von Neumann Machine – traditional computer model based on Turing’s theoretical ideas
  * Model: RAM (input) &rarr; Processor (Get instruction) &rarr; Execution with control unit &rarr; RAM (output)
* Index: MAR – memory address register, MBR – memory buffer register, D0-7 Registers, ALU – arithmetic logic unit, INC – incrementer, PC – program counter, IR – instruction register, CU – control unit, in ram {Mode, AR – address register, DR – data register}
  * Start with IP/PC (same thing)
  * Address in PC sent to address register (MAR &rarr; AR)
  * Sends to DR then to buffer (D0 to D7) – buffer may can contain data or instructions
    * Depends on MBR
* Every instruction in binary has two parts; OP code and address (or something else)
  * Only OP code goes down to control unit
* IR is basically a “dead end”	address will move onto PC, which will increment itself then write into MAR &rarr; DR &rarr; MBR (overwrites previous content) &rarr; next set of instructions
* CPU loop
  * AR &larr; PC
  * PC &larr; PC + 1
  * DR &larr; RAM[AR]
  * IR &larr; DR
  * Each line involves one tick (some improvements, like incrementation on same tick)
* Micro Instruction – way to express CPU operation step by step
* [ ] for index like arrays, ( ) for arguments
  * IR(OP, params)
  * &larr; indicates move
* BUS – Address, R/W, Data
  * 1 bit/wire, bottle neck, duality of operation (modes)

# Lecture 9 • 2017/02/06
* An instruction can be any size (ie 8, 16, 32 bits) depending on the CPU
* Bite – flip flop
* Byte – 8 flip flops – standard size for RAM
* Word – standard size for CPU
* Address – standard size for bus
* Registers – either Byte, Word, or specialty sizes
* Ports, slots, other important registers – Often \"accessible\" but not \"addressable\"
* At least now, sizes should agree with each other
* BUS – conduit for bytes to travel from one location to another (pathway)
  * In buses, address and R/W signals are only 1 way; data however is 2 ways, and is sometimes designed as 2 buses
  *  1 bit per wire
  * Bottle neck; 1 byte of data per movement
  * Duality of operation: byte & word modes
* Program (assume 8 bit instruction set)
  * | | |
    ---|---
    MOV D0, D1 | D0 &larr; D1
    Add D1, D0, 5 | D1 = D0 + 5
    MOV D0, X | D0 gets x from RAM
* Run Program
  * OS – double click, load to RAM at free space, PC &larr; 50
* Program Runs (OS is sleeping; number on top right denotes address)
  * MAR<sup>50</sup> &larr; PC<sup>50</sup> <br> PC<sup>51</sup> &larr; PC + 1<sup>51</sup>
  * AR<sup>50</sup> &larr; MAR<sup>56</sup> <br> DR &larr; RAM[AR]
  * MBR &larr; DR <br> IR &larr; MBR <br> CU &larr; IR (op code)
* OP code &rArr; code # represents instruction
* Bottom left wires go down to CU
* Args is complicated; sometimes have one, two, three, etc
  * For our example, there are always 3 arguments
* Comment: no real difference b/t integers and addresses; just how we use it
* Need code for all instructions?
* Each instruction from set is mode of micro-instructions
  * ADD, D1, D0, 5 &rArr; D1 = D0 + 5
  * Micro
    * L &larr; D0
    * R &larr; 5
    * A &larr; ALU(L,R)
    * D1 &larr; A

# Lecture 10 • 2017/02/08
* Midterm – definitions, circuit drawing/interpreting, data conversions & representation, RAM, adder, addressing, bus, IR, IP, classical & pipeline CPU, off the shelf circuits, mathematical problems as seen in assignment
* Pipeline as optimized architecture – clock tick sharing
  * CU needs to make sure it goes through all the right loops
* In pipeline, cache<sub>input</sub> &rarr; … &rarr; cache<sub>data</sub> at 2GHz. It is connected to RAM via a slow bus, but to make use of the speed, there are private fast buses going from the RAM to the cache input and data. They operate at 2Ghz + dump, meaning they collect data and send a bunch at once.
  * Code/load prediction – dumb vs smart (looking one instruction ahead to see when to dump)
* Fetch portion of CPU
  * PC goes to read address &rarr; instruction comes out
  * Instruction R-format
    * OP – op-code (two; one for each CU)
    * RS – register source
    * RT – second register source (optional)
    * RD – register destination
    * SHAMT – shift amount (jump)
    * FUNCT – function-code (ie sub-op-code)
  * Add portion is always connected to 4, as instruction is 32-bit
* Load portion of CPU
  * OP code goes to CU, other parts of instruction go to registers, some portions skip register altogether
  * Multiple address registers exist so you can fetch and load from multiple addresses at the same time (unlike in RAM where it’s synchronous)