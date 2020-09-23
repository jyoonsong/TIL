# Ch 1. A Tour of Computer Systems

### 1.1. Information Is Bits + Context

* **source program** (= source file)
  * saved in a text file called `hello.c`
  * a sequence of **bits**, each with a value of 0 or 1, organized in 8-bit chunks called *bytes*.
  * Each **byte** represent some text character in the program
* **ASCII standard**
  * most computer systems represent text characters using the ASCII standard that represents each character with a unique byte-size integer value.
  * ex) fist byte has the integer value 35, which corresponds to the char "#"
  * ex) each text line is terminated by the invisible newline character "\n"
  * **text files** = files that consist exclusively of ASCII characters
    * all information is represented as a bunch of bits
    * distinguished by the context we view them
  * **binary files** = all other files 

> C programming language
>
> - closely tied with the Unix OS
> - small, simple language
> - designed for a practical purpose

### 1.2. Programs are translated by other programs into different forms

translation `gcc -o hello hello.c` = performs four phases

- **source program (text)**
  - `hello.c`
- 1) **Pre-processor (cpp)**
  - modifies the original program according to directives (= #로 시작하는 거)
  - ex) #include <studio.h> = "read the contents of the system header file `stdio.h` and insert it directly into the program text"
- **Modified source program (text)**
  - `hello.i`
- 2) **Compiler (ccl)**
  - translates the text file `hello.i` into the text file `hello.s`
- **Assembly program (text)**
  - `hello.s`
  - contains function `main`
  - instructions in assembly language
  - assembly language provides a common output language for different compilers for different high-level languages
- 3) **Assembler (as)**
  - translates `hello.s` into machine-language instructions, packages them in a form known as a "relocatable object program", and stores the result in the object file `hello.o`
- **Relocatable object programs (binary)**
  - `hello.o`
  - binary file containing 17 bytes to encode the instructions for function `main`
- 4) **Linker (ld)**
  - `printf.o`
  - hello program calls `printf` function, part of the "standard C library" provided by every C compiler.
  - `printf` resides in a separate precompiled object file called `printf.o`, which gets merged with our `hello.o` program by the linker (ld)
- **Executable object program (binary)**
  - `hello`
  - ready to be loaded into memory and executed by the system

### 1.3. It pays to understand how compilation systems work

reasons why programmers need to understand how compilation systems work

- optimizing program performance
- understanding link-time errors
- avoiding security holes
  - buffer overflow vulnerabilities

### 1.4. Processors read and interpret instructions stored in memory

* **shell**
  * a command-line interpreter that prints a prompt, waits for you to type a command line, and performs the command
  * runs the executable file on a Unix system
  * ex) `./hello`

**1.4.1. Hardware Organization of a system**

* **Buses**
  * collection of electrical conduits
  * carry bytes of information back and forth between the components
  * transfer fixed-size chunks of bytes = **words**
    * **word size** = number of bytes in a word
      * fundamental system parameter that varies across systems
      * most machines today have word sizes of either 4 bytes (32 bits) or 8 bytes (64 bits)
* **I/O Devices**
  * the system's connection to the external world
  * ex) keyboard, mouse, display, disk drive
  * controller or adapter: connect each I/O device to the I/O bus = transfer information back and forth between the I/O bus and I/O device
    * **controller**: chip sets in the device itself or on the system's main printed circuit board (motherboard)
    * **adapter**: a card that plugs into a slot on the motherboard
* **Main memory**
  * temporary storage device that holds both a program and the data it manipulates while the processor is executing the program
  * physically: consists of a collection of **dynamic random access memory (DRAM)** chips
  * logically: organized as a linear array of bytes, each with its own unique address (array index) starting at zero.
* **Processor = central processing unit (CPU)**
  * engine that interprets (or executes) instructions stored in main memory
  * **program counter (PC)**
    * core of CPU
    * word-size storage device
    * at any point in time, PC points at (contains the address of) some machine-language instruction in main memory
  * a processor *appears* to operate according to a very simple instruction execution model, defined by its *instruction set architecture*
    * In this model, instructions execute in strict sequence
      * each instruction involves
        * read the instruction from memory pointed at by the PC
        * interprets the bits in the instruction
        * performs some simple operation dictated by the instruction
        * updates the PC to point to the next instruction (may or may not be contiguous)
  * there are only a few of these simple operations that revolve around main memory, register file, and the arithmetic/logic unit (ALU)
    * **register file**: small storage device that consists of word-size registers, each with its own unique name
    * **ALU**: computes new data and address values
    * example of simple operations
      * load
      * store
      * operate
      * jump
  * we can distinguish the processors' instruction set architecture from microarchitecture
    * **instruction set architecture**: describe the effect of each machine-code instruction
    * **microarchitecture**: describe how the processor is actually implemented

**1.4.2. Running the hello program**

* as we type the characters `./hello`
  * shell reads each one into a register
  * stores it in memory
* hit `enter` key
  * shell loads the executable `hello` file by executing a sequence of instructions that copies the code and data in the `hello` object file from disk to main memory
    * **direct memory access (DMA)**: data travel directly from disk to main memory without passing through the processor

### 1.5. Caches matter

- system spends a lot of time moving info from one place to another

  - machine instructions in `hello` program

    : disk => main memory => processor

  - the data string `hello, world\n`

    : disk => main memory => display device

  => much of this copying is overhead that slows down the program

  => major goal for system designers: make these copy operations run as fast as possible

- 