# 기본 Methods



### String 클래스 기본 Methods

모두 앞에 String 옴. 즉 `str.method()` 형식으로 사용



**1. 문자열 동일성 검사**

- `equals(str2)` - boolean. 대소문자 구별 있음
-  `equalsIgnoreCase(str2)` - boolean. 대소문자 구별 없음



**2. 문자열 사전식 순서**

- `compareTo(str2)` - int.

  str1이 더 뒤이면 >0 / 같으면 =0 / 더 앞이면 <0 (부등호 그대로 가져온다고 기억하기)

- `compareToIgnoreCase(str2)` - 대소문자 구분 없이 비교




**3. 문자열 길이**

- `length()` - int



**4. 특정 위치의 문자** 검색

- `charAt(int)` - char



**5. 지정한 문자의 위치** 검색

- `indexOf(char)` - int



**6. 지정된 범위의 부분 문자열**

- `substring(int, int)` - String. 

  > 프로그래밍할 때 대부분의 구간은 시작점 포함, 끝점 미포함. [int, int)

  ```java
  String str = "ABCDEF";
  str.substring(0,2); // AB 
  ```

  ​



### 그외 유용한 기본 Methods

- `hasNext()` - Detect End of File (import java.util.Scanner)

  ```java
  // file을 끝까지 읽고 싶을 때 전형적 방식
  while (inFile.hasNext()) {
    String str = inFile.next();
    addWord(str);
  }
  ```

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
