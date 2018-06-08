## 01. Functions

#### 1.1. Prototype & Definition & Invocation & Execution

- Function **Prototype**s `returnType FunctionName (ParameterList)`

  - Before a function can appear in an invocation, its interface(prototype or complete definition) must be specified
  - Prototypes are normally kept in library header files

- Function **Definition** `returnType FuncName(FormalParameters){FunctionBody}`

  => includes description of interface and the function body

  - **Interface**

    - Similar to function prototype, but **parameters' name are required**

  - **Body**

    - Statement list with curly braces that comprises its actions
    - Return statement to indicate value of invocation(= return value 정의).

    ```c++
    float CircleArea(float r) {
        const float Pi = 3.1415; // Local object definition
    	return Pi * r * r; // Return statement
    ```

- Function **Invocation** (= function call)  `y = FunctionName(ActualParameters)`

  => *flow of control* is temporarily transferred to the invoked function 
  - Correspondence established btw 
    - **actual parameter**s of the **invocation** with the
    - **formal parameter**s of the **definition**
  - Invocation's **Activation Record**
    - **Local objects** are also maintained in the invocation’s activation record. Even main() has a record (모두 activation record로 관리된다)
    - Activation record is large enough to store values associated with **each object defined by the function** (함수 안의 변수 충분히 담을 만한 크기)
    - Other information may also be maintained in the invocation's activation record - Possibly a **pointer to the current statement being executed** and a **pointer to the invoking statement** (함수와 원래 자리 서로 포인터도)
  - Next statement executed is the first one in the invoked function
  - After function completes its action, flow of control is returned to the invoking function. The **return value** is used as **value of function call(invocation)**

- Function Execution Process
  - Function body of invoked function is executed
  - Flow of control then returns to the invocation statement
  - The return value of the invoked function is used as the value of the invocation expression



#### 1.2. Blocks and Local Scope

- block = a list of statements within curly braces

  - can be put anywhere a statement can be put
  - nested blocks = blocks within blocks
  - An object name is known only within the block it is defined and in nested blocks of that block
  - A parameter can be considered to be defined at the beginning of the block corresponding to the function body

- **Local Object Manipulation**

  - **Name reuse** : if a nested block defines an object with the same name as enclosing block, the new definition block  is in effect in the nested block

    ```c++
    void f() {
        { //int i의 scope 시작
            int i = 1;
            { //char i의 scope 시작
                cout << i << endl; // insert 1
                char i = 'a';
                cout << i << endl; // insert a
            } //char i의 scope 끝
            cout << i << endl; // insert 1;
        } //int i의 scope 끝
    	cout << i << endl; // ILLEGAL
    }
    ```

- **Global Scope**

  - **global objects** = Objects not defined within a block

    - can be used by any function in the file defined after the global object

    - best to avoid programmer defined global objects (예외: important constants)

    - can even be used in other program files with appropriate declarations

      예: `cout` `cin` `cerr` are global objects that are defined by `iostream` library

  - Local objects can reuse global object's name

    - **unary scope operator** `::` can provide access to global object even if name reuse has occured

    ```c++
    int i = 1; // global object i
    void f() {
        cout << i << endl; // insert 1
        {
            char i = 'a';
            cout << i << endl; // insert a
            ::i = 2; // global object i
            cout << i << endl; // insert a
            cout << ::i << endl; // insert 2
        }
        cout << i << endl; // insert 2
    }
    ```

  



#### 1.3. Parameter Passing

- **Value Parameter Rules (Pass by Value)** 

  - Formal parameter is **created** on function **invocation**

    and it is **initialized** with the value of the actual parameter

  - **Changes** to formal parameter do NOT affect actual parameter

  - **Reference** to a formal parameter produces 

    the **value for it** in the current activation record

  - **New activation record** for every function **invocation**

    Formal parameter name is only known within its function

  - Activation record memory is automatically released at function completion

    Formal parameter ceases to exist when function completes.

- **Reference Parameters**

  - formal parameters become an **alias** for the actual parameter

    - in an invocation the **actual parameter is given** rather than a copy.
    - changes to the formal parameter change the actual parameter

  - **Function definition**에서 `type name`이냐 `type &name`이냐에 따라 whether a parameter's passing style is by value or by reference 결정됨

    ```c++
    void Swap(int a, int b){} // by VALUE : does NOT swap
    void Swap(int &a, int &b){} // by REFERENCE : does swap
    ```

    ```c++
    GetNumber(Number1, cin);
    GetNumber(Number2, fin);
    void GetNumber(int &MyNumber, istream &sin) {
        sin >> MyNumber;
        return;
    ```

