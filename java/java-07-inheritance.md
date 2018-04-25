# 06. Java 복습 - 상속(Inheritance)

### 1. Inheritance 개념

- 한 대의 컴퓨터를 표현하는 클래스를 만들어보자

  ```java
  public class Computer {
    public String manufacturer; // 제조사 삼성, LG...
    public String processor; // i3, i5...
    public int remSize; // REM GB
    public int diskSize; // 하드디스크 GB
    public double processorSpeed; // GHz
    
    public int computePower {
      return remSize * processorSpeed;
    }
  }
  ```

- 이번엔 노트북을 표현하는 클래스를 만들고 싶다

  노트북도 일종의 컴퓨터이므로 Computer가 가진 속성들 그대로 가지면서 거기에 추가적인 속성이 더해질 것.

  ```java
  public class Notebook extends Computer {
    public double screenSize;
    public double weight;
  }

  public static void main(String[] args) {
    Notebook n = new Notebook();
    n.remSize = 2;
    n.processorSpeed = 8;
    System.out.println( n.computePower() ); // 16
  }
  ```

- `extends` - **IS-A 관계**

  - Notebook IS A Computer
  - Computer = **parent / base / superclass** of Notebook
  - Notebook = **child / extended / subclass** of Computer

<br>



### 2. Inheritance & Constructor

- Constructor가 **없을 경우 자동으로 No-parameter Constructor가 생성**된다.

  Constructor가 **하나라도 있을 경우 자동으로 만들어지지 않는다.**

  > 우리가 Term t = new Term() 할 때마다 자동으로 생성된 Constructor가 실행됐던 것

- **모든 subClass의 Constructor는 먼저 superClass의 Constructor를 호출**한다

  - **`super()` 를 통해 내가 명시적으로 호출**해주거나
  - 그렇지 않은 경우에는 **자동으로 No-parameter Constructor가 호출**된다.

  > 흔한 오류 : **superClass에 no-parameter Constructor가 없는데 subClass Constructor에서 `super()` 을 호출해주지 않으면 에러 발생**

  Computer Constructor

  ```java
  public Computer( String manufacturer, String processor, int remSize, int diskSize, double processorSpeed ) {
    this.manufacturer = manufacturer; // 제조사 삼성, LG...
    this.processor = processor; // i3, i5...
    this.remSize = remSize; // REM GB
    this.diskSize = diskSize; // 하드디스크 GB
    this.processorSpeed = processorSpeed; // GHz
  }
  ```

  Notebook Constructor (Error)

  ```java
  public Notebook( double screenSize, double weight ) {
    // Computer에서 상속받은 속성까지 Construct하면 에러남!
    this.screenSize = screenSize;
    this.weight = weight;
  }
  ```

  Notebook Constructor (No Error)

  ```java
  public Notebook( String manufacturer, String processor, int remSize, int diskSize, double processorSpeed, double screenSize, double weight ) {
    super( manufacturer, processor, remSize, diskSize, processorSpeed );
    this.screenSize = screenSize;
    this.weight = weight;
  }
  ```

<br>



### 3. Method Overriding

- 부모로부터 물려받은 method를 내 입맛에 맞게 수정하는 것

  ```java
  // Computer
  public String toString() {
    String result = "manufacturer: " + manufacturer;
    return result;
  }
  ```

  ```java
  // Notebook
  public String toString() {
    String result = "manufacturer: " + manufacturer
      			+ "screensize: " + screenSize
      			+ "weight: " + weight;
    return result;
  }
  ```

- BUT superclass의 data가 **public이 아니라면?**

  - `private` - 물론 타 클래스이긴 하지만 좀 특별한 관계이니깐 될까? Java에선 안된다.
  - `protected` - **subClass에서는 access허용** 

- 따라서 위 코드는 두 가지 문제가 있다

  - 반복적 코드
  - superclass의 data가 private이면 접근 불가

  **`super.toString()` 을 사용해주면 된다**

  ```java
  // Notebook
  public String toString() {
    String result = super.toString() +
      			+ "screensize: " + screenSize
      			+ "weight: " + weight;
    return result;
  }
  ```

<br>



### 4. 다형성 - Polymorphism (중요)

#### superClass type의 variable가 subClass type의 Object를 참조할 수 있다

> superClass type이라는 건 당연히 reference variable.

- 원래 같은 type이어야 한다는 것은 Strong Typing 원칙. 즉 이것은 Strong Typing의 예외.

  - 오로지 super class type이 sub class object를 참조할 때에만 적용된다.

  - 반대로 sub class type이 super class object를 참조하는 것은 불가능.

    `Notebook n = new Computer();` (X)

    ​


- 예: Computer type의 variable `c` 가 Notebook type의 object를 참조하고 있다.

  ```java
  Computer c = new Notebook("Bravo", "Intel", 4, 240, 2/4, 14.7, 5.0);
  ```

  `c` 는 Computer type의 variable이면서 실제로는 Notebook object를 참조하고 있다.

  ​

- Java에서는 항상 **Dynamic Binding**을 한다.

  ```java
  System.out.println( c.toString() );
  ```

  두 Class는 각자의 `toString()` 을 가지고 있다.

  그렇다면 여기서 둘 중 어떤 `toString()` 메서드가 실행될까?

  - 정답은 **Notebook Class의 toString() 메서드**가 실행된다.

    이런 방식을 **동적 바인딩 Dynamic Binding**라고 함.

    > 실제 코드 실행 중 Runtime에 결정을 내릴 때

  - 반면 Computer Class의 toString() 메서드가 실행되면

    그런 방식을 **정적 바인딩 Static Binding**이라고 함.

    > Compiler가 결정을 내리는 입장

  ​

