# 01. Java 복습 - 메서드

### 1. 메서드 개념

- **의미** - Java에서의 함수. *프로그램의 기능적 분할 => 구조화된 프로그래밍(structured programming)*

  > 프로젝트, 패키지, 클래스, 메소드 등 이름 바꿀 땐 늘 Refactor 사용

- **형태** - 한 종류의 값만 return할 수 있다. 예컨대 리턴 타입을 int로 해놓고 void처럼 아무 값도 리턴 안 해서는 안됨.

  ```java
  // 호출
  int result = power (a,b);
  // 선언
  static int power ( int n, int m ) {
    return result;
  }
  ```




<br>



### 2. 종료

- **return** - 반환과 종료 두 가지 기능. 아웃풋을 리턴한다는 것은 그 즉시 *해당 메소드를 종료*시킨다는 의미.

  ```java
  static void bubbleSort( int [] arr ) {
    return; // void이므로 사실 있으나마나
  }
  public static void main(String[] args) {
    catch (FileNotFoundException e) {
      return; // main함수에서는 프로그램 종료
    }
  }
  ```

- **System.exit(status)** - main이든 어디에서든 프로그램 종료.

  ```java
  System.exit(0); // 정상적 종료
  System.exit(0 이외의 값); // 비정상적 종료 (에러)
  ```

  ​

<br>



