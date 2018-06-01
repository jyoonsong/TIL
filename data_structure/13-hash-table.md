# Ch.13 Hash Table

### 0. 배경

- 색인 계열이 아닌 자료구조

  - Stack, Queue, Priority Queue 는 indexing을 안하고 맨앞/맨뒤/우선순위큰놈 가져온다.

- 색인 계열의 자료구조

  - Array

  - Linked List

  - Binary Search Tree : `log n ~ n`

  - Balanced Binary Search Tree : `log n` 보장

  - Balanced K-ary Search Tree : `log n` 보장. 이때 **log의 밑**을 키워서 값을 줄일 수 있다.

    > 그럼에도 불구하고 **n은 커진다**. 
    >
    > 실제적으로 10억개 정도를 인덱싱한다고 할 때는 첫 몇 개 레벨은 메모리에 올려 놓고 쓸 수 있고, 마지막 레벨만 인덱싱하면 됨.

  - 그래서 나온 게 **Hash Table** 

---

### 1. 개념

- 정의

  - Hash Table은 원소가 저장될 자리가 원소의 값에 의해 결정되는 자료구조
  - Address Calculator역할을 하는 Hash Function을 통해 해시값을 찾는다. 즉 **비교가 아닌 계산**을 통해 자리를 결정.

  ![image](https://user-images.githubusercontent.com/17509651/40581885-f18f2e02-619e-11e8-98b0-2c4baa6384c9.png)

  ```diff
  + 그토록 빠른 search, deletion, insertion
  - finding minimum/maximum element은 지원X
  - 충돌(collision) : 충돌만 없으면 환상적인 자료구조인데, 이 충돌이 비효율을 초래한다.
  > 따라서 모든 경우에 매력적인 자료구조는 아니다. 아주 빠른 응답 요구되는 경우에 적절.
  예: 119 긴급 전화, 항공사 고객 상담 시스템, 주민등록 시스템
  ```

---

### 2. Hash Function

- 2가지 성질

  - 입력 원소가 Hash Table 전체에 고루 저장되어야 한다. (중요. 충돌 확률 작아지기 때문.)
  - 계산이 간단해야 한다. (대체로 자연스럽게 만족함)

- Methods

  - Toy Functions

    - selection digits `h(001364825) = 35` 
    - folding `h(001364825) = 1190`

  - **Modulo Arithmetic**

    `h(x) = x % tableSize` 

    - 테이블 크기보다 큰 수를 해시 테이블 크기 범위에 들어오도록 수축시킨다.

    - **tableSize는 되도록 소수** 왜?

      만약 tableSize = 2^p이면 입력 원소의 **하위 p개 비트에 의해 해시값이 결정**되므로 해시값을 분산시키기에 그리 이상적이지 않다.

      해시값은 입력 원소의 모든 비트를 이용하는 것이 확률적으로 좋은 분포를 갖기에 유리.

      > 예: 1601은 2^10과 2^11에 근접하지 않은 소수 중 하나

  - **Multiplication Method**

    `h(x) = (xA % 1) * tableSize` 

    - 입력값을 먼저 소수(0~1)로 대응시킨 후, 해시 테이블 크기 범위에 들어오도록 팽창시킨다.

      > 1) x에 A를 곱한 다음 소수부만 취한다 
      > 2) 방금 취한 소수부에 tableSize를 곱하여 그 정수부를 취한다.

    - **0 < A < 1의 상수 A**가 해시값 분포에 큰 영향

      > 크누스는 잘 작동하는 A값으로 (루트5-1)/2 를 제안.

    - **tableSize는 아무렇게나 잡아도 상관 없다**

      컴퓨터의 이진수 환경에 맞게 2^p로 잡는 것이 자연스럽다.

---

### 3. Collision Resolution

한 주소를 놓고 두 개 이상의 원소가 자리를 다투는 것

- **[1] Separate Chaining**

  - Each table[i] is maintained by 별도의 공간 (전형적: Linked List)
    - Hash Table 크기가 m이면 최대 m개의 linked list

    ```diff
    + 적재율이 1을 넘어도 사용할 수 있다
    + 애당초 충돌이 일어날 놈들끼리 모으기 때문에 상관 없는 놈과의 비효율 발생 안함.
    - 다른 공간을 준비하는 overhead로 지저분해진다. 필드에선 보통 사용 안 하고 사용하더라도 변형하여 사용함. 
    ```

  - Implementation

    - 검색/삭제: T[h(x)]에 매달린 Linked List에서 x를 검색/삭제

    - 삽입: T[h(x)]에 매달린 Linked List의 **맨 앞에 삽입**

      > 맨 앞이 아닌 다른 자리에 삽입하는 경우, 평균적인 검색 시간은 동일하지만
      >
      > **삽입 비용이 더 들기** 때문에 효율성 면에서 손해다

