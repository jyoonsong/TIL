# Virtual Memory

- processes share CPU & main memory

  - challenges
    - if too many processes need too much memory => not able to run
    - memory is vulnerable to corruption
      - If some process inadvertently writes to the memory used by another process, that process might fail in some bewildering fashion totally unrelated to the program logic

  => how to manage memory more efficiently and with fewer errors?

- **virtual memory (VM)**

  - an abstraction of main memory provided by modern systems
  - an elegant interaction of hardware exceptions, hardware address translation, main memory, disk files, and kernel software that provides each process with a large, uniform, and private address space. 
  - With one clean mechanism, virtual memory provides three important capabilities: 
    - (1) It uses main memory efficiently by treating it as a **cache for an address space stored on disk**, keeping only the active areas in main memory and transferring data back and forth between disk and memory as needed. 
    - (2) It simplifies **memory management** by providing each process with a **uniform address space**. 
    - (3) It **protects** the address space of each process from **corruption** by other processes.
  - it works silently and automatically, without any intervention from the application programmer. Then why would a programmer need to understand it?
    - Virtual memory is central.
    - Virtual memory is powerful. 
    - Virtual memory is dangerous.
  - VM from two angles
    - first half: how VM works
    - second half: how VM is used and managed by applications (programs)
      - ex) `malloc`



### 9.1. Physical and Virtual Addressing

How can a CPU access memory?

1. **Physical addressing**

   - use **physical addresses** (PA).
     - main memory = an array of M contiguous byte-size cells. 
     - each byte has a unique physical address
   - ex) a load instruction that reads the 4-byte word starting at physical address 4
     - When the CPU executes the load instruction, it generates an effective physical address
     - passes it to main memory over the memory bus
     - main memory fetches the 4-byte word starting at physical address 4 and returns it to the CPU
     - CPU stores the word in a register
   - Early PCs and systems such as digital signal processors, embedded microcontrollers, and Cray supercomputers. 

2. **Virtual addressing**

   - use **virtual address** (VA)

   - process

     1. generate a virtual address

     2. **address translation**
        - convert a VA to the appropriate physical address before being sent to main memory
        - Like exception handling, address translation requires close cooperation between the CPU hardware and the operating system. 
          - Dedicated hardware on the CPU chip called the **memory management unit (MMU)** translates virtual addresses on the fly, using a lookup table stored in main memory whose contents are managed by the operating system.

   - modern processors



### 9.2. Address Spaces

* **address space** 

  an ordered set of nonnegative integer addresses

  ex) `{0, 1, 2, ...}`

  - **linear address space**

     If the integers in the address space are consecutive (we will always assume linear address spaces)

     1. **virtual address space**

       = an address space of N = 2^n addresses 

       - In a system with virtual memory, the CPU generates virtual addresses from virtual address space

         `{0, 1, 2, ..., N - 1}`

       - The **size** of an address space is characterized by the number of bits that are needed to represent the largest address

         ex) For example, a virtual address space with N = 2^n addresses is called an **n-bit address space**.

         => modern systems typically support 32-bit or 64-bit virtual address spaces

     2. **physical address space**

       = the M bytes of physical memory in the system

       - `{0, 1, 2, ..., M - 1}`

  => The concept of an address space is important because it makes a clean distinction between data objects (bytes) and their attributes (addresses). 
  
  - Once we recognize this distinction, then we can generalize and allow each data object to have multiple independent addresses, each chosen from a different address space. 
  
  - This is the basic idea of virtual memory. 
  
    **Each byte of main memory has a virtual address chosen from the virtual address space, and a physical address chosen from the physical address space.**

>  Practice Problem 9.1
>
> | \# of virtual address bits (n) | \# of virtual addresses | largest possible virtual address |
> | ------------------------------ | ----------------------- | -------------------------------- |
> | 4                              | 2^4 = 16                | 2^4 - 1 = 15                     |
> | 14                             | 2^14 = 16K              | 2^14 - 1 = 16K - 1               |
> | 24                             | 2^24 = 16M              | 2^24 - 1 =  16M - 1              |
> | 46                             | 2^46 = 64T              | 2^46 - 1 = 64T - 1               |
> | 54                             | 2^54 = 16P              | 2^54 - 1 = 16P - 1               |



