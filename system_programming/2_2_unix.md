# Unix

### Intro

* Definition
  * a family of **multitasking, multiuser** computer operating systems 
  * that derive from the original AT&T Unix, development starting in the 1970s at the Bell Labs research center by Ken Thompson, Dennis Ritchie, and others
* written in C and assembly language
  * distinguishes itself from its predecessors as the **first portable** operating system: 
  * almost the entire operating system is written in the **C programming language**, which allows Unix to operate on numerous platforms.
* Source model
  * historically closed-source
  * some Unix projects are open-source
* Default user interface
  * command-line interface
  * graphical interface (macOS Quartz etc)

### Overview

* Change

  * originally meant to be a convenient platform for **programmers** developing software to be run on it and on other systems, rather than for non-programmers.
    * not designed to be portable or for multi-tasking
  * The system grew larger 
    * as the operating system started spreading in academic circles, 
    * and as users added their own tools to the system and shared them with colleagues
    * Both Unix and the C programming language were developed by AT&T and distributed to government and academic institutions, which led to both being ported to a wider variety of machine families than any other operating system.
    * Unix gradually gained **portability, multi-tasking and multi-user capabilities in a time-sharing configuration**.
  * By the early 1980s, users began seeing Unix as a potential universal operating system, suitable for computers of all sizes. 
    * The Unix environment and the **client–server program model** were essential elements in 
      * the development of the Internet and 
      * the reshaping of computing as centered in networks rather than in individual computers.

* **Unix philosophy**

  : "the idea that the power of a system comes more from the relationships among programs than from the programs themselves"

  * characteristics
    * the use of **plain text** for storing data; 
    * A unified filesystem (the Unix filesystem) = a **hierarchical file system**
    * treating devices and certain types of inter-process communication (IPC) as **files**; 
    * a modular design: the operating system should provide a set of simple tools, each of which performs a limited, well-defined function.
      * the use of a large number of **software tools**, small programs that can be strung together through a command-line interpreter using **pipes**
        * an inter-process communication mechanism known as "**pipes**"
      * as opposed to using a single monolithic program that includes all of the same functionality
  * * and a **shell** scripting and command language (the Unix shell) is used to combine the tools to perform complex workflows.

* **Kernel**

  * The Unix operating system consists of many libraries and utilities along with the master control program, the **kernel**. 
    * provides services to start and stop programs, 
    * handles the file system and other common "low-level" tasks that most programs share, 
    * schedules access to avoid conflicts when programs try to access the same resource or device simultaneously. 
      * To mediate such access, the kernel has special rights, reflected in the distinction of **kernel space** from **user space**, the latter being a priority realm where most application programs operate.

### History

* 1969 dev start: initially intended for use inside the Bell System. 
  * 1971: First manual published internally
  * 1973: Announced outside Bell Labs
* late 1970s: AT&T licensed Unix to outside parties, leading to a variety of both academic and commercial Unix variants from vendors including University of California, Berkeley (BSD), Microsoft (Xenix), Sun Microsystems (SunOS/Solaris), HP/HPE (HP-UX), and IBM (AIX)
* In the early 1990s: AT&T sold its rights in Unix to Novell, 
* 1995: Novell then sold its Unix business to the Santa Cruz Operation (SCO)
* The UNIX trademark passed to The Open Group, a neutral industry consortium founded in 1996, which allows the use of the mark for certified operating systems that comply with the Single UNIX Specification (SUS). 
* However, Novell continues to own the Unix copyrights, which the SCO Group, Inc. v. Novell, Inc. court case (2010) confirmed.

### Standards

* **POSIX (IEEE)**
  * In the late 1980s, an open operating system standardization effort now known as POSIX provided a common baseline for all operating systems; IEEE based POSIX around the common structure of the major competing variants of the Unix system, publishing the first POSIX standard in 1988. 
* **COSE => Single UNIX Specification (The Open Group)**
  * In the early 1990s, a separate but very similar effort was started by an industry consortium, the **Common Open Software Environment (COSE)** initiative, 
  * which eventually became the **Single UNIX Specification (SUS)** administered by The Open Group. 
* **Open Group Base Specification (Austin Group)**
  * Starting in 1998, the Open Group and IEEE started the **Austin Group**, to provide a common definition of POSIX and the Single UNIX Specification, which, by 2008, had become the Open Group Base Specification.
