# Ch.2 Recursion: The Mirrors

### Recursive Algorithm?

- An algorithm that calls itself for subproblems

  The subproblems are of exactly the same type as the original problem – mirror images

- 어떨 땐 약, 어떨 땐 독 (늘 좋은 건 NO)

---

> ### Recursion이 약이거나 같은 경우

### Search in Unsorted Array

- check all n elements 
  - worst case = `O(n)` (끝에 나옴)
  - average case = `O(n)` = O(n/2) (딱 중간에 나옴)
  - best case = `O(1)` (바로 나와서 상수 시간)

### Search in Sorted Array

> **sequential search**

- worst case = `Θ(n)` : 운나쁘면 맨 마지막 <=> best case = `Θ(1)` : 운 좋으면 맨 처음
- Average case = `Θ(n)` = `Θ(n/2)` : 평균적으로 가운데

> **binary search**
>
> 원리는 중간지점 비교하며 보내는 것으로 같지만, while문을 돌려 한 함수에서 해결하느냐 vs Recursion으로 해결하느냐의 차이. 전자는 n을, 후자는 low, high를 parameter로 받는다.

- **Non-recursive**

  - worst case = `Θ(log n)`
  - average case = `Θ(log n)`
  - best case = `Θ(1)`

  ```java
  BinarySearch(A[], n, x) {
      low = 0;
      high = n-1;
      while (low < high) {
          mid = (low + high)/2;
          if (A[mid] < x) low = mid+1;
          else if (A[mid] > x) high = mid-1;
          else return mid;
      }
      return "Not Found";
  }
  ```

- **Recursive**

  - **worst case = `O(log n)` [기출 2003F-1, 2015-1, 2003S-5]**
  - average case = `O(log n)`
  - best case = `O(1)`

  ```java
  BinarySearch (A[], x, low, high) {
      if (low > high) return "Not Found";
      mid = (low + high)/2; // 기출 oneThird = low+(high-low+1)/3;
      if (A[mid] < x) BinarySearch(A[], mid+1, high);
     	else if (A[mid] > x) BinarySearch(A[], low, mid-1);
      else return mid;
  }
  // 상수시간 오버헤드를 감수하면 문제의 크기가 반이 된다
  // n => n/2 => n/4 => n/8 => ... => n/n=(2의log(2)n승)
  // 크기 1인 문제가 됐을 때 i) 걔가 x ii) x 없음 => 다음 recursion에서 low>high
  ```

### Factorial

- **Non-recursive**

  - for루프가 시간을 지배 (나머지 부분은 상수시간 소요) = `Θ(n)` (n에 비례)

  ```java
  fact(n) {
      tmp = 1;
      for (i=1; i<=n; i++) {
          tmp *= i;
      }
      return tmp;
  }
  ```

- **Recursive**

  - fact함수가 총 몇 번 호출되는가가 시간을 좌우 = `Θ(n)` (n에 비례)

    n => n-1 => … => 2 => 1 =X=> 0  총 호출 횟수 = n

  ```java
  fact(n) {
      if (n == 0) return 1; // base case
      return n * fact(n-1);
  }
  ```



### Writing a String Backward

- **Recursive**

  ```java
  writeBackward(s) {
      if (s == empty) return; // do nothing
      return s[last] + writeBackward(s - s[last]);
      // write the last character of s
      // recursive call without last character
  }
  ```

  ```java
  writeBackward(s) {
      if (s == empty) return;
      return writeBackward(s - s[0]) + s[0];
      // recursive call without first character
      // write the first character of s
  }
  ```



### Kth Smallest Element in unsorted Array