### 9.3. VM as a Tool for Caching

how VM provides a mechanism for using the DRAM to cache pages from a typically larger virtual address space. 

* a virtual memory
  * conceptually is organized as an array of N contiguous byte-size cells stored on disk. 
  * Each byte has a unique virtual address that serves as an index into the array. 
  * The contents of the array on disk are cached in main memory. 
    * the data on disk (the lower level) is partitioned into blocks that serve as the transfer units between the disk and the main memory (the upper level). 
    * VM systems handle this by partitioning the virtual memory into fixed-size blocks called **virtual pages (VPs)**.
      * Each virtual page is P = 2^p bytes in size. 
    * Similarly, physical memory is partitioned into **physical pages (PPs = page frames)**
      * also P bytes in size.
* At any point in time, the set of **virtual pages** is partitioned into three disjoint subsets:
  1. **Unallocated**. 
     - Pages that have not yet been allocated (or created) by the VM system. Unallocated blocks do not have any data associated with them, and thus do not occupy any space on disk.
  2. **Cached**.
     - Allocated pages that are currently cached in physical memory. 
  3. **Uncached**.
     - Allocated pages that are not cached in physical memory.



#### 9.3.1. DRAM Cache Organization

different caches in the memory hierarchy

1. **SRAM cache**

   denote the L1, L2, and L3 cache memories between the CPU and main memory

2. **DRAM cache**

   denote the VM system’s cache that caches virtual pages in main memory.

   - The **position** of the DRAM cache in the memory hierarchy has a big impact on the way that it is organized. 

     - Recall that a DRAM is at least 10 times slower than an SRAM and that disk is about 100,000 times slower than a DRAM. 
       * Thus, misses in DRAM caches are very expensive compared to misses in SRAM caches because DRAM cache misses are served from disk, while SRAM cache misses are usually served from DRAM-based main memory. 
     - Further, the cost of reading the first byte from a disk sector is about 100,000 times slower than reading successive bytes in the sector. 

     => the organization of the DRAM cache is driven entirely by the **enormous cost of misses**.

     - virtual pages tend to be **large**—typically 4 KB to 2 MB.
       - Because of the large miss penalty and the expense of accessing the first byte
     - DRAM caches are **fully associative**; that is, **any virtual page can be placed in any physical page**. 
       - Due to the large miss penalty, 
     - operating systems use much more **sophisticated replacement algorithms** for DRAM caches than the hardware does for SRAM caches. 
       - because the replacement policy on misses also assumes greater importance, because the penalty associated with replacing the wrong virtual page is so high. 
     - Finally, DRAM caches always use **write-back** instead of write-through
       - because of the large access time of disk

#### 9.3.2. Page Tables

- **How the VM system determine if a virtual page is cached somewhere in DRAM? If so, which physical page is it cached in?**

  - Why?

    ex) If there is a miss, the system must determine where the virtual page is stored on disk, select a victim page in physical memory, and copy the virtual page from disk to DRAM, replacing the victim page.

  - provided by

    - a combination of **operating system** SW,

      - responsible for maintaining the contents of the page table and transferring pages back and forth between disk and DRAM.

    - **address translation** HW in the MMU (memory management unit), 

      - reads the page table each time it converts a virtual address to a physical address. 

    - and a data structure stored in physical memory known as a **page table** that maps virtual pages to physical pages. 

      - an array of **page table entries (PTEs)**.

      - Each page in the virtual address space has a PTE at a fixed offset in the page table

        - a **valid bit**

          indicates whether the virtual page is currently cached in DRAM

        - an n-bit address field.

          1. If the valid bit is set, the address field indicates the **start of the corresponding physical page** in DRAM where the virtual page is cached.

          2. If the valid bit is not set, then a **null address** indicates that the virtual page has not yet been allocated. Otherwise, the address points to the **start of the virtual page** on disk.