* **Executable and Linkable Format (SVR4)**
  * In 1999, in an effort towards compatibility, several Unix system vendors agreed on SVR4's Executable and Linkable Format (ELF) as the standard for binary and object code files. 
  * The common format allows **substantial binary compatibility** among different Unix systems operating on the same CPU architecture.
* **The Filesystem Hierarchy Standard** 
  * was created to provide a **reference directory layout** for Unix-like operating systems; it has mainly been used in **Linux.**

### Components

* a self-contained software system composed of several components that were originally packaged together. 
  * By including the development environment, libraries, documents and the portable, modifiable source code for all of these components, 
  * in addition to the kernel of an operating system, 
  * This was one of the key reasons it emerged as an important teaching and learning tool and has had such a broad influence.
  * The inclusion of these components did **not** make the system large
    * the original V7 UNIX distribution, consisting of copies of all of the compiled binaries plus all of the source code and documentation occupied less than 10 MB and arrived on a single nine-track magnetic tape. 
    * The printed documentation, typeset from the online sources, was contained in two volumes.
* The names and filesystem locations of the Unix components have changed substantially across the history of the system. Nonetheless, the V7 implementation is considered by many to have the **canonical early structure**:
  * **Kernel** – source code in /usr/sys, composed of several sub-components:
    - *conf* – configuration and machine-dependent parts, including boot code
    - *dev* – device drivers for control of hardware (and some pseudo-hardware)
    - *sys* – operating system "kernel", handling memory management, process scheduling, system calls, etc.
    - *h* – header files, defining key structures within the system and important system-specific invariables
  * **Development environment** – early versions of Unix contained a development environment sufficient to recreate the entire system from source code:
    - *cc* – [C language](https://en.wikipedia.org/wiki/C_(programming_language)) compiler (first appeared in V3 Unix)
    - *as* – machine-language assembler for the machine
    - *ld* – linker, for combining object files
    - *lib* – object-code libraries (installed in /lib or /usr/lib). *[libc](https://en.wikipedia.org/wiki/Libc)*, the system library with C run-time support, was the primary library, but there have always been additional libraries for things such as mathematical functions (*[libm](https://en.wikipedia.org/wiki/Libm)*) or database access. V7 Unix introduced the first version of the modern "Standard I/O" library *stdio* as part of the system library. Later implementations increased the number of libraries significantly.
    - *[make](https://en.wikipedia.org/wiki/Make_(software))* – build manager (introduced in [PWB/UNIX](https://en.wikipedia.org/wiki/PWB/UNIX)), for effectively automating the build process
    - *include* – header files for software development, defining standard interfaces and system invariants
    - *Other languages* – V7 Unix contained a Fortran-77 compiler, a programmable arbitrary-precision calculator (*bc*, *dc*), and the [awk](https://en.wikipedia.org/wiki/Awk) scripting language; later versions and implementations contain many other language compilers and toolsets. Early BSD releases included [Pascal](https://en.wikipedia.org/wiki/Pascal_(programming_language)) tools, and many modern Unix systems also include the [GNU Compiler Collection](https://en.wikipedia.org/wiki/GNU_Compiler_Collection) as well as or instead of a proprietary compiler system.
    - *Other tools* – including an object-code archive manager (*[ar](https://en.wikipedia.org/wiki/Ar_(Unix))*), symbol-table lister (*nm*), compiler-development tools (e.g. *[lex](https://en.wikipedia.org/wiki/Lex_(software))* & *[yacc](https://en.wikipedia.org/wiki/Yacc)*), and debugging tools.
  * **Commands**  – Unix makes little distinction between commands (user-level programs) for system operation and maintenance, commands of general utility, and more general-purpose applications such as the text formatting and typesetting package. Nonetheless, some major categories are:
    - *[sh](https://en.wikipedia.org/wiki/Bourne_shell)* – the "shell" programmable [command-line interpreter](https://en.wikipedia.org/wiki/Command-line_interpreter), the primary user interface on Unix before window systems appeared, and even afterward (within a "command window").
    - Utilities – the core toolkit of the Unix command set, including cp, ls, grep, find and many others. Subcategories include:
      - *System utilities* – administrative tools such as *[mkfs](https://en.wikipedia.org/wiki/Mkfs)*, *[fsck](https://en.wikipedia.org/wiki/Fsck)*, and many others.
      - *User utilities* – environment management tools such as *passwd*, *kill*, and others.
    - *Document formatting* – Unix systems were used from the outset for document preparation and typesetting systems, and included many related programs such as *[nroff](https://en.wikipedia.org/wiki/Nroff)*, *[troff](https://en.wikipedia.org/wiki/Troff)*, *[tbl](https://en.wikipedia.org/wiki/Tbl)*, *[eqn](https://en.wikipedia.org/wiki/Eqn_(software))*, *[refer](https://en.wikipedia.org/wiki/Refer_(software))*, and *[pic](https://en.wikipedia.org/wiki/Pic_language)*. Some modern Unix systems also include packages such as [TeX](https://en.wikipedia.org/wiki/TeX) and [Ghostscript](https://en.wikipedia.org/wiki/Ghostscript).
    - *Graphics* – the *plot* subsystem provided facilities for producing simple vector plots in a device-independent format, with device-specific interpreters to display such files. Modern Unix systems also generally include [X11](https://en.wikipedia.org/wiki/X11) as a standard windowing system and [GUI](https://en.wikipedia.org/wiki/GUI), and many support [OpenGL](https://en.wikipedia.org/wiki/OpenGL).
    - *Communications* – early Unix systems contained no inter-system communication, but did include the inter-user communication programs *mail* and *write*. V7 introduced the early inter-system communication system [UUCP](https://en.wikipedia.org/wiki/UUCP), and systems beginning with BSD release 4.1c included [TCP/IP](https://en.wikipedia.org/wiki/TCP/IP) utilities.
  * **Documentation** – Unix was the first operating system to include all of its documentation online in machine-readable form. The documentation included:
    - *[man](https://en.wikipedia.org/wiki/Man_page)* – manual pages for each command, library component, [system call](https://en.wikipedia.org/wiki/System_call), header file, etc.
    - *doc* – longer documents detailing major subsystems, such as the C language and troff

### Impact

* It achieved its reputation 
  * by its interactivity, 
  * by providing the software at a nominal fee for educational use, 
  * by running on inexpensive hardware, and 
  * by being easy to adapt and move to different machines
    * rewritten in C
* Unix had a **drastically simplified file model** compared to many contemporary operating systems: treating all kinds of files as simple byte arrays. 
  * (+) The file system hierarchy contained machine services and devices (such as printers, terminals, or disk drives), providing a uniform interface,
  * (-) but at the expense of occasionally requiring **additional mechanisms** such as ioctl and mode flags to access features of the hardware that did not fit the simple "stream of bytes" model. 
    * **The Plan 9 operating system** pushed this model even further and eliminated the need for additional mechanisms.
* Unix also popularized the **hierarchical file system** with arbitrarily nested subdirectories, originally introduced by Multics. 
  * Other common operating systems of the era had ways to divide a storage device into multiple directories or sections, but they had a fixed number of levels, often only one level. 
  * Several major proprietary operating systems eventually added recursive subdirectory capabilities also patterned after Multics. 
    * DEC's RSX-11M's "group, user" hierarchy evolved into VMS directories, 
    * CP/M's volumes evolved into MS-DOS 2.0+ subdirectories, and 
    * HP's MPE group.account hierarchy and IBM's SSP and OS/400 library systems were folded into broader POSIX file systems.
* Making the **command interpreter** an ordinary user-level program, with additional commands provided as separate programs, was another Multics innovation popularized by Unix. 
  * The Unix shell used the same language for interactive commands as for scripting (shell scripts – there was no separate job control language like IBM's JCL). 
  * Since the shell and OS commands were "just another program", the user could choose (or even write) their own shell. 
  * New commands could be added without changing the shell itself. U
  * nix's innovative command-line syntax for creating modular chains of producer-consumer processes (pipelines) made a powerful programming paradigm (coroutines) widely available. 
  * Many later command-line interpreters have been inspired by the Unix shell.
* A fundamental simplifying assumption of Unix was its focus on **newline-delimited text** for nearly all file formats. 
  * There were no "binary" editors in the original version of Unix – the entire system was configured using textual shell command scripts.
  * The common denominator in the I/O system was the byte – unlike "record-based" file systems. 
  * The focus on text for representing nearly everything made Unix pipes especially useful and encouraged the development of simple, general tools that could be easily combined to perform more complicated ad hoc tasks. 
  * The focus on text and bytes made the system far more scalable and portable than other systems. 
  * Over time, text-based applications have also proven popular in application areas, such as printing languages (PostScript, ODF), and at the application layer of the Internet protocols, e.g., FTP, SMTP, HTTP, SOAP, and SIP.
* Unix popularized a syntax for **regular expressions** that found widespread use. 
  * The Unix programming interface became the basis for a widely implemented operating system interface standard (POSIX, see above). 
  * The C programming language soon spread beyond Unix, and is now ubiquitous in systems and applications programming.
* Early Unix developers were important in bringing the concepts of **modularity and reusability** into software engineering practice, spawning a "software tools" movement. 
  * Over time, the leading developers of Unix (and programs that ran on it) established a set of cultural norms for developing software, norms which became as important and influential as the technology of Unix itself; this has been termed the Unix philosophy.
* The **TCP/IP networking protocols** were quickly implemented on the Unix versions widely used on relatively inexpensive computers, 
  * which contributed to the Internet explosion of worldwide real-time connectivity, and 
  * which formed the basis for implementations on many other platforms.
* The Unix policy of **extensive on-line documentation** and (for many years) **ready access** to all system source code 
  * raised programmer expectations, and contributed to the launch of the free software movement in 1983.

### Impact: Free Unix and Unix-like variants

* In 1983, Richard Stallman announced the **GNU (short for "GNU's Not Unix")** project, 
  * an ambitious effort to create a free software Unix-like system; 
    * "free" in the sense that everyone who received a copy would be free to use, study, modify, and redistribute it. 
  * The GNU project's own kernel development project, **GNU Hurd**, 
    * had not yet produced a working kernel, 
    * but in 1991 Linus Torvalds released the **kernel Linux** as free software under the GNU General Public License. 
  * In addition to their use in the GNU operating system, many **GNU packages**
    * such as the GNU Compiler Collection (and the rest of the GNU toolchain), the GNU C library and the GNU core utilities – have gone on to play central roles in other free Unix systems as well.
* **Linux distributions**, consisting of the Linux kernel and large collections of compatible software have become popular both with individual users and in business. 
  * Popular distributions include Red Hat Enterprise Linux, Fedora, SUSE Linux Enterprise, openSUSE, Debian GNU/Linux, Ubuntu, Linux Mint, Mandriva Linux, Slackware Linux, Arch Linux and Gentoo.
* A free derivative of **BSD Unix, 386BSD**, was released in 1992 and led to the NetBSD and FreeBSD projects. 
  * With the 1994 settlement of a lawsuit brought against the University of California and Berkeley Software Design Inc. (USL v. BSDi) by Unix System Laboratories, it was clarified that Berkeley had the right to distribute BSD Unix for free if it so desired. 
  * Since then, BSD Unix has been developed in several different product branches, including OpenBSD and DragonFly BSD
* most or all Unix and Unix-like systems include at least some **BSD code**, and some systems also include **GNU utilities** in their distributions.
  * Linux and BSD are increasingly filling the market needs traditionally served by proprietary Unix operating systems, as well as expanding into new markets such as the consumer desktop and mobile and embedded devices. Because of the modular design of the Unix model, sharing components is relatively common; consequently, most or all Unix and Unix-like systems include at least some BSD code, and some systems also include GNU utilities in their distributions.
  * In a 1999 interview, Dennis Ritchie voiced his opinion that Linux and BSD operating systems are a continuation of the basis of the Unix design, and are derivatives of Unix:
* **OpenSolaris** was the open-source counterpart to Solaris developed by Sun Microsystems, which included a CDDL-licensed kernel and a primarily GNU userland. 
  * However, Oracle discontinued the project upon their acquisition of Sun, which prompted a group of former Sun employees and members of the OpenSolaris community to fork OpenSolaris into the **illumos kernel**. 
  * As of 2014, illumos remains the only active open-source System V derivative.

### Impact: ARPANET

* In May 1975, RFC 681 described the development of **Network Unix** by the Center for Advanced Computation at the University of Illinois at Urbana–Champaign. 
  * The system was said to "present several interesting capabilities as an ARPANET mini-host". 
  * At the time Unix required a license from Bell Laboratories that at 20,000(USD) was very expensive for non-university users, while an educational license cost just ​150(USD). 
  * It was noted that Bell was "open to suggestions" for an ARPANET-wide license.
* Specific features found beneficial were 
  * the local processing facilities, compilers, editors, a document preparation system, efficient file system and access control, mountable and unmountable volumes, unified treatment of peripherals as special files, integration of the network control program (NCP) within the Unix file system, treatment of network connections as special files that can be accessed through standard Unix I/O calls, closing of all files on program exit, and the decision to be "desirable to minimize the amount of code added to the basic Unix kernel".

### Branding

* 