- **Constant Parameters** (by Reference)

  - `const` indicates that the function may not modify the parameter

  - When we want to pass an object by **reference**, but NOT want to let the called function modify the object

    > WHY NOT just pass the object by VALUE?
    >
    > **For large objects, making a copy of the object can be very inefficient**

    ```c++
    PromptAndGet(x, "Enter number (n): ")
    void PromptAndGet(int &n, const string &s) {
        cout << s;
        cin >> n;
        s = "Got it"; // ILLEGAL (caught by compiler)
    ```

- **Default Parameters**

  - allows programmer to define a *default behavior*

    - a value for a parameter can be **implicitly passed**
    - reduces need for **similar functions that differ only in the number of parameters accepted**

    ```c++
    void PrintChar(char c = '=', int n = 80); // HEADER (interface)
    PrintChar('*', 20); // * 20번
    PrintChar('*');		// * 80번
    PrintChar();		// = 80번
    void PrintChar(char c, int n) { // 헤더에 썼으면 여기는 X. 쓰면 에러!
        for (int i = 0; i < n; ++i)
            cout << c;
    ```

    - i번째 argument in invocation 없으면 => i번째 parameter initialized to default

    ```c++
    PrintChar(70);		// 70을 char로 바꿔서 80번 출력됨
    PrintString(20)		// ILLEGAL
    void PrintString(string str = "hi", int n = 80){...}
    ```

    - Default parameters must appear **after** any mandatory parameters

    ```c++
    void Trouble(int x = 5, double z, double y){} // ILLEGAL
    ```

    - optional reference parameters are also permitted

    ```c++
    GetNumber(x, cin);
    GetNumber(y);
    GetNumber(z, fin);
    bool GetNumber(int &MyNumber, istream &sin = cin) {
        return sin >> MyNumber;
    }
    ```




#### 1.4. Function Overloading

- Two functions with the **same name** but with **different interfaces** (typically different formal parameter lists)

  - Difference in number of parameters `Min(a, b, c)` `Min(a, b)`
  - Difference in types of parameters `Min(10, 20)` `Min(4.4, 9.2)`

  ```c++
  // Function Overloading
  int Min(int a, int b) {
      cout << "Using int min()" <<endl;
      if (a > b)
          return b;
      return a;
  }
  
  double Min(double a, double b) {
      cout << "Using double min()" <<endl;
      if (a > b)
          return b;
      return a;
  }
  ```

- Compiler uses **function overload resolution** to call the most appropriate function

  1. looks for function definition where formal and actual parameters **exactly match**
  2. If no exact match, attempt to **cast** the actual parameters to ones used by an appropriate function

  > 복잡하므로 오버로딩 사용할 때는 매우 조심해야 한다.



## 02. Libraries

- 정의: Collection of **functions, classes, objects** grouped by commonality of purpose

  - Include statement `#include <librayname>` provides access to the names and descriptions of the library components
  - **Linker** connects program to actual library definitions

- Basic Translation Process

  - Source Program

  - Process **preprocessor directives** to produce => translation unit

  - Check translation unit for legal syntax and **compile** it into => an object file

  - **Link** object file with standard object files and other object files to produce => an executable unit

    > Linker는 header file에게 access to compiled versions of source files 제공

  - Executable Unit

- **Library Header File**

  - Describes library components. 
  - Typically contain
    - Function Prototypes (Interface Description)
    - Class Definitions
    - Object Definitions (sometimes) 예: `iostream`의 `cin` `cout`
  - Typically NOT contain
    - Function Definitions (보통 source file에 있음)



## 03. Standard Libraries

`string` : STL's string class

`fstream` : File stream processing

`iomanip` : Formatted input/output requests

`ctype` : C-based library for character manipulations

#### `cassert` - `assert` function

- C-based library for assertion processing
- **terminate** program execution when certain types of **elusive errors** that are very difficult to catch occur.
  - 예: divisiion by zero

```c++
#define NDEBUG // disable assert()
#include <cassert>

assert(2+2 == 4) // true면 execute
    cout << "first\n";
assert(2+2 == 5) // false면 terminate
    cout << "first\n"; // 출력안됨 Assertion failed Aborted
```

#### `cmath`

- C-based library for trigonometric & logarithmic functions

```c++
#include <cmath> // Library Header Files
cout << "Enter Quadratic coefficients: ";
double a, b, c;
cin >> a >> b >> c;
if ( (a != 0) && (b*b - 4*a*c > 0)) {
    double radical = sqrt(b*b - 4*a*c); // Invocation
    double root1 = (-b + radical) / (2*a);
    double root2 = (-b - radical) / (2*a);
    cout << "Roots: " << root1 << " " << root2;
}
else
    cout << "Does not have two real roots";
```



