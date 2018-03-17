# 02. Java 복습 - 문자열과 리스트 다루기

### 실습: 인덱스 메이커

> 인덱스 메이커 라는 프로그램을 만들어보자.

- 프로그램 내용

  입력으로 하나의 텍스트 파일을 읽고, 등장하는 모든 단어들의 목록을 만글며, 각 단어가 텍스트 파일에 등장하는 횟수를 센다. (단, 단어 개수는 최대 100,000개로 가정한다.) 
  사용자가 요청하면 단어 목록을 하나의 파일로 저장하고, 사용자가 단어를 검색하면 그 단어가 텍스트 파일에 몇 번 등장하는지 출력한다.

- 실행 예

  $ : 프롬프트 라고 부름

  ```java
  $ read sample.txt	// 텍스트 파일 sample.txt를 읽고 인덱스를 만든다.
  $ find heaven		// heaven이라는 단어가 몇 번 나오는지 출력한다
  The word "heaven" appears 13 times.
  $ saveas index.txt	// 인덱스를 index.txt라는 파일로 저장한다.
  $ find java
  The word "java" does not appear
  $ exit
  ```

- 자료구조

  일반적으로 프로그래밍을 할 때, 가장 먼저 생각해야 할 것은 자료구조를 정의하는 일이다. 자료구조란 외부로부터 입력받은 데이터를 저장할 변수를 가리킴.

  예: 여기서는 sample.txt 를 읽어오고 두 종류의 데이터를 저장.

  - 단어의 목록 - `String [] words = new String [100000];`

  - 각 단어의 등장 횟수 - `int [] count = new int [100000];`

  - while loop

    반복 횟수가 미정인 경우 무한루프를 만들고 사용자가 명령어를 입력하면 `break`를 사용해 빠져나오곤 한다.

  ```java
  static String [] words = new String [100000];
  static int [] count = new int [100000]; // 0으로 자동 초기화됨. C에서는 해줘야 함. 
  static int n = 0; // 추가할 때 현재 차례가 온 index

  while (true) {
    System.out.print("$ ");
    String command = kb.next();
    if (command.equals("exit")) {
      break;
    }
    else {
      System.out.println("Unknown Command");
    }
  }
  ```




### Process

---

**read 만들기**

```java
if ( command.equals("read") ) {
  // file name을 받으면 
  String filename = kb.next();
  // read하여 index를 만든다 
  makeIndex( filename );
}
```

- `makeIndex( filename )`

  ```java
  static void makeIndex( String filename ) {
    // file이 없는 경우를 대비하여 try-catch 사용 
    try {
      Scanner inFile = new Scanner( new File(filename) );
      while( inFile.hasNext() ) { // file을 끝까지 읽고 싶을 때 전형적 방식
        String str = inFile.next(); // 띄어쓰기 기준으로 word 받아오기
        addWord( str ); // 받아온 word를 addWord
      }
      inFile.close();
    } catch (FileNotFoundException e) {
      System.out.println(filename + "not found");
      return;
    }

  }
  ```

- `addWord( str )`

  ```java
  static void addWord( String str ) {
    int index = findWord( str ); // boolean으로 할 경우 위치는 모르므로 또 찾아야 함
    if (index != -1) { // found - words[index]가 str와 같은 걸 찾은 경우
      count[index]++; // 등장 횟수 array 업데이트
    }
    else { // not found
      words[n] = str; // 단어 array에 새로 추가해준다. C에서는 재사용 시 strdup() 해줘야 함. 
      count[n] = 1; // 등장 횟수 array 업데이트
      n++;
    }
  }
  ```

- `findWord( str )`

  ```java
  static int findWord( String str ) {
    for (int i=0; i<n; i++)
      if ( words[i].equals(str) ) // 단어 array 중 이미 단어가 등록되어 있으면
        return i; // index를 알려주자
    return -1; // 그렇지 않으면 -1 반환
  }
  ```

---

**find 만들기**

- `findWord(str)` 재사용

  ```java
  else if ( command.equals("find") ) {
    String query = kb.next();
    int i = findWord( query );
    if (i != -1) {
      System.out.println("The word " + words[i] + " appears " + count[i] + " times.");
    }
    else {
      System.out.println("The word " + query + " does not appear.");
    }
  }
  ```

---

**saveas 만들기**

```java
if ( command.equals("read") ) {
  // file name을 받으면 
  String filename = kb.next();
  // 현재 만들어진 index를 해당 이름의 파일로 저장한다. 
  saveAs( filename );
}
```

- `saveAs( filename )`

  ```java
  static void saveAs( String filename ) {
    // error를 대비하여 try-catch 사용 
    try {
      PrintWriter outFile = new PrintWriter(new FileWriter(filename));
      for (int i=0; i<n; i++) {
        outFile.println(words[i] + " " + count[i]);
      }
      outFile.close();
    } catch (IOException e) {
      System.out.println("Save failed. Don't ask me why!");
      return; //사실 어차피 마지막. 다시 가도 끝남. but 혹시 모르니 해주자.
    }
  }
  ```

  ​



### Useful Tips

- file을 끝까지 읽고 싶을 때 전형적 방식 - `hasNext()`

  ```java
  while (inFile.hasNext()) {
    String str = inFile.next();
    addWord(str);
  }
  ```

- 대소문자 구분 없이 `str1.eqauls(str2)` 

  대소문자 구분하기 `str1.equalsIgnoreCase(str2)`

- file로 출력하는 법 - `PrintWriter` & `FileWriter`

  `Scanner` 만들듯이`PrintWriter outFile = new PrintWriter( new FileWriter(fileName) )` 해준다. 또한 `Scanner` 닫듯이 `outFile.close()`로 닫아준다.

  ```java
  static void saveAs( String filename ) {
    // error를 대비하여 try-catch 사용 
    try {
      PrintWriter outFile = new PrintWriter(new FileWriter(filename));
      for (int i=0; i<n; i++) {
        outFile.println(words[i] + " " + count[i]);
      }
      outFile.close();
    } catch (IOException e) {
      System.out.println("Save failed. Don't ask me why!");
      return; //사실 어차피 마지막. 다시 가도 끝남. but 혹시 모르니 해주자.
    }
  }
  ```

- `println` 앞에는 출력 대상을 적어준다

  - `System.out` - 모니터에 출력됨.
  - `outFile` - 출력되는 파일 `outFile`에 출력됨

<br>



### 개선점

- 개선점
  - 소수점, 쉼표 등 특수기호 또는 숫자도 단어에 포함된다
  - 대문자와 소문자 구별 없이 목록을 저장되면 좋겠다
  - 단어들이 알파벳 순으로 정렬되면 좋겠다

### 