> Practice Problem 9.2.
>
> 2^n / 2^p = 2^(n-p) possible pages in the system => each needs a PTE
>
> | n (virtual address size) | P = 2^p (page size)                     | Number of PTEs |
> | ------------------------ | --------------------------------------- | -------------- |
> | 12                       | 1K (2^10)                               | 4              |
> | 16                       | 16K (2^14)                              | 4              |
> | 24                       | 2M (2^21)                               | 8              |
> | 36                       | 1G (2^30)<br />1,000,000,000 = 2^(10*3) | 64             |



#### 9.3.3. Page Hits

**VM page hit** = the reference to a word in VP2 is a **hit**

ex) when the CPU reads a word of virtual memory contained in VP 2, which is cached in DRAM 

- the address translation hardware 
  - uses the virtual address as an index 
    - to locate PTE 2 and read it from memory. 
  - Since the valid bit is set, 
    - the address translation hardware knows that VP 2 is cached in memory. 
  - So it uses the physical memory address in the PTE (which points to the start of the cached page in PP 1) to construct the physical address of the word.



#### 9.3.4. Page Faults

* **Page fault**
  * a DRAM cache miss, in a virtual memory parlance
  * ex) Figure 9.6 : page table before the fault. 
    * The CPU has referenced a word in VP 3, which is not cached in DRAM. 
    * The address translation hardware reads PTE 3 from memory, 
      * infers from the valid bit that VP 3 is not cached, and 
      * triggers a page fault exception. 
    * The page fault exception invokes 
      * a page fault exception handler in the kernel, which selects a **victim page**—in this case, VP 4 stored in PP 3. 
        * If VP 4 has been modified, then the kernel copies it back to disk. 
        * In either case, the kernel modifies the page table entry for VP 4 to reflect the fact that VP 4 is no longer cached in main memory.
    * Next, the kernel copies VP 3 from disk to PP 3 in memory, updates PTE 3, and then returns. 
  * ex) Figure 9.7: page table after the page fault.
    * When the handler returns, it restarts the faulting instruction, which resends the faulting virtual address to the address translation hardware. 
      * But now, VP 3 is cached in main memory, and the page hit is handled normally by the address translation hardware. 
* Virtual memory was invented in the early 1960s, long before the widening CPU-memory gap spawned SRAM caches.
  *  As a result, virtual memory systems use a different terminology from SRAM caches, even though many of the ideas are similar. 
  * In virtual memory parlance, **blocks** are known as **pages**. 
  * The activity of transferring a page between disk and memory is known as **swapping** or **paging**. 
    * Pages are swapped in (paged in) from disk to DRAM, and swapped out (paged out) from DRAM to disk. 
  * The strategy of waiting until the last moment to swap in a page, when a miss occurs, is known as **demand paging**. 
    * Other approaches, such as trying to predict misses and swap pages in before they are actually referenced, are possible. However, all modern systems use demand paging.



#### 9.3.5. Allocating Pages

* when the operating system allocates a new page of virtual memory (e.g., calling malloc)
  * Fig 9.8: VP 5 is allocated by creating room on disk and updating PTE 5 to point to the newly created page on disk.



#### 9.3.6. Locality to the Rescue Again

* VM works well because of **locality**.
  * Although the total number of distinct pages that programs reference during an entire run might exceed the total size of physical memory, 
  * the principle of locality promises that at any point in time they will tend to work on a smaller set of active pages known as the **working set** or **resident set**. 
  * After an initial overhead where the working set is paged into memory, subsequent references to the working set result in hits, with no additional disk traffic.

* Problem: not all programs exhibit good temporal locality. 
  * ex) working set size > the size of physical memory
    * unfortunate situation known as **thrashing**, where pages are swapped in and out continuously.



### 9.4. VM as a Tool for Memory Management

* Thus far, we have assumed a single page table that maps a single virtual address space to the physical address space. 

* In fact, operating systems provide **a separate page table, and thus a separate virtual address space, for each process**. 

  * Figure 9.9 

    * the page table for process i maps VP 1 to PP 2 and VP 2 to PP 7. 

    * the page table for process j maps VP 1 to PP 7 and VP 2 to PP 10. 

      => **multiple virtual pages can be mapped to the same shared physical page**.

