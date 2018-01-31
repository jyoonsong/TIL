## Git에서 발생하는 CRLF will be replaced by LF (or vice-versa) 에러 핸들링하는 법

터미널에 `git` 명령어를 입력했는데 다음과 같은 에러가 뜨는 경우가 있다:

```bash
warning: CRLF will be replaced by LF in some/file.file.
The file will have its original line endings in your working directory.
```

이는 맥 또는 리눅스를 쓰는 개발자와 윈도우 쓰는 개발자가 Git으로 협업할 때 발생하는 **Whitespace** 에러다. 유닉스 시스템에서는 한 줄의 끝이 **LF(Line Feed)** 로 이루어지는 반면, 윈도우에서는 줄 하나가 **CR(Carriage Return)** 와 **LF(Line Feed)**, 즉 **CRLF**로 이루어지기 때문이다. 따라서 어느 한 쪽을 선택할지 Git에게 혼란이 온 것이다. 

유닉스 OS을 쓰고 있다면 `CRLF will be replaced by LF in…` 에러 메시지가 뜰 것이고,
윈도우를 사용하고 있다면 `LF will be replaced by CRLF in…` 에러 메시지가 뜰 것이다.

둘 중 뭐든간에 해결 방법은 유사같다. Git은 똑똑해서 이를 자동 변환해주는 `core.autocrlf` 라는 기능을 가지고 있는데, 이 기능을 켜주기만 하면 된다. 

<br>

>  
> 해답은 `core.autocrlf` 를 켜는 것!
> 

<br>
이 기능은 개발자가 git에 코드를 추가했을 때 (예컨대 커밋할 때)에는 CRLF를 LF로 변환해주고, git의 코드를 개발자가 조회할 때 (예컨대 clone한다거나 할 때)에는 LF를 CRLF로 변환해준다.

그러므로 **윈도우 사용자**의 경우 이러한 변환이 항상 실행되도록 다음과 같은 명령어를 입력한다. 물론 시스템 전체가 아닌 해당 프로젝트에만 적용하고 싶다면 `—global` 을 빼주면 된다.

```bash
git config --global core.autocrlf true
```

**리눅스나 맥을 사용**하고 있는 경우, 조회할 때 LF를 CRLF를 변환하는 것은 원하지 않을 것이다. 따라서 뒤에 `input`이라는 명령어를 추가해줌으로써 단방향으로만 변환이 이루어지도록 설정한다.

```bash
git config --global core.autocrlf true input
```

혹은 이러한 변환 기능을 원하지 않고, 그냥 **에러 메시지 끄고 알아서 작업하고 싶은 경우**에는 아래 명령어로 경고메시지 기능인 `core.safecrlf`를 꺼주면 된다.

```bash
git config --global core.safecrlf false
```

생각보다 쉽게 해결되는 에러이다.




#### Ref

Git Documentation - [https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#Formatting-and-Whitespace](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#Formatting-and-Whitespace)
