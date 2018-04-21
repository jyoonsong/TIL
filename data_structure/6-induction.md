# Ch.6 Recursion - Math.cal Induction

### Hanoi Tower

- **Recursive**

  ```java
  // objective = move n disks in pole A to pole B
  move(n, source, destination, spare) {
      if (n==1) 1 disk from A to B; // base case
      move(n-1, A, C, B);
      move(1, A, B, C);
      move(n-1, C, B, A);
  }
  ```

- **Cost of Hanoi Tower**

  moves(n) = 2moves(n-1) + 1

  => **moves(n) = 2^n - 1** 증명해보자

  > 이렇게 1씩 차이 나는 induction은 고등과정 수학적 귀납법과 일치

  - **basis** :

    moves(1) = 1 = 2^1 - 1

  - **inductive hypothesis** :

    Assume moves(k) = 2^k - 1

  - **inductive conclusion** :

    moves(k+1) = 2moves(k) + 1 = 2*(2^k - 1) + 1 = 2^(k+1) - 1

  ​

- **[기출] 한 번에 3개까지 옮길 수 있는 버전**

  ```java
  move (n, source, destination, spare) {
      if (n==1 || n==2 || n==3) n disks from A to B;
      move(n-3, A, C, B);
      move(3, A, B, C);
      move(n-3, C, B, A);
  }
  ```

  **이렇게 하면 n개의 원반을 다 옮기려면 총 몇 번의 이동이 필요한가? (모든 자연수 n에 대하여)**

  => 수학적귀납법으로 증명 `Tn = 2^[n/3] - 1`  

  - **base case**

    n=1, n=2, n=3 대입

  - **inductive Case**

    n<k (or n=k-3) 일 때 성립함을 가정하고, n=k일 때 성립함을 보인다.

    (원래는 n=k일 때 성립함을 가정, n=k+1일 때 성립함을 보임)

  - 위 두개 만족하면 모든 n에 대하여 공식이 성립한다







