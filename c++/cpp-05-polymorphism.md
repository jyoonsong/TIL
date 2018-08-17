# Templates & Polymorphism





## Polymorphism

- **Polymorphic Functions**

  : Generic Functions - objects of different types

  : choice of which function to execute is made during **runtime** (uses <u>virtual</u> functions)

  - 예
    - Function overloading( `+ ` `Min()`)
    - primitive polymorphism

- **Templates**

  : Generate Function/Class at **compile time**

  - 예
    - STL (Standard Template Library) - Vector 등 container classes



## Templates

```c++
template <class T> // T = formal template parameter
    T Min(const T &a, const T &b) { // T = actual template parameter
    	if (a < b)
            return a;
        else
            return b;
	}

Min(1, 2); // 자동으로 아래를 generate from template
int Min(const int &a, const int &b) {
    // same
}
Rational r(t, 21); Rational s(11, 29);
Min(r, s); // 자동으로 아래를 generate from template
Rational Min(const Rational &a, const Rational &b) {
    // actual template parameter type인 Rational에 대해 < operator define해줘야 함. 안하면 compile-time error
}
```

- STL's template functions

  - find, find_if, count, count_if, min, max, binary_search, lower_bound, upper_bound, sort
  - equal
  - unique, replace, copy, remove, reverse, random_shuffle, merge
  - for_each

- 예: Generic Array Representation

  ```c++
  // Interface
  template <class T>
      class Array {
          public:
          Array(int n = 10, const T &val = T());
          Array(const T A[], int n);
          Array(const Array<T> &A);
          ~Array(); 
          int size() const {
              return NumberValues;
          }
          private:
          int NumberValues;
          T *Values;
      }
  ```

  ```c++
  // Implementation
  // Auxiliary Operators
  template <class T>
      ostream& operator<< (ostream &sout, const Array<T> &A);
  // default constructor
  template <class T>
      Array<T>::Array(int n, const T &val) {
          assert(n > 0);
          NumberValues = n;
          Values = new T [n];
          assert(Values);
          for (int i = 0; i < n; ++i)
              Values[i] = val[i];
      }
  // copy constructor
  template <class T>
      Array<T>::Array(const Array<T> &A) {
          NumberValues = A.size();
          Values = new T [A.size()];
          assert(Values);
          for (int i = 0; i < n; ++i)
              Values[i] = A[i];
      }
  // destructor
  template <class T>
      Array<T>::~Array() {
          delete [] Values;
      }
  // Member Assignment
  template <class T>
      Array<T>& Array<T>::operator=(const Array<T> &A) {
          if (this != &A) {
              if (size() != A.size()) {
                  delete [] Values;
                  NumberValues = A.size();
                  Values = new T [A.size()];
                  assert(Values);
              }
              for (int i = 0; i < A.size(); ++i)
                  Values[i] = A[i];
          }
          return *this;
      }
  ```



## Virtual Functions

: placeholder in the Shape class with specialized definitions in derived class

- **type of object to which the pointer refer** determines which function is invoked

  `A[i] -> Draw()` (O) `A[i].Draw()` (X)

- **Pure Virtual Function**

  : assigning the function the null address within its class definition

  - PVF를 가진 class는 **abstract base class**
  - no implementation

```c++
class Shape : public WindowObject {
    public:
        Shape(SimpleWindow &w, const Position &p, const color c = Red);
        color GetColor() const;
        void SetColor(const color c);
        virtual void Draw(); // Virtual Function
        virtual void Draw() = 0; // Pure Virtual Function
    private:
    	color Color;
}
```

