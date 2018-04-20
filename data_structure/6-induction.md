# Ch.6 Recursion - Backtracking

> Ch.3보다 심화적으로 Recursion 다룰 것. 아래 두개를 중점으로
>
> 1. **BackTracking**
> 2. Formal Grammars

### 정의

여러 방식으로 정의가 가능하다.

- A search strategy by a sequence of guesses

  guesses => retraces in reverse order => tries a new sequence of steps

  **가는 데까지 가보고 안되면 되돌아와 다른 걸로 가는 방식**

- **DFS (Depth First Search) 방식으로 Search**하는 모든 방식

- Recursion 외에 **Stack과도 밀접**한 관련


---


### [1] Eight-Queens Problem 

- 조건
  - 8x8격자에 여왕을 놓아야함
  - 하면 안되는 것: within its row / withinits column / alongits diagonal


- 풀이
  - 1차 시도
    - `placeQueens(1)` while문 진입. underAttack아니므로 (1,1)에 놓고 본다

      - `placeQueens(2)` 호출됨. 1,2는 underAttack (2,3)에 놓고 본다.

        - `placeQueens(3)` 호출됨. 1,2,3,4 underAttack (3,5)에 놓고 본다.

          - `placeQueens(4)` 1은 underAttack (4,2)에 놓고 본다.

            - `placeQueens(5)` 1,2,3은 underAttack. (5,4)에 놓고본다.
              - `placeQueens(6)` while문 다 돌아도 모두 underAttack. 
            - `placeQueens(5)`로 다시 return. `placeQueens(6)`이 return한 queenPlaced가 false이므로 removeQueen하고 row++한 후 새로운 루프를 돈다. 그러나 다 돌아도 모두 underAttack.

          - `placeQueens(4)`로 다시 return. `placeQueens(5)`가 return한 queenPlaced가 false => removeQueen, 새로운 루프를 돈다. 이번에는 (4,7)이 또 가능하다.

            - `placeQueens(5)` 호출됨. 1은 underAttack (5,2)에 놓고 본다.

              - `placeQueens(6)` 1,2,3은 underAttack (6,4)에 놓고 본다.

                - `placeQueens(7)`1…5 underAttack (7,6)에 놓고 본다.

                  - `placeQueens(8)` 모두 underAttack

                - `placeQueens(7)`로 다시 return. 새로운 루프 돌지만 다 돌아도 모두 underAttack

                  ...

  > 하다보면 답은 12가지

=> 재귀적 구조

재귀로 가보고, **안되면 포기한다**

> 앞에서 배운 재귀에서는 포기는 없었음. 그래서 이게 advanced recursion

```java
public boolean placeQueens(int col) {
    // queens are placed correctly in columns 1 through (col-1)
    // return true if solution is found
    // return false if no solution
    if (col > BOARD_SIZE) return true; // 성공
    else {
        boolean queenPlaced = false;
        int row = 1;	// square id in column
        while (!queenPlaced && row <= BOARD_SIZE) {
            if (isUnderAttack(row, col))
                ++row;
            else {
                setQueen(row, col);
                queenPlaced = placeQueens(col+1);
                if (!queenPlaced) {
                    removeQueen(row, col);
                    ++row;
                }
            }
        }
        return queenPlaced;
    }
}
```

---

### [2] Formal Grammar

- Basics
  - x|y = x or y
  - xy = continuation
  - `<word>` = means any instance of word that the definition defines

> - 자연어 처리 Natural Language Processing
> - 언어학 중심으로 하곤 했음
>   - ex. <문장> = <1형식> | <2형식>  | ...
>     ​     <1형식> = <주어><동사>
> - 최근엔 데이터 중심으로 품질상승 중.
>   - 구글 주도 방대한 문서의 통계 중심 번역 중. 언어학 지식은 미비한 채.
>   - 알파고 리를 이긴 알파고0도 마찬가지. 바둑계의 이론적 지식은 미비. 데이터 중심의 프로세싱.