- **[2] Open Addressing**

  - 순차적인 해시 함수
    - 해시 함수 계산값 h(x) 혹은 h0(x) 를 찾는다. 충돌 없으면 그 자리에 넣는다.

    - 충돌 시, 정해진 규칙에 의해 다음 자리를 찾는데, 빈 자리를 찾을 때까지 계속 찾는다.

      즉 h(x) = h0(x), h1(x), h2(x) … 이런 식으로 표현 가능

      > 이때 다음 자리를 찾는 방법이 다양. 아래 3가지

    ```diff
    + 추가 공간을 허용하지 않고, 어떻게든 주어진 테이블 공간에서 해결. 따라서 모든 원소가 반드시 자신의 해시값과 일치하는 주소에 저장된다는 보장이 없음.
    - 자신과 상관 없는 놈(원래 딴 데 가야 하는데 밀려서 온 놈)때문에 비효율 발생하곤 함.
    ```

  - *"다음 자리를 찾는 방법"*

    > Quadratic만 해도 실용적으로 괜찮은데, Double Hashing까지 하면 거의 나무랄 데 없다고 봐도 됨.

    1. **Linear Probing**

       `hi(x) = (h0(x) + i) % tableSize` (i의 자리가 ci+d 형태)

       충돌이 일어난 바로 뒷자리를 보는 것 

       - 문제: **Primary Clustering** (1차 군집)

         특정 영역에 원소가 몰릴 때 (딱 달라 붙어 있음)

    2. **Quadratic Probing**

       `hi(x) = (h0(x) + i^2) % tableSize` (i^2의 자리가 ci^2 + di + e 형태)

       보폭을 이차함수에 의해 넓혀가며 본다.

       - 해결: 보폭이 점점 넓어지므로 Primary Clustering 쉽게 벗어날 수 있음

       - 문제: **Secondary Clustering** (2차 군집)

         여러 개의 원소가 **동일한 최초 해시 함수값**을 갖는 경우 모두 같은 순서로 조사할 수밖에 없어 넓어지는 보폭의 이득을 보지 못하고 비효율적.

    3. **Double Hashing**

       `hi(x) = (h(x) + i*h'(x)) % tableSize`

       두 개의 Hash Function h, h'을 사용한다. h값이 같아도 h'까지 같을 확률 매우 낮음.

       > 보폭까지 h와 관련 있게 매핑. 

       - **소수 m보다 조금 더 작은 소수 m'** (m = tableSize)

         `h(x) = x % m` <=>  `h'(x) = x % m'` (예: m=1601, m'=1597)

       - **두 번째 해시 함수 값 h'(x)는 테이블 크기 m과 서로소이어야 함**

         h'(x)와 m이 1보다 큰 최소공약수 d를 가지면 x의 자리를 찾기 위해 Hash Table 전체 중 기껏해야 1/d, 즉 `m/d번`밖에 보지 못하게 된다.

         > 예컨대 h'(x) = f(x) = dk, m = dl이라 하자. (k, l은 양의 정수)
         >
         > hi(x) = (h(x) + if(x)) % m 일 때, 
         > i번째 조사에서는 h(x)에서 if(x)만큼 점프하고, l번째 조사에서는 lf(x)만큼 점프하는데 lf(x) = ldk = km 이 되어 m의 배수이므로 h(x) 자리와 일치하게 된다.
         >
         > 그러므로 기껏해야 l번, 즉 m/d번밖에 조사하지 못한다. 

---

### 4. Load Factor

- 정의: Hash Table에 원소가 차 있는 비율

- `α = n / m` = Load Factor = 적재율

  - `n` = **저장된 원소의 총수**
  - `m` = **해시 테이블의 크기**

- 적재율은 **충돌의 확률**. Hash Table의 성능에 중요한 영향을 미침.

  > 얼마나 긴급한 답변을 요구하는가에 따라서 적재율에 대한 threshold를 미리 정해두곤 함.

---

### 5. Implementation

- **Insertion**

  ```java
  tableInsert(x) { // A: hash table, x: new key to insert
      if (A[h(x)] is not occupied)
          A[h(x)] = x;
      else {
      	int i = find appropriate index by collision resolution method;
          A[i] = x;
      }
  }
  ```

- 

