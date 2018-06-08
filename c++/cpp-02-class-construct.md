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

  - 정의: a class of objects whose logical behavior is defined by a set of values & operations
  - 예제: Rational Number

