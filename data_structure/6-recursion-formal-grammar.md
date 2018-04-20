# Ch.6 Recursion - Formal Grammar

> Ch.3보다 심화적으로 Recursion 다룰 것. 아래 두개를 중점으로
>
> 1. BackTracking
> 2. **Formal Grammars**

### 개념

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



#### 예1. Java Identifier - Recursive Routine

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



#### 예2. Palindrome

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


#### 예3. A^n B^n

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



#### 예4. Infix vs Prefix vs Postfix Expression

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
    	 postfix2 = convert(`b`) 	ch = `b`, pre=empty : return `b`
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


