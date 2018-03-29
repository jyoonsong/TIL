# 05. Java 복습 - Static & Public

### 1. `static`의 개념

- **Class는 Type**이다. 집이 아니라 집의 설계도이다.

- 해당 Class를 Type으로 가지는 **Object**를 만들어야, 

  그 객체에 데이터를 저장하고, 그 객체의 멤버 메서드를 실행하는 것이다.

- 그러나 여기에는 하나의 **예외**가 존재한다. 그것이 바로 `static` 멤버!

  **`static` 멤버는 클래스 안에 실재로 존재하며 객체에는 존재하지 않는다.**

```java
public class Test {
  public static int s = 0;
  public int t = 0; // 허상
  
  public static void printS() {
    System.out.println("s = " + s);
  }
  public void printT() { // 허상
    System.out.println("t = " + t);
  }
}

Test test1 = new Test(); // test1이라는 객체가 t와 printT를 가지고 있다
test1.t = 100;
test1.printT;
```

- 즉 **`static` 멤버는 class 멤버**이고 **non-static 멤버는 object 멤버**이다.

<br>



### 2. `static` - 다시 짚어보자

- 왜 **main 메서드**는 반드시 `static`이어야 하는가?

  - Java의 프로그램은 결국 순수하게 Class의 집합. 

    = Class 외엔 아무것도 없다.

  - C++은 어떤 Class에 속하지 않는 변수/함수가 존재. 

    더구나 main은 어디에도 속하면 안됨

  - 따라서 main 조차도 Java에서는 Class 안에 들어가야 함.

    그런데 main이 허상이라면 어떤 일도 어떤 메서드 실행도 할 수 없게 됨. Java 프로그램이 통째로 허상이 되는 셈.

    그러므로 main은 static.

- 왜 **static 메서드에서는 다른 Class의 non-static 멤버(변수/메서드)를 액세스 할 수 없는가**

  위 Test 코드에서 `printS` 안에서 `t`를 불러오면 에러 남.

  - Class멤버 `printS` 가 동 Class 멤버 `s` 를 access => 가능

  - Object멤버 `printT` 가 동 Object 멤버 `t` 를 access => 가능 

    > 왜? 둘다 허상이라서

  - Class멤버 `printS`가 Object 멤버 `t` 를 access => **불가능**

    > 왜? 허상이니깐

  - Object멤버 `printT` 가 Class 멤버 `s` 를 access => 가능

- **다른 Class에 속한 static 멤버**는 어떻게 접근하는가?

  ```java
  public static void main(String[] ar) {
    Test test = new Test();
   
    test.t = 10;
    Test.s = 10; // 올바른 표현
    test.s = 100; // 에러는 안나지만 올바른 표현 아님
    test.printT(); // 10
    
    Test test2 = new Test();

    test2.printT(); // 0
    test2.printS(); // 100 객체와 무관. 에러는 안나지만 올바른 표현 아님.
    Test.printS(); // 100 올바른 표현
  }
  ```

<br>



### 3. `static` Method/Field의 용도

- Data

  - 상수값 혹은 Class 당 하나만 유지하고 있으면 되는 값/객체

    `Math.PI` (3.145…) `System.out`

- Methods

  - `main` Method

  - 순수하게 기능만으로 정의되는 Method (별로 없음) 어딘가 하나만 있으면 됨

    수학 함수들 `Math.abs(k)` `Math.sqrt(n)` `Math.min(a,b)`

> main 메서드만 static이 되도록 static을 최소화하며 프로그래밍하도록 하자.

- how?

  `main`은 아주 간단하고 abstraction 되어 있게.

  모든 것은 static을 사용하지 말고 Object를 생성하여 쓰도록 노력한다.

  ```java
  public static void main(String[] args) {
    // ver 1
    Code4 app = new Code4();
    app.processCommand();
    // ver 2
    (new Code4()).processCommand();
  }
  ```

<br>