- **Recursive** (초딩)

  - worst case =  `Θ(n^2)` : k=n이어서 첫번째 비교까지 n번 재귀, 각 call마다 n번 비교루프
  - average case =  `Θ(kn)` : n번 재귀, 각 call마다 (n-상수)번 비교를 k번 하므로 kn에 비례

  ```java
  KthSmallest(A[], k, n) {
      min = minOf(A); // find min
      compact(A, min); // remove min(맨뒤로) => compact the array
      if (k == 1) return min;
      else return KthSmallest(A[], k-1, n-1);
  }

  minOf(A) { // 내가 추가
      int min;
      for (i=0; i<n; i++) {
          if (min > A[i])
              min = i;
      }
      return min;
  }

  compact(A, min) { // 내가 추가
      tmp = A[min];
      for (i=min+1; i<n; i++) {
          A[i-1] = A[i];
      }
      A[n-1] = tmp;
  }
  ```

- **Recursive** (better)

  > **pivotIndex-first+1 잊지 말 것!**

  - `T(n) = Θ(n) + T(n-1)` n에 비례하는 overhead 감수하고 크기가 하나 작은 문제 만남
  - worst case = `Θ(n^2)`
  - average case = `Θ(n)`

  ```java
  KthSmallest(A[], k, first, last) {
      partition(A, p); // select p => smaller on left, larger on right
      if (k < pi-first+1) return KthSmallest(A, k, first, pi-1);
      else if (k == pi-first+1) return p;     
      else return KthSmallest(A, k-(pi-first+1), pi+1, last);
  }
  ```



### Hanoi Tower

(moved to 6-induction)



---

> ### Recursion이 독인 경우

### Fibonacci Sequence

- **Non-recursive**

  - for루프가 시간을 지배 (나머지 부분은 상수시간 소요) = `Θ(n)` (n에 비례)

  ```java
  fib(n) {
      t[1] = t[2] = 1;
      for (i=3; i<=n; i++)
      	t[i] = t[i-1] + t[i-2];
      return t[n];
  }
  ```

- **Recursive**

  - **중복호출** 

    f(n)이 두 개를 부르고, 그 두 개는 각각 두 개를 부르고, 그 네 개는 각각 두 개를 부르고..

    2의 n/2승보다 크고 `fib(n) = Ω(2^n/2)` 

    2의 n승은 안된다 `fib(n) = O(2^n)`

    > dynamic programming = 재귀적 알고리즘 효율성 문제 해결 총칭(나중)

  ```java
  fib(n) {
      if (n <= 2) return 1; // base case
      return fib(n-1) + fib(n-2);
  }
  ```

  - **[기출] 2012-4 fibonacci recursive algorithm에서 fib()는 최소 root(2^n) -1 번 호출됨을 증명**

    ```bash
    fib(n)이 fib()를 호출하는 횟수를 c(n)이라고 할 때

    # 1) base case
    c(1) = 1 >= 루트2-1 (0.1414)
    c(2) = 2 >= 2-1

    # 2) inductive case
    k>=1인 모든 정수 k에 대하여 c(k) >= root(2^k)-1, c(k+1) >= root(2^k+1)-1일 때, c(k+2) >= root(2^k+2)이다.

    fib(k+2) = fib(k+1) + fib(k)이기 때문에
    c(k+2) >= root(2^k)-1 + root(2^k+1)-1 = root(2^k)(root(2)+1)-2

    여기서 root(2^k)(root(2)+1)-2 >= root(2^k+2)이므로 성립.
    (바로 위 부등식은 root(2^j) >= root(2) - 1 로 정리됨)

    따라서 1보다 크거나 작은 모든 정수 n에 대하여 c(n) >= root(2^n)-1
    ```

    ​

### C(n,k)

C(n,k) 	= C(n-1, k-1) + C(n-1, k) 	if 0 < k < n

​		= 1						if k = 0, k = n

​		= 0						if k > n

- **Recursive**

  - **중복호출** - 예컨대 C(4,2)를 부르면 C(2,1)이 2번 수행된다.

  ```java
  C(n, k) {
      if (k == 0 || k == n) return 1;
      else if (k > n) return 0;
      else return C(n-1, k-1) + C(n-1, k);
  }
  ```



