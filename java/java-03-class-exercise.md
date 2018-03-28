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



### 5. 정리

- Class : 허상. 설계도.
- Object: 실체. 설계도를 따라 만들어진 실제 집.
- Reference Variable: Object를 가리키는 주소를 담는 변수.

```java
// Class
public class Person {
  int age;
  String name;
}

// Object & Reference Variable
Person p = new Person();
a.age = 25;
a.name = "Eric";
```



![Object 와 Reference Variable](http://www.hacktrix.com/wp-content/uploads/2013/05/object-reference0.png)





### 6. C vs Java

| 구분                |             | C                                        | Java                                     |
| ----------------- | ----------- | ---------------------------------------- | ---------------------------------------- |
| Primitive Type    | 보통 변수       | int a = 10;<br />char ch = 'x';          | int a = 10;<br />char ch='x';            |
| ex. int, double.. | 참조 변수 (포인터) | int *p;<br />char *q;                    | X                                        |
| 사용자 정의 Type       | 보통 변수       | struct person a;<br />a.name = "John";<br />a.number = "000"; | X                                        |
| ex. 구조체, class..  | 참조 변수 (포인터) | struct person *a;<br />a = malloc(sizeof(…));<br />a->name = "John";<br />a->number = "000"; | Person b;<br />b = new Person();<br />b.name = "David";<br />b.number = "000" |

```c
// Primitive Type 포인터
int *p;
char *q; 
// Java와 달리 각 타입마다 참조변수가 존재하므로, 보통변수와 구분지어줄 * 기호가 필요하다

// Non-primitive Type 포인터
struct person *a; // Person b;
a = malloc(sizeof(...)); // b = new Person();
a->name = "John";
// Java와 달리 각 타입마다 참조변수가 존재하므로, 보통변수에 쓰이는 .연산자와 구분지어줄 ->연산자가 필요하다
```

<br>





### 7. 예제

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

- 평면상에 좌표축에 평행한 n개의 직사각형에 관한 데이터를 입력받은 후, 면적이 작은 것부터 큰 것 순으로 정렬하여 출력하는 프로그램을 작성하라.

  - 입력 파일의 형식

    ```java
    // Data.txt
    0 1 2 4 // 왼쪽 위 꼭지점의 좌표가 (0,1)이고, 너비가 2, 높이가 4인 직사각형
    1 4 7 8
    4 3 12 9
    8 18 11 30
    5 10 6 11
    ```


  - 기하학적 문제는 **좌표**에서 시작. 

    좌표의 하나의 점을 정의하는 데이터는 항상 붙어다니는 따로 떨어져서는 안되는 데이터.

    => 하나의 점을 정의하는 **Class**를 이용하자.

    ```java
    public class MyPoint {
        public int x;
        public int y; // 사실은 실수가 더 적절. 편의상 일단은 int
    }
    ```

  - 직사각형을 표현하는 **Class**도 정의해보자

    ```java
    public class MyRectangle {
        public MyPoint lu;
        public int width;
        public int height;
    }
    ```

  - input을 입력받아 저장할 자료구조(변수)를 선언한다.

    > 정렬 함수 등에 일일이 매개변수로 넘겨주는 번거로움을 피하기 위해 main 함수 외부에 static 변수로 만든다.

    ```java
    static MyRectangle [] rects = new MyRectangle[100];
    static int n = 0; // 사각형의 개수
    ```

  - input을 입력받는다

    ```java
    try {
      Scanner in = new Scanner(new File("data.txt"));

      while ( in.hasNext() ) {
        rects[n] = new MyRectangle();
        rects[n].lu = new MyPoint(); // MyPoint도 참조변수!

        rects[n].lu.x = in.nextInt();
        rects[n].lu.y = in.nextInt();
        rects[n].width = in.nextInt();
        rects[n].height = in.nextInt();

        n++;
      }

      in.close();
    } catch (FileNotFoundException e) {
      System.out.println("No File Found");
      System.exit(1);
    }
    ```

- 객체에 여러 field가 있어도 마찬가지로 참조변수만 한 번 바꿔주면 해결 끝.

  ```java
  private static void bubbleSort() {

          for (int i=n-1; i>0; i--) {
              for (int j=0; j<i; j++) {
                  if ( members[j].name.compareToIgnoreCase( members[j+1].name ) > 0 ) {
                      Person tmp = members[j];
                      members[j] = members[j+1];
                      members[j+1] = tmp;
                  }
              }
          }
      }
  ```

- 다항함수(polynomial)는 **항(term)**들의 합이며 항은 **계수(coefficient)와 지수(exponent)**에 의해서 정의된다. 계수는 0이 아닌 정수이고 지수는 음이 아닌 정수라고 가정한다.

  - 실행 프롬프트

    ```bash
    $ create f	 // 다항함수 f=0을 정의
    $ add f 2 3  // f(x)에 2x^3을 더한다. f=2x^3
    $ add f -1 1 // f(x) = 2x^3 - x
    $ add f 5 0  // f(x) = 2x^3 - x + 5
    $ add f 2 1  // f(x) = 2x^3 - x + 5 + 2x = 2x^3 + x + 5
    $ calc f 2	 // f(2) = 23을 출력
    23
    $ print f	 // 차수에 관한 내림차순으로 정렬하여 다음과 같이 출력한다
    2x^3 + x + 5
    $ create g 	 // 다른 다항함수 g를 정의
    ...
    $ exit
    ```

  - 하나의 항을 어떻게 표현할 것인가?

    ```java
    public class Term {
      public int coef; // 계수
      public int exp; // 지수
    }
    ```

  - 하나의 함수를 어떻게 표현할 것인가?

    - **배열을 정의하면, 항상 배열 안 원소의 개수 변수를 함께 정의해줄 것**

  - 이제 프로그램을 작성해보자.

    **Scanner `nextChar`는 제공하지 않음.**

    - int, String 등은 대부분 공백 기준으로 자르는데, char의 경우 공백(whitespace) 또한 char이기 때문.

<br>











