# 03. Java 복습 - Method & Constructor

### 1. Class Methods

- Class = Struct?

  - 하나의 대상을 표현하는 서로 관련 있는 데이터들을 하나의 단위로 묶어두는 것이 **클래스(Class)**라는 개념의 가장 기본적인 필요성이다.

    그렇다면 C의 struct(구조체)와 동일한가?

  - 아니다. 이것이 전부가 아니다.

    **서로 관련있는 데이터**만을 멤버로 가질뿐만 아니라, **그 데이터와 연관성이 깊은 Method(함수)**도 함께 묶어둘 수 있다. 

  - 이로써 응집도(cohesion)을 높이고 결합도(coupling)을 낮출 수 있다.

    - 응집도 : 친한 애들 끼리 한 방에
    - 결합도 : 방 간의 교류는 적어지게 됨 (타 클래스 상호의존성)

- 예

  ```java
  // in Polynomial Program
  class Term {
    int coef;
    int expo;
  }

  class Code04 { // 아래 두 메소드는 class Term과 긴밀. Term 안으로 옮길 수 있다.
    static void printTerm(Term t) {
    	System.out.println(t.coef + "x^" + t.expo);
    }
    static int calcTerm(Term t, int x) {
      return t.coef * Math.pow(x, t.expo);
    }
    static int calcPolynomial(Polynomial p, int x) {
      int result = 0;
      for (int i=0; i<nTerms; i++)
        result += calcTerm(p.terms[i], x);
      return result;
    }
  }
  ```

  ```Java
  // after
  class Term {
    int coef;
    int expo;
  }
  // 1. 이제 Term을 매개변수로 받을 필요 없이 자기 자신이 속한 항을 대상으로 하면 된다.
  // 2. static이 사라진 것은 다음 절에서.
  void printTerm() {
    System.out.println(coef + "x^" + expo);
  }
  int calcTerm(int x) {
    return t.coef * Math.pow(x, expo);
  }

  class Polynomial {
    public int calcPolynomial(int x) {
      int result = 0;
      for (int i=0; i<nTerms; i++)
        result += terms[i].calcTerm(x);
      return result;
    }
  }
  ```

- But 여전히 클래스 참조변수 객체의 관계는 유지된다

  - **class**는 허상. 설계도일 뿐. 그 안에 있는 printTerm, calcTerm도 허상.

  - 이러한 메소드를 쓰려면 **object**를 만들어야 한다.

    각각의 객체 안에 마치 coef, expo가 하나씩 있는 것 처럼 이 안에 두 개의 메서드도 존재.

  - 우리가 실행하는 것은 **class가 아니라 각각의 object 안에 있는 메서드**이다.

  ```java
  Term t = new Term();
  t.coef = 3;
  t.expo = 2;
  int result = t.calcTerm(2);
  t.printTerm();
  ```

- **`toString` 메서드는 특별한 이름**

  다른 이름으로 바꾸지 말고 `toString`으로 짓자. 이유는 나중에.

  ```java
  public String toString() {
    return "(" + lu.x + ", " + lu.y + ") " + width + " " + height;
  }

  for (int i=0; i<n; i++)
    System.out.println( rects[i].toString() ); // abstraction
  ```

  ​


<br>



### 2. Object?

- 정의: 객체란 **데이터 + 메서드**

  - 데이터는 객체의 '정적 속성'
    - 자전거 - 모양, 무게, 브랜드
    - Term - 계수, 차수
  - 메서드는 객체의 '동적 속성(기능)'
    - 자전거 - 달린다, 정지한다, 후진한다
    - Term - 화면에 출력해준다, x값을 주면 자신의 값을 계산해준다


<br>



### 3. Constructor

> Class가 가진 Methods 중 특별한 녀석이 있다

- 개념

  - 생성자(Constructor)란,
    - **클래스와 동일한 이름**을 가지며
    - **return type이 없는 메서드**

    로 `new` 명령어로 **객체를 생성할 때 자동으로 실행**된다.

  - 주 목적 = 객체의 데이터 필드의 값을 **초기화**

- 예

  ```java
  // before
  term t = new Term();
  t.coef = 3;
  t.expo = 2;

  // after
  Term t = new Term(3, 2);

  // by Constructor
  class Term {
    int coef;
    int expo;
    public Term(int c, int e) {
      coef = c;
      expo = e;
    }
  ```

- 생성자가 반드시 매개변수를 받아야하는 것은 아니다.

  - 예컨대 무조건 0으로 초기화할 때
  - 혹은 배열을 생성할 때

  ```java
  // Zero Parameter Constructor
  class Polynomial {
    int nTerms;
    int Term [] terms; // 참조변수만 선언
    public Polynomial() { // 매개변수는 없지만
      nTerms = 0; // 0으로 초기화
      terms = new Term[100]; // 참조변수가 가리킬 배열을 생성함
    }
  }
  ```

- 생성자를 여러 개 만들 수 있다

  ```java
  class Polynomial {
    char name;
    int nTerms;
    int Term [] terms; // 참조변수만 선언
    public Polynomial() { // 매개변수는 없지만
      nTerms = 0; // 0으로 초기화
      terms = new Term[100]; // 참조변수가 가리킬 배열을 생성함
    }
    public Polynomial(char nm) {
      name = nm; // name값은 받아서 설정할 수 있음
      nTerms = 0;
      terms = new Term[100];
    }
  }
  ```

- `this`로 이름 충돌을 해결할 수 있다.

  ```java
  public Polynomial(char name) {
      this.name = name; 
    // 전자는 this 객체의 name, 후자는 scope상 더 가까운 name
      nTerms = 0;
      terms = new Term[100];
    }
  ```

- Scanner에서 바로 넣어줘도 오케이

  ```java
  // ver 2
  x = sc.nextInt();
  y = sc.nextInt();
  z = sc.nextInt();
  w = sc.nextInt();
  rects[n] = new Rectangle(x,y,z,w);
  n++;

  // ver 3
  rects[n++] = new Rectangle( sc.nextInt(), sc.nextInt(), sc.nextInt(), sc.nextInt());
  ```


<br>



### 4. 사용 시 장점

응집도 상승 / 결합도 하락

- 코드 간결화

- 수정 편리

  - 어떤 이유로 Rectangle이 시작점좌표,width, height가 아닌 두 꼭지점의 좌표만으로 결정되어야 한다면?

    이제 Rectangle 클래스만 바꿔주면 끝.