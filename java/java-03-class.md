# 03. Java 복습 - 클래스, 객체, 참조변수

### 1. Class의 개념과 Syntax

> C의 구조체(structure)를 아주 조금 확장한 동일 개념이다.

- 왜 필요할까?

  - 프로그래밍에서는 여러의 대상이 하나를 가리켜 늘 같이 붙어있어야 하는 경우가 많다. 예컨대 전화번호부 프로그램에서 names와 numbers는 따로 떨어져선 안되는 데이터. 
  - BUT 별개의 변수에 저장을 하게 되면 하나를 swap하기 위해 모든 배열에 일일이 변화를 가해야 한다. 이는 데이터가 많아질수록 더 큰 문제로 이어진다.
  - 따라서 이러한 **서로 관련 있는 데이터들을 하나의 단위로 묶어두는 것**이 **클래스(Class)**라는 개념의 가장 기본적인 필요성이다.

- **사용자정의 Type**

  ```java
  int n; // n이라는 변수에 저장. int에 저장하는 것이 아님.
  Person1 a; // 마찬가지로 Person1은 type일 뿐, 저장은 a라는 객체에 하는 것.
  ```

- Syntax

  > new 까먹지 말자!

  - 선언과 생성

    ```java
    // Classname obj = new Classname(parameters);
    Person1 first; // 객체 선언
    first = new Person1[] // 객체 생성
    Person1 first = new Person1(); // 두 가지 합칠 수 있음

    // .연산자로 field에 접근
    first.name = "John";
    ```

  - 객체가 담긴 배열

    ```java
    // type [] name = new type [length];
    Person1 [] data = new Person1 [100]; // 객체 선언만 된 셈.

    data[0] = first;
    data[1] = new Person(); // 객체 생성은 여기서 따로.
    ```

  ​


### 2. Primitive Type VS Class

```java
int count = 0;

Person1 first = new Person1();
first.name = "John";
```

- primitive type

  - `count`라는 이름의 변수가 만들어진다
  - 그 *안*에 정수값 0이 저장된다.

- Class

  - `first`라는 이름의 변수가 만들어진다
  - name과 number 값이 저장될 Person1 타입 Object는 new 명령을 통해 따로 만들어진다
  - 변수 *안*에는 이 Object의 주소(참조)가 저장된다.
  - name값은 변수가 가리키고 있는 Object의 name이라는 이름의 field에 저장된다.

  > C언어의 포인터와 유사한 개념

  ```java
  Person1 first; // first라는 이름의 변수만을 선언했기 때문에 아직 객체는 생성되지 않고, 변수 first만 만들어진다. 이때 이 변수의 값은 null이다.
  first = new Person(); // new 명령을 통해 객체가 만들어지고 first에 그 주소를 저장한다
  first.name = "John"; // first가 가리키고 있는 Person1 타입 객체의 name이라는 이름의 field에 각각의 데이터를 저장한다.
  ```

<br>

### 3. Class 타입 변수는 참조변수

- Primitive Type인 변수는 **보통 변수**이다
  - 즉, 변수 자체에 데이터가 저장된다.


- Primitive Type이 아닌 모든 변수는 **참조 변수**이다.

  - 즉, 실제 데이터가 저장될 **객체**는 `new` 명령어로 따로 만들어야 하고,

    참조변수에는 그 객체의 주소를 저장한다.

  - 참조변수가 참조하는 객체는 **이름이 없는 객체**이다.

    이 객체가 실제 데이터를 저장할 공간을 가지고 있다.

- 예시

  ```java
  Person first new Person();
  first.name = "John";
  first.number = "000";

  Person second = first; // 이름 없는 객체가 아닌 주소를 copy하는 것
  second.name = "Tom";
  System.out.print(first.name); // Tom

  Person [] members = new Person[100];
  // Person타입 배열. primitive아닌 타입이므로 배열 자체에는 참조변수가 들어있다.
  members[0] = first; // 둘다 참조변수이므로 치환 가능한 것.
  members[1] = second;
  ```

  > first, second, members[0], members[1] 가 가리키는 객체는 오직 하나이다! **객체는 언제나 `new` 명령어에 의해 만들어진다**. new가 한 번 등장했으니 하나 뿐.
  >
  > first  [ 주소 ] ===>			ㅁ ㅡ ㅡ  주소 ㅡ ㅡ ㅡ ㅁ
  >
  > second [ 주소 ] ===>		| name: "John"	   |
  >
  > members[0]- [ 주소 ] ===>	| number: "0000"    |
  >
  > members[1]- [ 주소 ] ===>	ㅁ ㅡ ㅡ ㅡ ㅡ ㅡ ㅡ ㅡ ㅁ
  >
  > ^^
  >
  > members[ members[0]의 주소]

  - first, second, members[0], members[1] 은 모두 참조변수
  - 모두 name = "John"과 number = "000"을 저장하고 있는 이름 없는 객체를 가리킨다.
  - second의 name을 수정하면 second가 가리키던 이름 없는 객체의 name값이 수정된다. 즉 first, members[0], members[1]도 가리키고 있는 그 객체가 수정되는 것이다.

<br>



### 4. 배열을 다시 살펴보자

**Case 1 - Primitive Type형 Array**

```java
int [] numbers = new int[8];
```

- numbers의 type은 int (X) **int형 array** (O)

  따라서 Primitive Type이 *아닌* type을 가진 변수이므로 **배열은 참조변수**이다. 

  즉 numbers 자체는 배열에 들어가는 일련의 데이터의 주소를 저장하는 참조변수이다.

