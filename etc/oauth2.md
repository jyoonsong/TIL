# OAuth2

> 구현 X 동작원리 O 에 대한 강의

### 3개의 주체

- **resource server** = their service (연동하고자 하는 곳)
  - 데이터를 저장하는 서버
  - cf) authorization server은 인증 전담 서버
  - 예: 구글, 페이스북
- **resource owner** = user
- **client** = my service

### OAuth의 핵심

- 사용자가 그들의 서비스 연동을 위해 ID/PW를 제공한다면?

  - 모든 기능에 접근 가능하며 쉽지만 매우 위험

- 그래서 사용하는 게 OAuth 기술

  OAuth를 사용하면 ID/PW 대신 **access token**을 얻어낸다

  - 필요로 하는 부분적 기능에만 접근 가능

### OAuth의 access token 발급 절차

1. **등록 (register)**

   : client가 resource server의 승인을 사전에 받아놓는 과정

   - 서비스마다 다르지만 공통적으로 관여되는 변수 3가지

     - **client ID**: my app 식별자 (노출 가능)

     - **client secret**: 그에 대한 비밀번호 (노출 불가능)

     - **authorized redirect URLs**: authorization server가 권한을 부여하는 과정에서 authorized code 줄 것. 그때 이 주소로 그 코드를 전달해달라는 의미.

       ex) facebook 에서는 "redirect URI to check"

   - 이제 이 세 가지 정보는 client와 resource server가 share하는 정보가 됨

2. **resource owner의 승인 (resource server에 접속하는 데 동의를 구하는 과정)**

   - resource server가 가지고 있는 기능이 A, B, C, D이고

     client가 필요로 하는 기능은 B, C일 때

     모든 기능이 아닌 최소한의 기능에 대해서만 인증을 받는 것이 서로에게 둘다 좋을 것.

   - resource owner는 client에 접속할 것. 

     resource server를 사용해야 하는 작업이 발생하면 (예: 구글 캘린더에 날짜 저장해야 하는 상황, 구글로 로그인)

     사용자에게 페이스북 ~~ 기능 권한 허용하는지 여부를 묻는 것이 버튼의 역할

     - 이때 버튼은 별 게 아님

       `https://resource.server/`

       `?client_id=1`

       `&scope=B,C`

       `&redirect_url=https://client/callback`

   - 이 주소로 resource owner가 resource server에 접속을 하면,

     로그인이 안 된 경우 로그인 하라고 함

     - 로그인이 된 경우 그때서야 보내준 client ID값과 같은 client ID가 있는지 확인

     현재 접속하려는 redirect_URL과 저장된 redirect_URL 같는지 확인

     - 다르면 끝냄

     같으면 client에게 권한 부여할 것인지 확인하는 메시지를 전송 (버튼 누른 후 뜨는 창)

     - 동의하면 이제 resource server는 다음과 같은 정보를 수집함. "user id 1번은 scope B, C에 해당하는 권한을 제공하는 걸 허용하였다"

       `user id: 1, scope: b, c`

3. **resource server의 승인 (resource server가 client를 승인하는 과정)**

   - 곧바로 access token을 주지 않고 한 단계를 더 거친다.

   - 바로 authorization code라는 임시 비밀번호를 생성해서 resource owner에게 제공

     - location: https://client/callback?code=3 라는 주소로 이동하세요 라고 명령. resource server가 resource owner의 웹 브라우저에게.

   - location 헤더 값에 의해 resource owner가 인식하지도 못하는 사이 은밀하게 https://client/callback?code=3으로 이동하게 됨

     - 이를 통해 client는 authorization code: 3을 알게 됨.

   - 이제 client는 resource owner를 통하지 않고 resource server에게 직접 접속

     - `https://resource.server/token`
       `?grant_type=authorization_code`

       `&code=3`

       `&redirect_uri=https://client/callback`

       `&client_id=1`

       `&client_secret=2`

     - 여기서 중요한 건 절대로 외부에 노출해서는 안되는 client secret값을 직접 전송한다는 것!

     - authorization code와 client secret이라는 두 개의 비밀 정보를 결합해서 resource server에게 전송

   - 이제 resource server는 authorization_code가 일치하는지 확인

     - 어떤 클라이언트에게 발급했는지 확인 (client_id)

     - 그 클라이언트의 secret을 확인 (client_secret)

       => 이렇게 세 가지가 모두 일치하면 다음 단계 access token 발급으로 진행

4. **액세스 토큰 발급**

   - OAuth의 목적은 액세스 토큰 발급. 클라이막스.
   - 이제 authorization code는 인증을 했으므로 지워버린다. client에서도 resource server에서도 삭제됨.
   - 드디어 resource server는 access token을 발행
     - 이 access token를 client에게 응답해준다.
     - client는 access token을 내부적으로 저장
   - access token은 무엇을 보장하는가?
     - client가 access token을 가지고 resource server에 접근하면 "아, 이 access token을 가진 사람에게 user의 B, C에 대한 정보를 허용해야겠다"

### API

- 이제 access token을 활용해서 resource server를 조작해야 함. 

- 이때 아무렇게 할 수 있는 게 아니라, resource server가 이렇게 이렇게 사용해라 라고 알려주는 방식이 있음 = API

- 예시: 구글

  - 두 가지 방법 있음

    - `access_token` query string parameter

      ex) `https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=토큰`

    - `Authorization: Bearer` HTTP header

      더 선호되곤 함. 더 안전

      => 이때 curl이라는 프로그램 실행시키면 쉬움

      `curl -H "Authorization: Bearer <access_token>" https://www.googleapis.com/calendar/v2/users/me/calendarList`

      - curl은 뒤에 나오는 링크 웹페이지를 다운받는 프로그램 (네이버 치면 네이버 HTML 나옴)
      - "" 안에 있는 건 Authorization 이라는 이름의 header임

### Refresh Token

- access token은 수명이 있음. 

  - 일반적으로 1~2시간. 길게는 60일, 90일.
  - 수명이 끝나면 더이상 API에 접속했을 때 데이터를 주지 않음

- 그러면 어떻게 할까? access token을 다시 받아야 함

  - 그런데 user에게 또 그 과정을 거치게 하면 번거로우니

    손쉽게 새로운 access token을 발급받을 수 있는 방법이 바로 refresh token

- OAuth 2.0 rfc (표준안) 6749번 1.5. refresh token

  - access token을 발급할 때 refresh token도 함께 발급하는 경우가 많음

  - resource server에서 protected resource를 요청할 때는 access token을 사용

  - 그런데 어느 날 갑자기 access token의 수명이 끝나서 invalid token error가 뜬다

  - 그러면 refresh token을 authorization server에게 전달하면서 access token을 다시 발급받는다

    (선택적으로 refresh token도 갱신되는 곳도 있고 access token만 갱신되는 곳도 있음)

    ex) 구글의 경우 refresh token 제공. 