* The combination of demand paging and separate virtual address spaces can:

  1. **simplify linking**

     - A separate address space => each process to use the same basic format for its memory image, regardless of where the code and data actually reside in physical memory. 

       - ex) every process on a given Linux system has a similar memory format. For 64-bit address spaces, the code segment *always* starts at virtual address 0x400000. The data segment follows the code segment after a suitable alignment gap. The stack occupies the highest portion of the user process address space and grows downward. 

       => Such uniformity greatly simplifies the design and implemen- tation of linkers, allowing them to produce fully linked executables that are independent of the ultimate location of the code and data in physical memory.

  2. **simplify loading**

     - easy to load executable and shared object files into memory. 

     - To load the .text and .data sections of an object file into a newly created process, the Linux loader 

       - allocates virtual pages for the code and data segments, 
       - marks them as invalid (i.e., not cached), and 
       - points their page table entries to the appropriate locations in the object file. 

       => The interesting point is that the loader never actually copies any data from disk into memory. The data are paged in automatically and on demand by the virtual memory system the first time each page is referenced, either by the CPU when it fetches an instruction or by an executing instruction when it references a memory location.

     - **memory mapping**. 

       - mapping a set of contiguous virtual pages to an arbitrary location in an arbitrary file
       - Linux system call called `mmap` allows application programs to do their own memory mapping.

  3. **simplify sharing**

     Separate address spaces => provide the operating system with a consistent mechanism for managing sharing between user processes and the operating system itself. 

     - In general, each process has its own private code, data, heap, and stack areas that are not shared with any other process. 
       - In this case, the operating system creates page tables that map the corresponding virtual pages to disjoint physical pages.
     - However, in some instances it is desirable for processes to share code and data. 
       - ex) every process must call the same operating system kernel code, and every C program makes calls to routines in the **standard C library** such as `printf`. 
       - Rather than including separate copies of the kernel and standard C library in each process, the operating system can arrange for multiple processes to share a single copy of this code by mapping the appropriate virtual pages in different processes to the same physical pages, as we saw in Figure 9.9.

  4. **simplify memory allocation**

     - When a program running in a user process requests additional heap space (e.g., as a result of calling malloc), the operating system 

       - allocates an appropriate number, say, k, of contiguous virtual memory pages, and 
       - maps them to k arbitrary physical pages located anywhere in physical memory. 

       => there is no need for the operating system to locate k contiguous pages of physical memory. The pages can be scattered randomly in physical memory.

### 9.5. VM as a Tool for Memory Protection

As we have seen, providing separate virtual address spaces makes it easy to isolate the private memories of different processes. But the address translation mechanism can be extended in a natural way to provide even finer **access control**. 

- Since the address translation hardware reads a PTE each time the CPU generates an address, it is straightforward to control access to the contents of a virtual page by adding 3 **additional permission bits to the PTE**. 
  1. **The SUP bit** 
     - indicates whether processes must be running in kernel (supervisor) mode to access the page. 
     - Processes running in kernel mode can access any page, but processes running in user mode are only allowed to access pages for which SUP is 0. 
  2. **The READ and WRITE bits** control read and write access to the page. For 
     - example, if process i is running in user mode, then it has permission to read VP 0 and to read or write VP 1. However, it is not allowed to access VP 2.
- If an instruction violates these permissions, then the CPU triggers a general protection fault 
  - that transfers control to an exception handler in the kernel, 
    - which sends a SIGSEGV signal to the offending process. 
      - Linux shells typically report this exception as a **segmentation fault**

### 9.6. Address Translation

