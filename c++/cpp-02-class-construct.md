# Ch17. The Class Construct

## 01. Class Constructs

> Allows programmers to define new data types for representing information.
>
> Provides object-oriented programming in C++.

- **Object Attributes** (attribute components) : **data members**

- **Object Behaviors** (behavior components) : **member functions/methods**

  : provide a **controlled interface** to data members, object access & manipulation. 

  > 아래 기능과 더불어 Can be used to keep data members in a correct state

  - **Constructors** 

    : member functions that initialize an object during its definition

    - do not have a type = considered **superfluous**(불필요한)

    `RectangleShape R(W, x, y, c, w, h);`

  - **Inspectors**

    : member functions that act as a messenger that returns the value of attribute

    `color CurrColor = R.GetColor();`

  - **Mutators**

    : changes the value of attribute

    `R.setColor(Black);`

  - **Facilitators**

    : causes an object to perform some action or service

    `R.Draw();`



- **Header File 예시**
  - Access right
    - `public` - all clients & class members have access to public members
    - `private` - only class members have access to the private members. client cannot directly access private or protected data members.
  - Reference Parameter말고 Reference Return 도 있음 `float& GetHeight()`
  - prototype 끝에 `const` - Object를 바꾸는가?
    - inspector 안 바꾼다 `float GetWidth() const;`
    - mutator 바꾼다 `void SetWidth(float Width);`

```cpp
#ifndef RECT_SHAPE_HPP
#define RECT_SHAP_HPP // preprocessor directives
#include "ezwin.h"

class RectangleShape {
public: // Access right
    /* constructor */
    RectangleShape(SimpleWindow &Window, float XCoord, float YCoord, const color &c, float Width, float Height);
    
    /* facilitator */
    void Draw();
    
    /* inspectors */
    // const = member functions won't change the object
    color GetColor() const; 
    float GetWidth() const;
    float GetHeight() const;
    void GetSize(float &Width, float &Height) const;
    void GetPosition(float &XCoord, float &YCoord) const;
    SimpleWindow& GetWindow() const; 
    // Reference return brings actual window (not a copy)

    /* mutators */
    // Lack of const = the member function might change the object
    void SetColor(const color &c); 
    void SetPosition(float XCoord, float YCoord);
    void SetSize(float Width, float Height);
    
private: // Access right
    // data members
    SimpleWindow &Window;
    float thisXCenter;
    float thisYCenter;
    color thisColor;
    float thisWidth;
    float thisHeight;
};

#endif // close of #ifndef directive
```

- **Client 예시**

```c++
SimpleWindow W("Testing", 20, 10);
RectangleShpae R(W, 2, 2, Blue, 4, 3);
const RectangleShape S(W, 15, 10, Red, 5, 6);

color c = R.GetColor();	// O Blue
color d = S.GetColor(); // O Red
color d = R.thisColor();// X
R.SetColor(Yellow); 	// O
S.SetColor(Black);  	// X
```



## 02. Abstract Data Types

- **Rules**

  - Information Hiding & Encapsulation

    - Implementation in a separate module

    - Data members are private so that Interface is required 

      (immune to implementation changes)

  - Class minimality rule

    - implement a behavior as **nonmember** function when possible
    - only add behavior if necessary

