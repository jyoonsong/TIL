### 0. 디렉토리 구조

디렉토리 구조

```markdown
- client
	- package.json
  - ...REACT 관련 파일들은 client 안에
- app.js
- package.json
- socket.js
- ...EXPRESS 관련 파일들은 root에
```

### 1. Heroku-CLI 다운로드

https://devcenter.heroku.com/articles/getting-started-with-nodejs?singlepage=true#define-config-vars

### 2. root의 package.json에 커맨드 추가

```json
"scripts": {
  "start": "node app.js",
  "backend": "nodemon ./app --ignore 'client/**'",
  "test": "echo \"Error: no test specified\" && exit 1",
  "dev": "concurrently \"npm run backend\" \"npm run start --prefix client\"",
  "heroku-postbuild": "cd client && npm install && npm run build"
},
```

build라는 디렉토리에 컴파일하겠다는 내용

### 3. server/app.js

```js
// Serve static files from the React app
app.use(express.static(path.join(__dirname, 'client/build')));
```

```js
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname + '/client/build/index.html'));
});
```

build라는 디렉토리를 서버측에서 불러주는 것

```js
const port = process.env.PORT || 5000;
const server = app.listen(port, () => {
  console.log(`Listening on port ${port}`)
});
```

port를 heroku가 임의로 설정하는 포트를 따를 수 있도록 `process.env.PORT` 부분을 꼭 넣어줘야 함

### 4. 개발하면서 썼던 environment variables, redirect URL 등 바꿔주기

- environment variables를 헤로쿠 대시보드에서 추가해주기
- API redirect URL을 localhost에서 디플로이된 주소로 바꿔주기

### 5. heroku create

- 처음에 `heroku create`
- 매번 디플로이할 때는 `git push heroku master` 이용
- 그외 에러확인은 `heroku logs --tail`

### 6. 추가 - socket.io

Client configurations:

```js
const io = require('socket.io-client');
const socket = io();
```

터미널 (한 번만 해주면 됨)

```js
heroku features:enable http-session-affinity
```

https://devcenter.heroku.com/articles/node-websockets#option-2-socket-io

