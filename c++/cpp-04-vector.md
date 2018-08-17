## 00. Lists

- Problem solving often requires information be viewed as a list
  - **Arrays** : traditional. (+) Many legacy libraries. (-) Restrictions on use
  - **Container classes** : *First-class* list representation
    - 예: **vector**, queue, stack, map 등

---

## 01. STL(Standard Template Library)

- STL = Collection of **container** types and algorithms supporting basic data structures
  - container = A generic list representation allowing programmers to specify which types of elements their particular lists hold (Uses the C++ template mechanism)
    - string
    - sequences: deque, list, **vector**(efficient random-access to elements)
    - associative: map, set
    - adapters: priority_queue, queue, stack

---

## 02. Vector Class

- Properties

  - First-class type
  - Efficient subscipting is possible
    - indices = 0 … size of list - 1
  - List size = dynamic
    - can add items as we need them
    - `A.resize(8, 2);` // before: 0 0 0 0 - after: 0 0 0 0 2 2 2 2
  - Index checking is possible
    - through a member function
  - Iterators
    - efficient sequential access

- **Constructors**

  - `vector()` : default - zero length

  - `vector(size_type n, const T &val = T())`

    : **Explicit** constructor - length `n` with each element initialized to `val`

    - `val`이 생략된 경우 default parameter로 T의 default constructor `T()` 부름

  - `vector(const T &V)`

    : **Copy** constructor - duplicate of vector `v` with **shallow copy**

  ```c++
  // default constructor
  vector<T> List;
  // explicit constructor
  vector<T> List(SizeExpression); // default parameter 0 이 Size만큼 담김
  vector<T> List(SizeExpression, Value); // Value가 Size만큼 담김
  // copy constructor
  vector<T> List(AnotherList);
  ```

- **Interface**

  - `size_type size() const` 

  - `bool empty() const` 

    ```c++
    cout << A.size();
    if (A.empty()) {};
    ```

  - `vector<T>& operator= (const vector<T> &V)` - **shallow copy**

    : member assignment operator that makes an exact duplicate of vector V

    ```c++
    vector<int> A(4, 0); // 0 0 0 0
    vector<int> B(3, 1); // 1 1 1
    A = B; //
    ```

  - reference operator

    - `reference operator [] (size_type i)` 

      : **reference** to element i of vector = **Lvalue**

    - `const_reference operator [] (size_type i) const` 

      : **constant reference** to element i = **Rvalue**

  - reference at

    - `reference at [] (size_type i)` 

      : **reference** to element i of vector || exception

    - `const_reference at [] (size_type i) const` 

      : **constant reference** to element i of vector || exception

    ```c++
    vector<int> A(4, 0);
    const vector<int> B(4,0);
    
    A[1] = 3; // lvalue
    cout << A[2]; // rvalue
    cout << B[1]; // rvalue
    
    A.at(1) = 3;
    ```

  - resize

    `resize(8, 2)` => 그대로 두고 차이를 addition. 00002222

    `resize(3, 1)` => 000

  - pop_back() : last element remove

  - push_back(const T &val) : insert a copy of val after last element

    - 예: overloading >>

      ```c++
      push_back
      ```

  - front

    - reference front() : first element return
    - const_reference front()

  - back

    - reference front() : last element return
    - const_reference front()

  - iterators

    - iterator begin()
    - iterator end()

    ```c++
    vector<int> C(4);
    vector<int>::iterator p = C.begin();
    vector<int>::iterator q = C.end();
    ```

    => `vector<int>::` 생략하고 싶으면

    ```c++
    typedef vector<int>::iterator iterator;
    typedef vector<int>::iterator iterator;
    typedef vector<int>::iterator iterator;
    
    iterator p = C.begin(); // 할 수 있다
    ```

    - operators

      `*P` = dereferencing operator 

      `++P` = next

      `--p` = previous

      ```c++
      reverse_iterator q = List.rbegin();
      ```

    - `insert (iterator pos, const T &val = T())`

    - `erase(iterator pos)`

  - 2 dimensional

    `vector< vector<int> > A;` : vector of vectors