- **ADT**

  정의: a class of objects whose logical behavior is defined by a set of values & operations

  예제: Rational Number

  - Client

    `MyProgram.cpp` 
    => Preprocessor(combines iostream, rational.h) 
    => `Compilation Unit` 
    => Compiler 
    => `MyProgram.obj` 
    => Linker(combine Rational Library file with MyProgram.obj) 
    => `MyProgram.exe`

  ```c++
  #include <iostream>
  using namespace std;
  #include "rational.h" // provides access to the class definition & auxiliary function prototypes, NOT definition
  int main() {
      Rational r;
      Rational s;
      cout << "Enter two rationals(a/b): ";
      cin >> r >> s;
      Rational Sum = r + s;
      cout << r << " + " << s << " = " << Sum;
      return 0;
  }
  ```

  - Header File

    1. Preprocessor statements : ensure 1 inclusion per translation unit
    2. Class definition
    3. Library Prototypes

    > `const` 붙이느냐 마느냐

    => 그 안에서 결과적으로 Getter를 쓰느냐 Setter를 쓰느냐. 전자면 붙이고 후자면 안 붙임.

  ```c++
  /* Preprocessor Statements */
  #ifndef RATIONAL_H
  #define RATIONAL_H
  
  /* Class Definition */
  class Rational {
      
      //For everyone including clients
      public:
      	// default constructor
      	Rational();
      	// specific constructor
      	Rational(int numer, int denom = 1);
          // arithmatic facilitators
          Rational Add(const Rational &r) const;
          Rational Multiply(const Rational &r) const;
          // stream facilitators
          void Insert(ostream &sout) const;
          void Extract(istream &sin) const;
      
      //For member functions of Rational & classes derived from Rational 
      protected:
          // inspectors
          int GetNumerator() const;
          int GetDenominator() const;
          // mutators
          void SetNumerator(int numer);
          void SetDenominator(int denom);
      
      //For Rational member functions
      private:
          // data members
          int NumeratorValue;
          int DenominatorValue;
  }; // 세미콜론 해줘야함!
  
  /* Library Prototypes */
  // Auxiliary Operator Prototypes
  Rational operator+(const Rational &r, const Rational &s); // Add
  Rational operator*(const Rational &r, const Rational &s); // Multiply
  ostream& operator<<(ostream &sout, const Rational &s); // Insert
  istream& operator>>(istream &sin, const Rational &r); // Extract
      
  #endif
  ```

  - Implementation

    > Object를 명시해야 하는가?

    - Class member functions 내에서: 당연히 대상 object 명시 안해줘도 됨
    - Auxiliary Functions 내에서: 멤버 아니므로 object 명시해줘야 함. `object.member`

    > default parameter `(int denom = 1)`은 한 곳에서만! 
    > header에 있는데 여기서 또 하면 에러.

  ```c++
  #include <iostream> // Header 부르기 전에 해줘야 함!
  #include <string>
  #include <cassert>
  using namespace std; // 잊지말것
  #include <rational.h> // Header File
  // Default Constructor
  Rational::Rational() {
      SetNumerator(0);
      SetDenominator(1);
  }
  Rational::Rational(int numer, int denom){ // denom = 1 header에만!!
      SetNumerator(numer); // 예 Rational u(2); // u = 2/1
      SetDenominator(denom);
  }
  // inspectors
  int Rational::GetNumerator() const {
      return NumeratorValue;
  }
  int Rational::GetDenominator() const {
   	return DenominatorValue;
  }
  // mutators
  void Rational::SetNumerator(int numer) {
      NumeratorValue = numer;
  }
  void Rational::SetDenominator(int denom) {
      if (denom != 0)
          DenominatorValue = denom;
      else {
          cerr << "Illegal denominator: " << denom << "using 1" << endl;
          DenominatorValue = 1;
      }
  }
  // arithmatic facilitators
  Rational Rational::Add(const Rational &r) const {//Get=>const
      int a = GetNumerator();
      int b = GetDenominator();
      int c = r.GetNumerator();
      int d = r.GetDenominator();
      return Rational(a*d + b*c, b*d);
  }
  Rational Rational::Multiply(const Rational &r) const {//Get=>const
      int a = GetNumerator();
      int b = GetDenominator();
      int c = r.GetNumerator();
      int d = r.GetDenominator();
      return Rational(a*c, b*d);
  }
  // stream facilitators
  void Rational::Insert(ostream &sout) const {//Get=>const
      sout << GetNumerator() << '/' << GetDenominator();
      return;
  }
  void Rational::Extract(istream &sin) const {//Set=>NOT const
      int numer, denom;
      char slash;
      sin >> numer >> slash >> denom;
      assert(slash == '/');
      SetNumerator(numer);
      SetDenominator(denom);
      return;
  }
  // Auxiliary Operator Prototypes
  Rational operator+(const Rational &r, const Rational &s) {//Get=>const
      return r.Add(s); // t.Add(s)을 t+s 로 할 수 있게 함.
  }
  Rational operator*(const Rational &r, const Rational &s) {//Get=>const
      return r.Multiply(s); // t.Multiply(s)을 t*s 로 할 수 있게 함.
  }
  ostream& operator<<(ostream &sout, const Rational &s) { //Get=>const
      r.Insert(sout); // t.Insert(cout)을 cout << t 로 할 수 있게 함.
      return sout;
  }
  istream& operator>>(istream &sin, Rational &r) { // Set => NOT const
      r.Extract(sin); // t.Extract(cin)을 cin >> t;로 할 수 있게 함.
      return sin;
  }
  ```

  - Gang of Three

    > 모두 **default로 제공**. Custom 정의할 수 있다

    **[1] Copy Constructor**

    - Default copy construction

      : **Shallow Copying** = Copy of one object to another in a **bit-wise** manner

      : 굳이 **만들어주지 않아도 `Rational s(a)` 알아서 생성**된다

    - Custom copy construction

      : NOT bit-by-bit. Copy only necessary parts (Rational은 사실 거의 불필요)

    **[2] Assignment Operator**

    ​	: Copy source to target and return target (A = B = C)

    ​	: 굳이 **만들어주지 않아도 `Rational t = b` 알아서 생성**된다

    **[3] Destructor**

    ​	: Clean up the object when it goes out of scope

  ```c++
  // Custom Copy Constructor
  Rational::Rational(const Rational &r){
      int a = r.GetNumerator();
      int b = r.GetDenominator();
      SetNumerator(a);
      SetDenominator(b);
  }
  Rational& Rational::operator =(const Rational &r) {
      int a = r.GetNumerator();
      int b = r.GetDenominator();
      SetNumerator(a);
      SetDenominator(b);
      return *this; // object whose member function was invoked
  }
  // Rational Destructor
  Rational::~Rational() {
      // Nothing to do
  }
  ```

  

