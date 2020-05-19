## 6. Express

### 6.1. 설치

`npm i -g express-generator`

`express learn-express`

`cd learn-express && npm i`

### 6.2. Express 구조

- **/bin/www**: 익스프레스 설정 파일인 app.js 파일을 가져와 http 객체와 연결하는 작업을 한다. 실제 서버를 구동하는 파일이다.
- **app.js**: 익스프레스 객체를 생성하고 환경 설정을 한다.

![express 구조도](https://thebook.io/img/006982/192.jpg)

### 6.3. 미들웨어

요청과 응답의 중간에 위치함

요청과 응답을 조작하여 기능을 추가하기도 하고 나쁜 요청을 걸러내기도 함

주로 `app.use`와 함께 사용됨

- error handler

  ```js
  // 404 middleware
  app.use((req, res, next) => {
      const err = new Error("Not Found");
      err.status = 404;
      next(err); // 흐름이 끊기지 않도록 next를 반드시 해줘야 함.
  })
  
  // error handler middleware
  app.use((err, req, res) => {
      res.locals.message = err.message;
      res.locals.error = req.app.get("env") === "development" ? err : {};
      res.status(err.status || 500);
      res.render("error");
  })
  ```

- **morgan**

  - 요청에 대한 정보를 콘솔에 기록해주는 미들웨어

  ```js
  const logger = require("morgan");
  app.use(logger("dev")); // dev 대신 short, common, command 있음
  ```

- **body-parser**

  - 요청의 본문을 해석해주는 미들웨어
  - 보통 폼 데이터나 AJAX 요청의 데이터를 처리

  ```js
  const bodyParser = require("body-parser");
  // json 형식 데이터 전달방식 해석하게 해줌
  app.use(bodyParser.json())
  // url 주소 형식으로 데이터를 보내는 방식 해석하게 해줌 (예: 폼 전송)
  app.use(bodyParser.urlencoded({extended: false}));
  ```

- **cookie-parser**

  - 요청에 동봉된 쿠키를 해석해주는 미들웨어
  - 해석된 쿠키들은 `req.cookies` 객체에 들어간다
    - 예를 들어 `name = zerocho` 쿠키를 보냈으면 `req.cookies`는 {name: "zerocho"}

  ```js
  const cookieParser = require("cookie-parser");
  app.use(cookieParser());
  app.use(cookieParser("secret code")); // 제공된 문자열로 서명된 쿠키. 클라이언트에서 수정했을 때 에러 발생하므로 클라이언트에서 쿠키로 위험한 행동 하는 것을 방지할 수 있음.
  ```

- **static**

  - 정적인 파일들을 제공하는 미들웨어
  - express를 설치하면 따라오므로 따로 설치할 필요 없음
  - 자체적으로 정적 파일 라우터 기능을 수행하므로 최대한 위쪽에 배치하는 것이 좋음. 보통 morgan 다음에 배치.

  ```js
  app.use(express.static(path.join(__dirname, "public")));
  
  // 사용 예시
  app.use("/img", express.static(path.join(__dirname, "public")));
  ```

- **express-session**

  - 세션 관리용 미들웨어

  - 로그인 등의 이유로 세션을 구현할 때 매우 유용

  - cookie-parser을 내부적으로 사용하므로 cookie-parser보다 뒤에 위치하는 것이 안전.

  - 인자로 세션에 대한 설정을 받음

    - `resave`: 요청이 왔을 때 세션에 수정사항이 생기지 않더라도 세션을 다시 저장할지
    - `saveUninitialized`: 세션에 저장할 내역이 없더라도 세션을 저장할지 (보통 방문자를 추적할 때 사용)
    - `secret`: 필수항목. 세션 관리 시 클라이언트에 세션 쿠키를 보내는데, 안전하게 쿠키를 전송하려면 쿠키에 서명을 추가해야 하고, 쿠키를 서명하는 데 secret 값이 필요. cookie-parser의 secret과 같게 설정해야 함.
    - `cookie`: 세션쿠키에 대한 설정
      - `httpOnly`: 클라이언트에서 쿠키를 확인할 수 있는가
      - `secure`: https 환경에서만 사용할 수 있는가 (배포시에는 https 설정하고 true로 하는 것이 좋음)

  - `req` 객체 안에 `req.session` 객체를 만듦

    - 이 객체에 값을 대입하거나 삭제해서 세션을 변경할 수 있음.

      한 번에 삭제 => `req.session.destroy()`

      현재 세션 아이디 확인 => `req.sessionID`

  ```js
  const session = require("express-session");
  
  app.use(cookieParser("secret code"))
  app.use(session({
    resave: false,
    saveUninitialized: false,
    secret: "secret code",
    cookie: {
      httpOnly: true,
      secure: false,
    },
  }))
  ```

- **connect-flash**

  - 일회성 메시지를 웹 브라우저에 나타낼 때 유용.
  - req 객체에 `req.flash()` 메서드를 추가함
    - `req.flash(키, 값)` : set
    - `req.flash(키)` : get

  ```js
  const flash = require("connect-flash");
  app.use(flash());
  ```

  

### 6.4. Router 객체로 라우팅 분리하기

라우터도 일종의 미들웨어. 다른 미들웨어와는 다르게 앞에 주소가 붙어있음. 특정 주소에 해당하는 요청이 왔을 때만 미들웨어가 동작.

- `app.use("주소", callback)` => 요청 주소만 일치하면 실행됨
- `app.get/post/delete` => 주소뿐만 아니라 HTTP 메서드까지 일치하는 요청일 때만 실행

```js
// app.js
const indexRouter = require("./routes/index")
const usersRouter = require("./routes/users")
app.use("/", indexRouter)
app.use("/users", usersRouter)
```

```js
// routes/index.js
const express = require("express");
const router = express.Router();

// "/" 주소로 GET 요청이 오면
router.get("/", (req, res, next) => {
  // 클라이언트에 응답
  res.render("index", {title: "Express"})
})
module.exports = router;
```

```js
// routes/users.js
const express = require("express");
const router = express.Router();

// app.js에서 "/users"로 연결했으므로 "/"가 합쳐진
// "/users/"로 GET 요청을 했을 때 콜백함수 실행됨
router.get("/", (req, res, next) => {
  res.send("respond with a resource");
})
module.exports = router;
```

- 라우터에서는 반드시 (1) 요청에 대한 응답을 보내거나 (2) 에러 핸들러로 요청을 넘겨야 함. 응답을 보내지 않으면 브라우저는 계속 기다림.

  - 응답을 어떻게 보내는가? `res` 객체에 들어있는 메서드들로
    - `send()` 만능 메서드. (문자열/HTML/JSON 데이터 등)
    - `sendFile(파일 경로)` 
    - `json(json 데이터)`
    - `redirect(주소)` 응답을 다른 라우터로 보내버림
    - `render("템플릿 파일 경로", {변수})`

- `next('route')` : next함수에서 라우터에서만 동작하는 특수 기능

  - app.use처럼 router 하나에 미들웨어를 여러 개 장착할 수 있음
  - 위 기능은 라우터에 연결된 나머지 미들웨어들을 건너뛰고 싶을 때 사용

- 라우터 주소 특수 패턴

  ```js
  router.get("/users/:id", function(req, res) {
    console.log(req.params, req.query);
  })
  ```

  ex) `/users/123?limit=5&skip=10` 이라는 주소의 요청이 들어오면 

  => `req.params` = {id: "123"}

  => `req.query` = {limit: "5", skip: "10"}