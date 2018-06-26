# Pointers & Dynamic Objects

- usefulness

  - pass command line parameters
  - variable-sized lists

- Expressions

  - Lvalue

    : evaluated & modified

  - Rvalue

    : only evaluated

  ```c++
  int a;
  int b[3];
  int c[3];
  a = 1; // a: lvalue
  c[0] = 2*a + b[0]; // c[0], a, b[0]: lvalues
  ```



## Pointer

**object** whose value represents the **location of another object**

- pointer types for each type of object

  - even pointer to pointer to int

- Syntax

  - `char *ptr = &ch` : ptr= pointer to a char ch

  - `*ptr = 'a'` : **indirection or dereferencing** // *ptr은 lvalue

  - member indirection

    ```c++
    Rational r(4,3);
    Rational *rPtr = &r;
    (*rPtr).Insert(cout);
    rPtr->Insert(cout); // 같은 의미
    ```

- Null Address

  - `int *ptr = 0` => `*ptr`은 invalid (not pointing)

- constant pointer 

  - `char c = 'c'`

  - `char * const ptr1 = &c`

    - cannot change location `ptr = &d` (X)

  - `const char d = 'd'`

    `const char *ptr2 = &d`

    - cannot change value by pointer `*ptr2 = 'e'` (X)



## Dynamic Objects

- Local objects

  - memory acquired automatically
  - memory returned automatically when object goes out of scope

- Dynamic objects

  - memory is acquired **during program execution** as the result of a specific **program(allocation) request** (`new` opration)
  - Survive beyond execution of function in which they are acquired(allocated).
  - object memory is returned by a **deallocation request**(`delete` operation)

- General `new` operation

  - basic syntax

    `someType ptr = new someType` - pointer of type someType

    `someType *ptr = new someType(ParameterList)` 

    - delete `delete P;`

  - primary syntax (list)

    `someType P = new someType [Expression]`

    - delete `delete [] P`

- Problems

  - Dangling Pointer Pitfall