#### 예 2-1. Java Identifier - Recursive Routine

- letter & digit instance

  - `<letter>` = a | b | · · · | z | A | B | · · · | Z | _ | $

  - `<digit>` = 0 | 1 | · · · | 9

    > 0 or 1 or 2 or… or 9 의미

- Base Case

  - `<letter>` - 결국 0번째는 letter. 결국 boundary case인 letter로 끝나게 되기 때문.

- Recursion

  - 혹은 `<identifier><letter>`
  - 혹은 `<identifier><digit>`

  => **재귀적 구조로 정의**

  - ex. `tmp3`
    - `tmp`(유효한 identifier) 뒤 digit `3`
    - `tm` 뒤 letter `p`
    - `t` 뒤 letter `m`
    - `t`는 유효한 identifier

  ```java
  isId(w) {
      if (w.length == 1) { // base case
          if (w == <letter>) return true;
          else return false;
      }
      else if (w[last character] == <letter> | <digit>) {
          // if the last character of w is a letter or a digit
          return isId(w - w[last character]);
      }
      else {
          return false;
      }
  }
  ```

  ​



#### 예 2-2. Palindrome

- 정의

  - {w | w reads the same left to right as right to left}

    > 앞디뒷디 ㅋㅋ 앞으로 읽으나 뒤로 읽으나 같은 것

- Base case

  - empty string도 palindrome
  - `<ch>` 하나만 있을 때도 palindrome

- Recursion

  - 같 `<palindrome>` 같

    맨앞 맨뒤를 비교하는 수고(overhead)를 거치고나면 자신보다 사이즈 작은 문제를 만남

  ```java
  isPalindrome(w) {
      if (w == empty || w.length == 1) // base case
          return true; 
      else if (w[0] == w[last])
          return isPalindrome(w - w[0] - w[last]);
      else 
          return false;
  }
  ```

  ​


#### 예 2-3. A^n B^n

- 정의

  `{0, 1}^n` = 00111….01011 (n개)

  `A^nB^n` = AAA…AB…BBB (A n개 B n개)

- Base Case
  - empty string

- Recursion
  - A `<L>` B

  ```java
  isAB(w) {
      if (w == empty) 
          return true;
      else if (w[0] == A && w[last] == B)
          return isAB(w - w[0] - w[last]);
      else 
          return false;
  }
  ```

- A `<L>` B `<L>` 도 될까?

  - 두 `<L>`이 길이가 같으리라는 보장이 없다.
  - B의 시작점을 알기 어렵다.



#### 예 2-4. Infix vs Prefix vs Postfix Expression

> 컴퓨터 입장에서는 Postfix가 가장 다루기 편리.
> 특히 Stack과 사용하기 굉장히 편함.

- 셋 중 어떤 expression인지 판단하는 formal grammar

  ```java
  <operator> = + | – | * | /
  <identifier> = a | b | … | z
  ---
  <infix> = <identifier> | <infix> <operator> <infix>		// a+b*c-d
  <prefix> = <identifier> | <operator> <prefix> <prefix> // -+a*bcd
  <postfix> = <identifier> | <postfix> <postfix> <operator> // abc*+d-
  ```