### 3. 메서드 호출

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
  ```

  - **프리미티브 타입의 매개변수**는 호출된 메서드에서 값을 변경하더라도 호출한 쪽에 영향을 주지 못함

    호출문의 actual parameter와 메서드 매개변수인 formal parameter는 메모리 상에서 전혀 다른 영역을 차지하는 *별개의 변수*이다. 

    다만 호출이 실행되는 순간, actual parameter의 값이 formal parameter로 *복사*가 이루어지는 것. 두 변수의 관계는 이 한 번의 복사가 끝.

    따라서 위 코드에서 정렬은 제대로 이루어지지 않음. 복사본을 정렬한 것이지, actual parameter를 정렬한 것이 아니기 때문.

  - **프리미티브 타입이 아닌 변수**, 예컨대 배열의 값은 호출된 메서드에서 변경하면 호출한 쪽에서도 변경된다.

- **창조에 의한 호출**

  - C 또는 Java는 미지원.


  - C++에서는 formal parameter의 type과 변수명 사이에 `&` 기호를 넣으면 창조에 의한 호출이라는 표시. 동일한 변수인데 이름만 다르게 됨.




<br>



### 4. 파일 입력

- **위치** - Project 바로 안에 넣지 않으면 절대/상대 경로 지정해줘야 함.

- **방법**

  - `Unhandled exception type: FileNotFoundException`

    파일이 없는 경우에 어떻게 해줄 것인지 예외 처리를 지정 안해놨다(unhandled)는 경고 에러. C에는 이런 메커니즘이 없이 전적으로 프로그래머 맘에 맡김. Java는 좀더 엄격히 *예외처리(exception handling)*를 중시함.

  - 해결책 - `try - catch` 문

    ```java
    int count = 0;
    String [] name = new String [1000];
    String [] number = new String [1000];
    // 전화번호에 보통 대쉬가 포함된 경우도 많으므로 int로 받는 것은 좋지 않음

    try {
      Scanner inFile = new Scanner( new File("input.txt") );
      while ( inFile.hasNext() ) { // Detect end of File
        name[count] = inFile.next();
        number[count] = inFile.next();
        count++;
      }
      inFile.close();
    } catch (FileNotFoundException e) {
      System.out.println("No File");
      System.exit(9);
    }
    ```




<br>

### 

### 5. 예제

- **2차원 배열에서 소수 찾기**

  입력으로 n*n 개의 음이 아닌 한자리 정수가 그림과 같이 주어진다. 이 정수들 중 가로, 세로, 대각선의 8방향(역방향 포함)으로 연속된 숫자들을 붙여서 만들 수 있는 모든 소수를 찾아서 나열하는 프로그램을 작성하라. 중복된 수를 출력해도 상관없다.

  **2차원 배열 입력받기**

  ```java
  public class MethodPractice {
  	static int n;
  	static int [][] grid;

  	public static void main(String[] args) {
        try {
  		Scanner inFile = new Scanner(new File("data.txt"));
  		n = inFile.nextInt();
  		grid = new int [n][n];
  		for (int i=0; i < n; i++) {
  			for (int j=0; j < n; j++)
  				grid[i][j] = inFile.nextInt();
  		}
  		inFile.close();
  ```

  **브레인스토밍**

  모든 가능한 수열에 대해서	=> 고민의 핵심 (computeValue, getDigit에게 미루자)
  정수값으로 환산하라			=> 10* 반복문
  만약 그것이 소수이면 출력	=> isPrime

  ```java
        for (int x=0; x<n; x++) {
          for (int y=0; y<n; y++) {
            for (int dir=0; dir<8; dir++) {
              for (int length=1; length<=n; length++) {
                // 전체 골격을 만들기 위해 함수에게 떠넘겨라
                int value = computeValue(x,y,dir,length);
                // (4,4),3,4와 같이 존재하지 않는 수열 방지
                if (value != -1 && isPrime(value))
                  System.out.println(value);
              }
            }
          }
        }
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }
  }
  ```

  **computeValue**

  - **인풋**

    하나의 수열은 (시작점, 방향, 길이) 에 의해서 정의된다. 
    시작점: (x, y) 각각 n개 / 방향: 0 ~ 7 / 0 < 길이 < n

  - **아웃풋**

    getDigit 값이 존재하지 않으면 -1을 반환하도록 만들자

  - **내부로직**

    ```java
    public static int computeValue(int x, int y, int dir, int leng) {
      int value = 0;
      for (int i=0; i<leng; i++) {
        int digit = getDigit(x,y,dir,i); // 수열 각 원소를 가져온다
        if (digit == -1)
          return -1;
        value = value*10 + digit; // 수열을 정수로 환산
      }
      return value;
    }
    ```

  **getDigit**

  - **인풋**

    (x,y)에서 dir 방향으로 i만큼 떨어진 value
    시작점: (x,y) / 방향: 0~7 / 0 < 수열에서의 원소 index < n

  - **아웃풋**

    존재하지 않으면 -1을 반환하도록 만들자

  - **내부로직**

    ```java
    static int getDigit(int x, int y, int dir, int i) {
      int newX = x, newY = y;
      switch(dir) {
        case 0: newY+=i; break;
        case 1: newX+=i; newY+=i; break;
        case 2: newX+=i; break;
        case 3: newX+=i; newY-=i; break;
        case 4: newY-=i; break;
        case 5: newX-=i; newY-=i; break;
        case 6: newX-=i; break;
        case 7: newX-=i; newY+=i; break;
      }
      if (newX < 0 || newX >= n || newY < 0 || newY >= n)
        return -1;
      return grid[newX][newY];
    }
    ```

    좀더 단순화하면

    ```java
    static int [] offsetX = {0, 1, 1, 1, 0, -1, -1, -1};
    static int [] offsetY = {-1, -1, 0, 1, 1, 1, 0, -1};
    public static int getDigit(int x, int y, int dir, int i) {
    		int newX = x + offsetX[dir]*i;
    		int newY = y + offsetY[dir]*i;
    		if (newX < 0 || newX >= n || newY < 0 || newY >= n)
    			return -1;
    		return grid[newX][newY];
    	}
    ```

    > 여전히 이 코드는 최선의 방법이 아니다. 수많은 중복(redundancy)이 존재한다. 하지만 논리적으로 가장 간명한 방법임은 틀림없다. 이렇게 가장 간명한 방법을 먼저 생각하고, 거기에 어떤 계산의 중복이 있는지 파악한 후, 그것을 제거하는 방향으로 생각해보는 것은 하나의 훌륭한 전략이다.