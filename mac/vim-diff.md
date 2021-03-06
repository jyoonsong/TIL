# 리눅스 파일비교 에러 - diff

git에서 나는 crlf 에러와 유사한 이유로 발생하는 문제이다.

다른 OS에서 가져온 파일을 비교할 때, UNIX 개행문자와 DOS 개행문자가 섞여 있는 경우, 이를 서로 다른 문자로 인식해버린 나머지 `diff` 를 통한 파일 비교가 잘못되는 경우가 있다.

> 예컨대 윈도우 사용자께서 만들어주신 testcase output을 리눅스/맥에서 만들어진 나의 output과 비교하려는 상황에서 말이다.

이럴 때 DOS 개행문자를 제거하고 모두 유닉스 텍스트로 변환해버리면 된다.

- **기본적인 사용법**

  ```shell
  $ diff file1 file2
  1c1
  < hello
  ---
  > HELLO
  ```

  `(범위1)c(범위)` 는 file1의 라인넘버 범위1과 file2의 라인넘버 범위2 만큼이 다르다는 의미.

  같은 내용이어도 개행문자 때문에 모두 다르다고 나오는 경우가 종종 생긴다.

  > 개행문자에 관계없이 파일 비교할 수 있는 사이트도 있다. - diffchecker.com
  >
  > 물론 `ctrl+a` 후 복붙해야 한다는 수고로움이 있고, 지나치게 큰 용량은 나눠서 해줘야 한다.

- **^M 변환**

  ```shell
  $ vi file1	# 파일을 연 후,
  :%s/^M%//g	# regex를 사용해 ^M 기호를 모두 삭제해준다.
  ```

  주의해야 할 것은 `^M`은 `shift+6` 과 영문자 `M`이 아닌 `ctrl + V + M`으로 입력해줘야 한다.



### Ref

https://blog.gaerae.com/2016/02/remove-m-character-from-log-files.html & 채민