- **recursion for prefix**

  ```java
  isPre(A, 1, n) { // return true if string A[1...n] is prefix form
  	lastChar = endPre(A, 1, n);
      if (lastChar == n) return true;
      else return false;
  }
  endPre(A, first, last) {
      if (first > last) return -1;
      if (A[first] == identifier) return first; // base case
      else if (A[first] == operator) {
          firstEnd = endPre(A, first+1, last);
          if (firstEnd == -1) return -1;
          else return endPre(A, firstEnd+1, last);
      }
      else return -1;
  }
  ```

  => `endPre`를 자세히 살펴보자

  ![Infix Expression](https://user-images.githubusercontent.com/17509651/39055324-e8608afa-44ee-11e8-8ae4-bbbbc8fd8b59.png)

  - endPre(A, 1, 3)	*ab
    - firstEnd 구하러 recursion
      - endPre(A, 2, 3)	ab
    - firstEnd = 2
    - return 하러 recursion
      - endPre(A, 3, 3);	b
    - return 3
  - lastChar = 3이고 n과 같으므로 isPre = true

  ```java
  endPre(A, first, last) {
      if (A[first] == identifier) return first; // base case
      else if (A[first] == operator) {
          firstEnd = endPre(A, first+1, last);
          return endPre(A, firstEnd+1, last);
      }
  }
  ```

- **conversion from prefix to postfix** (2개짜리)

  > 직접적인 position 조작이 아닌 줄여나가는 식으로 변환
  >
  > +<pre><pre> => <pre><pre> => <pre>

  - convert(`*ab`)		ch =`*`, pre = `ab`
    - postfix1 = convert(`ab`)	ch = `a`, pre=`b`   : return  `a` 
    - postfix2 = convert(`b`) 	ch = `b`, pre=empty : return `b`
  - return `ab*`

  ```java
  convert(pre) { // pre = +<pre><pre>
      ch = pre[0]; // +
      pre -= ch; // pre = <pre><pre>
      
      if (ch == identifier) return ch;
      else if (ch == operator) {
          postfix1 = convert(pre); // pre = <pre>
          postfix2 = convert(pre); // pre = empty
          return postfix1 + postfix2 + ch; // concatenation
      }
  }
  ```



---

[from 쉽알]

### 미로 찾기 문제

```java
maze(v) {
    v.visited = YES;
    if (v == T) return "성공";
    for ( each x in L(v) )		// L(v)는 정점 v와 인접한 정점 집합
        if (x.visited == NO) {
            x.prev = v;		// 경로는 T에서부터 prev를 따라가면 S에 이르게 됨
            maze(x);			// 막다른 골목, 즉 T 아닌데 더 이상 L(v) 없으면 알아서 종료 후 새로운 루프 시작
        }
}
```



### 색칠 문제

k개의 색상으로 인접한 정점은 같은 색상이 칠해지지 않도록 그래프(총 n개 정점)를 칠할 수 있는가?

```java
// 정점 i-1까지는 제대로 칠이 된 상태에서 정점 i를 c로 칠하려면 k개의 색으로 충분한가?
kColoring(i, c) { // i:정점, c:color
    if ( valid(i,c) ) {
        i.color = c;
        if (i == n) return true; // 다 칠했을 때
        else {
            result = false;
            d = 1;	// d: color
            while (result == false && d <= k) {
                result = kColoring(i+1, d);
                d++;
            }
        }
        return result;
    } 
    else {return false;}
}

// 정점 i-1까지는 제대로 칠이 된 상태에서 정점 i를 c로 칠하면 이들과 색이 겹치지 않는가?
valid(i, c) {
    for (int j = 0; j < i; j++)
        if ( (i, j) is in E && j.color = c) return false;
    	// 정점 i와 다른 정점 j 사이에 간선이 있다(접했다) && 그 j의 색상이 c로 같다
    return true;
}
```

- 최초에는 kColoring(1,1) 호출 => valid => kColoring(2,1) 호출 

  - kColoring(2,1) => invalid(정점 2와 1 인접 && 같은 색상) => 종료

- kColoring(2,2) 호출

  - kColoring(2,2) => valid => kColoring(3,1) 호출

    - kColoring(3,1) => invalid(정점 3과 1 인접 && 같은 색상) => 종료

  - kColoring(3,2) 호출

    - kColoring(3,2) => valid (정점 3과 2 인접하지 않음 같은 색상 가능) => kColoring(4,1) 호출

      ...



#### 예2-5. Cost of Hanoi Tower

moves(N) = 2*moves(N-1) + 1

```java
move(N, A, B, C) { // n = number of discs
    move (N-1, A, C, B);
}
```