- numbers가 가리키고 있는 일련의 데이터 즉 배열의 원소 값은 primitive type이다.

  즉 numbers에 저장된 주소가 가리키는 곳에 있는 녀석은 다른 곳을 가리키는 주소가 아닌 숫자 자체를 저장하는 일반 변수라는 의미이다.

  > numbers [  주소  ]  ===> [ 0 ].[ 0 ].[ 0 ].[ 0 ].[ 0 ].[ 0 ].[ 0 ].[ 0 ] 각각의 칸은 int type



**Case 2 - Class형 Array**

```java
Person [] members = new Person[8];
```

- **배열은 참조변수**

  즉 members 자체는 배열에 들어가는 일련의 데이터의 주소를 저장하는 참조변수

- members가 가리키고 있는 일련의 데이터 즉 **배열의 원소 값도 참조변수**이다.

  이 칸은 name, number값을 직접 저장할 수 없다.

  name, number값을 저장할 **객체**는 `new` 명령어를 통해 따로 생성하고, 각 칸에는 **이 객체의 주소를 저장**하는 것이다.

  > members [ 주소 ] ===>  [   ].[   ].[   ].[   ].[   ].[   ].[   ].[   ] 각각의 칸은 Person type 즉 참조변수. 이 칸들도 각각 다른 객체를 가리킨다.
  >
  > ===> [ name: "", number: ""]



#### 값에 의한 호출: 배열은 과연 예외였을까?

> method 파트에서 가져온 내용 복습!

- **창조에 의한 호출**
  - C 또는 Java는 미지원.
  - C++에서는 formal parameter의 type과 변수명 사이에 `&` 기호를 넣으면 창조에 의한 호출이라는 표시. 동일한 변수인데 이름만 다르게 됨.


- **값에 의한 호출(Call by Value)** - C와 같은 규칙

  ```java
  // 호출문 - actual parameter
  swap(data[j], data[j+1]);

  // 호출된 메서드 - formal parameter
  public static void swap(int a, int b){
    int tmp = a;
    a = b;
    b = tmp;
  }
  // 결과는 swap 실패 
  ```

  - **Primitive Type의 매개변수**는 호출된 메서드에서 값을 변경하더라도 호출한 쪽에 영향을 주지 못함
    - 호출문의 actual parameter와 메서드 매개변수인 formal parameter는 메모리 상에서 전혀 다른 영역을 차지하는 *별개의 변수*이다. 
    - 다만 호출이 실행되는 순간, **actual parameter의 값이 formal parameter로 복사**가 이루어지는 것. **두 변수의 관계는 이 한 번의 복사가 끝.**
    - 따라서 위 코드에서 정렬은 제대로 이루어지지 않음. 복사본을 정렬한 것이지, actual parameter를 정렬한 것이 아니기 때문.

  ```java
  // 호출문 - actual parameter
  bubbleSort(data, count);

  // 호출된 메서드 - formal parameter
  public static void bubbleSort(int [] arr, int n) {
    for (int i=n-1; i>0; i--) {
      for (int j=0; j<i; j++) {
        if (arr[j] > arr[j+1]) {
          int tmp = arr[j];
          arr[j] = arr[j+1];
          arr[j+1] = tmp;
        }
      }
    }
  }
  ```

  - **Primitive Type이 아닌 변수**, 예컨대 배열의 값은 호출된 메서드에서 변경하면 호출한 쪽에서도 변경된다.
    - 값에 의한 호출의 예외일까? 그렇지 않다. 단지 **복사의 대상이 데이터 자체가 아니라 데이터를 가리키는 '주소' 즉 참조변수**였을 뿐.
    - 배열은 `new` 명령어에 의해 생성되지, 복사된 formal parameter는 배열을 생성하는 것이 아니다. 배열은 하나 뿐. 가리키는 곳이 두 개가 된 것.
    - 배열의 주소를 담은 data(actual parameter) 변수가 **값에 의한 호출**에 의해 arr(formal parameter) 변수로 복사되면서, arr 또한 같은 주소의 동일한 배열을 가리키게 된다.
    - 따라서 arr이 가리키는 배열을 수정하면, data가 가리키는 곳이 변경이 되는 것이다.

<br>



### 예제

- `new`를 통한 생성 까먹지 말자

  ```java
  import java.io.File;
  import java.io.FileNotFoundException;
  import java.util.Scanner;

  public class Code1 {

      static Person [] members = new Person[100]; // 배열 생성 까먹지 말 것. 참조변수만 있을 땐 데이터 넣을 수 없음 PointerError
      static int n = 0;

      public static void main( String [] args ) {
          // members = new Person[100];

          try {
              Scanner in = new Scanner(new File("input.txt"));

              while( in.hasNext() ) {
                  String nm = in.next();
                  String nb = in.next();

                  members[n] = new Person(); // 객체 생성 까먹지 말 것. 참조변수만 있을 땐 데이터 넣을 수 없음 PointerError
                  members[n].name = nm;
                  members[n].number = nb;
                  n++;
              }

              in.close();
          } catch (FileNotFoundException e) {
              System.out.println("No File Found");
          }

          for (int i=0; i<n; i++) {
              System.out.println(members[i].name + " " + members[i].number);
          }
      }
  }
  ```





2-1 클래스, 객체, 참조변수 (17)

- 31
- 45
- 59

2-2 메서드와 생성자 (18)

- 45
- 46
- 56

2-3 Static & Public (19, 21)

- 39
- 28

3-1 Inheritance (23)

- 41
- 17
- 46

3-2 예제  (스케줄러)

- 16
- 60

3-3 Class Object & Wrapper Class (24)

- 52

3-4 Abstract Class & Interface (24, 25)

- 41
- 38
- 44
- 14

3-5 Generic Programming & Generics (26)

- 33
- 50
- 12





