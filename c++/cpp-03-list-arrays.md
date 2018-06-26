## 00. Lists

- Problem solving often requires information be viewed as a list
  - **Arrays** : traditional. (+) Many legacy libraries. (-) Restrictions on use
  - **Container classes** : First-class list representation
    - 예: **vector**, queue, stack, map 등

---

## 01. Arrays

- Terminology

  - elements

  - common name

  - base type - elements are of the same type. 

  - elements are referenced by **subscripting/indexing** the common name

    - Subscripts = denoted as expressions within brackets []

    - Index = integer.

      Index range = 0…n-1 where n is programmer-defined constant expression

- Syntax

  `BaseType NameOfList [ SizeExp ];`

  예: `double X [110 - 10]` - subscripts are 0 through 99

- 특징

  - const 사용 가능
  - Arrays are always **passed by reference**

- 예제

  ```c++
  int ListMinimum(const int A[], int asize) {
      assert(asize >= 1);
      int SmallestValueSoFar = A[0];
      for (int i = 1; i < asize; ++i)
          if (A[i] < SmallestValueSoFar)
              SmallestValueSoFar = A[i];
      return SmallestValueSoFar;
  }
  void DisplayList(const int A[], int n) {
      for (int i = 0; i < n; ++i)
          cout << A[i] << " ";
      cout << endl;
  }
  void GetList(int A[], int &n, int MaxN = 100) {
      for (n = 0; (n < MaxN) && (cin >> A[n]); ++n)
          continue;
  }
  const int MaxNum = 25;
  int Val[MaxNum];
  int Num;
  GetList(Val, Num, MaxNum); // 입력받음
  DisplayList(Val, Num); // 출력
  ```

- Multi-Dimensional Arrays 

  - Syntax of k-dimensional array

    `btype mdarray[size_1][size_2]...[size_k]`

  - row-major order

    예: `int M[2][4]` = 2 rows of 4 elements

  - The array is assigned to a contiguous section of memory

    - first row - first portion
    - second row - second portion...
    - … 순으로 메모리에 할당됨