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

