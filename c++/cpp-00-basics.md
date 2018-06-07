## Intro

```
using namespace std; // std::string s = "" 줄여주는 역할
```

> constant으로 선언할 수 있음 (final과 유사)

```c++
// constant
const float Pi = 3.1415; // read-only
```



## 00. Fundamental Types

> bool 자료형

```c++
bool P = 5 * 15 + 4 == 13 && 12 < 19 || !false == 5 < 24; // F || T
cout << (P && true || (!true)) << endl; // 결과: 1
/* Precedence */
() > Unary Operators > Multiplicative Operators > Additive Operators > Relational Ordering > Relational Equality > && > || > Assignment
```

- 숫자 자료형

```c++
/* Decimal object types */
const int a = 40000L; 
// L or l indicates long integer

/* Floating-point object types */
float b = 0.15F; 
// F or f indicates single precision floating point value
long double d = 0.979e-3L; 
// L or l indicates long double floating point value
double c_oMMon = 1.45E6; 
// Not specified = floating-point constants are of type double
cout << b << d << c_oMMon << endl;

```

- 문자 자료형

```c++
char blank = ' ';
char plus = '+';
// Arithmetic & Relational Operations for Character Object Types
cout << (blank < plus) << " " << ('4' > '3') << endl; // 결과: 1 1
```



## 01. Nonfundamental Types

```c++
#include <string>
// Non fundamental type
// ex1: SimpleWindow, RectangleShape class provided by EzWindows library
// ex2: string class provided by STL(Standard Template Library)
string Name = "Joanne.";
string empty = ""; // empty.size() == 0

empty = Name.substr(1,4); 
// 결과: oann - substring (X) substr(O)
cout << Name.find("it") << " " << Name.find("Jo") << endl; 
// 결과: 18446744073709551615 0
```



## 02. 입출력

- `iostream`  - cin >> 입력 cout << 출력

```c++
#include <iostream>
string Response;
getline(cin, Response); 
getline(cin, Response, '\n'); // delimiter

float Length, Width;
cin >> Length >> Width;
```

```c++
cout << "\"" << Response << "\"" << endl; // endl == ln (생략가능)
```

- **`fstream` : File Processing**

```c++
#include <fstream>
using namespace std;
int main() {
    ifstream fin("mydata.txt");
    int valueProcessed = 0;
    float valueSum = 0;
    float value;
    while (fin >> value) {
        valueSum += value;
        ++valueProcessed;
    }
    if (valueProcessed > 0) {
        ofstream fout("average.txt");
        float avg = valueSum / valueProcessed;
        fout << "Average: " << avg << endl;
        return 0;
    }
    else {
        cerr << "No list to average" << endl;
        return 1;
    }
}
```



## 03. If Control Constructs

```c++
// if-else statement
if (val1 > val2) max = val1;
else max = val2;
// conditional operator ?:
max = (val1 > val2)? val1 : val2;
// switch statement
switch (ch) {
    case 'a': case 'A': case 'i': case 'I': case 'u': case 'U':
    case 'e': case 'E': case 'o': case 'O':
        cout << ch << "is a vowel" << endl;
        break;
    default:
        cout << ch << "is not a vowel" << endl;
}
```



## 04. Iterative Constructs

- `break` : go to 1st statement **after** the structure. has 2 purposes
  - to exit early from a loop (can eliminate use of certain flag variables)
  - to skip the remainder of switch structure
- `continue` : skips remaining statements and proceeds with the next iteration

```c++
// while 예제: best solution of averaging
int numberProcessed = 0;
double sum = 0;
double value;
while (cin >> value) {  // "asfweg" => a s f 차례로
    // input operation is true only if successful extraction was made
    sum += value;
    ++numberProcessed;
}
if (numberProcessed > 0) // empty 방지
    double average = sum / numberProcessed;
```

```c++
// while예제: counting characters
int numberOfNonBlanks = 0;
int numberOfUpperCase = 0;
char c;
while (cin >> c) {
    ++numberOfNonBlanks; // 총 수
    if (('A' <= c) && (c <= 'Z'))
        ++numberOfUpperCase; // 그중 upper case 수
}
// while예제: counting ALL characters
int numberOfCharacters = 0;
int numberOfLines = 0;
char c;
while (cin.get(c)) { // Extracts all characters "asfqwf" => a s f 차례로
    ++numberOfCharacters;
    if (c == '\n')
        ++numberOfLine;
}

// 둘다 현재 상황으론 infinite loop
// 또한 두 예제 사이에 buffer 해주는 작업이 필요하다
```

```c++
// do-while 예제: waiting for a proper reply
char Reply;
do {
    cout << "Decision (y, n) : ";
    if (cin >> Reply)
        Reply = tolower(Reply);
    else
        Reply = 'n';
} while (Reply != 'y' && Reply != 'n');
```



## 05. Functions

- Invocation process (function call)
  - *flow of control* is temporarily transferred to the invoked function 
    - Correspondence established btw actual parameters of the invocation with the formal parameters of the definition
    - Local objects are also maintained in the **invocation’s activation record**. Even main() has a record (모두 activation record로 관리된다)
    - **Activation record** is large enough to store values associated with each object that is defined by the function (함수 안의 변수 충분히 담을 만한 크기)
    - Other information may also be maintained in the invocation's activation record - Possibly a **pointer to the current statement being executed and a pointer to the invoking statement** (함수와 원래 자리 서로 포인터도)
    - Next statement executed is the first one in the invoked function
    - After function completes its action, flow of control is returned to the invoking function and the return value is used as value of invocation
- Execution Process
  - Function body of invoked function is executed
  - Flow of control then returns to the invocation statement
  - The return value of the invoked function is used as the value of the invocation expression



## 06. Standard Libraries

#### `fstream`

#### `assert` Function

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