- **address translation**

  - a mapping between the elements of an N- element virtual address space (VAS) and an M-element physical address space (PAS)

  - Figure 9.12: how the MMU uses the page table to perform this mapping

    - **the page table base register (PTBR)**

      - A control register in the CPU, 
      - points to the current page table. 

    - The n-bit virtual address has two components: 

      - **a p-bit virtual page offset (VPO)**

      - **an (n − p)-bit virtual page number (VPN)**.

        - The MMU uses the VPN to select the appropriate PTE. 

          ex) VPN 0 selects PTE 0, VPN 1 selects PTE 1, and so on. 

    - The corresponding physical address is the concatenation of 

      - the (m-p)-bit **physical page number (PPN)** from the page table entry and

      - the p-bit **VPO** from the virtual address. 

        => since the physical and virtual pages are both P bytes, the physical page offset (PPO) is identical to the VPO.

  - Figure 9.13a: steps that the CPU HW performs when there is a **page hit**

    => handled **entirely by HW**

    1. processor generates a virtual address and sends it to the MMU
    2. MMU generates PTE address and requests it from the cache/main memory
    3. The cache/main memory returns the PTE to the MMU
    4. The MMU constructs the physical address and sends it to the cache/main memory
    5. The cache/main memory returns the requested data word to the processor

  - Figure 9.13b: handling a page fault

    => requires cooperation btw **HW and OS kernel**

    1. processor generates a virtual address and sends it to the MMU
    2. MMU generates PTE address and requests it from the cache/main memory
    3. The cache/main memory returns the PTE to the MMU
    4. The valid bit in the PTE is zero, so the MMU triggers an exception => transfers control in the CPU to a page fault exception handler in the OS kernel
    5. The fault handler identifies a victim page in physical memory (if that page has been modified, pages it out to disk)
    6. The fault handler pages in the new page and updates the PTE in memory
    7. The fault handler returns to the original process, causing the faulting instruction to be restarted
       - CPU resends the offending virtual address to the MMU
       - because the virtual page is now cached in physical memory, there is a hit, and 
       - after the MMU performs the steps in 9.13a, the memory returns the requested word to the processor

> practice problem 9.3.
>
> We are given n = 64 virtual address bits and m = 32 physical address bits.
>
> | page size<br />P (2^p) | VPN (n-p)  | VPO (p) | PPN (m-p)  | PPO (p) |
> | ---------------------- | ---------- | ------- | ---------- | ------- |
> | 1KB                    | 54 (64-10) | 10      | 22 (32-10) | 10      |
> | 2KB                    | 53         | 11      | 21         | 11      |
> | 4KB                    | 52         | 12      | 20         | 12      |
> | 16KB                   | 50         | 14      | 18         | 14      |



#### 9.6.1. Integrating Caches and VM

* In any system that uses both virtual memory and SRAM caches, there is the issue of whether to use virtual or physical addresses to access the SRAM cache. 
  * most systems opt for physical addressing. 
    * With physical addressing, it is straightforward for multiple processes to have blocks in the cache at the same time and to share blocks from the same virtual pages. 
    * Further, the cache does not have to deal with protection issues, because access rights are checked as part of the address translation process.
* Figure 9.14 : how a physically addressed cache might be integrated with virtual memory. 
  * address translation occurs before the cache lookup.
  * page table entries can be cached, just like any other data words.

#### 9.6.2. Speeding up address translation with a TLB

* Problem
  * every time the CPU generates a virtual address, the MMU must refer to a PTE in order to translate the virtual address into a physical address. 
  * In the worst case, this requires an additional fetch from memory, at a cost of tens to hundreds of cycles. 

* However, many systems try to eliminate even this cost by including a small cache of PTEs in the MMU called a **translation lookaside buffer (TLB)**

  * a small, virtually addressed cache where each line holds a block consisting of a single page table entry (PTE). 

  * A TLB usually has a high degree of associativity. 

  * As shown in Figure 9.15 : the index and tag fields that are used for set selection and line matching are extracted from the virtual page number in the virtual address.

    If the TLB has T = 2t sets, then 

    * the **TLB index (TLBI)** consists of the t least significant bits of the VPN, 
    * the **TLB tag (TLBT)** consists of the remaining bits in the VPN.

* Figure 9.16a : steps involved when there is a TLB hit

  => all of the address translation steps are performed inside the on-chip MMU and thus are fast

  1. CPU generates a virtual address

#### 9.6.3. Multi-level page tables

#### 9.6.4. Putting it together: End-to-end address translation





### 9.7. Case Study: The Intel Core i7/Linux Memory System