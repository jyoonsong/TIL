# Java 복습 - Regex

- 개념

  - regular expression, 정규표현식

  -  특정한 규칙의 문자열을 정해진 문법으로 표현하는 형식 언어

    > 자세한 사항은 나중에 형식언어, CFG, 정규언어 등을 다루는 프로그래밍 언어론 등의 과목에서 배울 것

  - 일반적으로 **문자열 내의 패턴 매칭**에 사용



- 예

  ```java
  String patternStr = "(?<sign>[[+][-]]?)(?<num>[0-9]+)";
          String str = " +1000 ";

          Pattern pattern = Pattern.compile(patternStr);
          Matcher matcher = pattern.matcher(str);

          while (matcher.find()) {
              System.out.println(matcher.group() + " beginning at " + matcher.start() + " and ending at " + matcher.end()); // "+1000", 1, 5
              System.out.println(matcher.group("sign")); // +
              System.out.println(matcher.group("num")); //1000
          }
  ```

  - String patternStr에 찾기를 원하는 문자열의 집합을 정규표현식으로 나타낸 다음

  - Pattern 클래스(의 인스턴스)에 그것을 compile을 시키고

  - 이를 토대로 Matcher 클래스(의 인스턴스)가 input(가령, 예시 코드의 String str = "12312-321")에서 패턴을 찾아내는 것입니다.

    while 문 안에서는 matcher가 input(여기서는 str)에서 patternStr에 해당하는 subsequence를 찾아낼 때마다(정확한 표현은 아닙니다만) 찾아낸 subsequence(matcher.group())와 그 subsequence가 어디서 시작하고 끝나는지에 대한 index, 그리고 찾은 suqsequence에서 sign group에 해당하는 subsequence가 무엇이고 num에 상응하는 subsequence가 무엇인지 출력합니다.



- 자세한 규칙
  - `?<name>` = group의 이름 설정
  - group은 소괄호 '()' 사이에 표현된, 그들로 묶인 표현식
    - `([[+][-]])` = sign group
    - `([0-9])` = num group
  - 대괄호 '[]'는 문자의 집합 혹은 범주를 나타냄
    - `[abcde]` = `[a-e]` = a||b||c||d||e
    - `[gut]` (O)
    - `[[+][-]]` = + 나 - 중에 하나 = 대괄호 내에 표현된 문자의 집합이나 범주 내에서 임의의 하나이므로 문자 하나로 취급됨
  - 뒤쪽의 `?` = **한정자** = ?에 선행하는 문자 "하나"가 0개 이상 나타날 수 있다
    - `X?` = X가 0개 또는 1개 등장할 수 있다 = (1)공백 (2)X 두 가지가 가능
    - `[[+][-]]?` = (1)공백 (2)+ (3)-
  - 뒤쪽의 `+` = **한정자** = +에 선행하는 문자 "하나"가 1개 이상 등장한다.
    - `[0-9]+` = 공백 (X) 13(O) 10101(O)



- 한정자(Regular Quantifiers)

  | regex  | Description                |
  | ------ | -------------------------- |
  | X?     | X 한번 발생 혹은 전혀 발생하지 않음      |
  | X+     | X 한번 혹은 그 이상 발생            |
  | X*     | X 제로 혹은 그 이상 발생            |
  | X{n}   | X 오직 n 번 발생                |
  | X{n,}  | X n 번 혹은 그 이상 발생           |
  | X{y,z} | X 적어도 y번 발생 하지만 z 번 보다는 적음 |

  ​

### Ref

https://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html#compile(java.lang.String)

http://highcode.tistory.com/6