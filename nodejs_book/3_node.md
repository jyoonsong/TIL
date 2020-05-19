## 3. 노드 기능 알아보기

### 3.2. JS 파일 실행하기

`node 파일명`

.js 안써줘도 됨

### 3.3. 모듈로 만들기

import `require(something)`

export `module.exports = something `

```js
// var.js
const odd = "홀수"
const even = "짝수"

module.exports = {
  odd,
  even,
}
```

```js
// func.js
const {odd, even} = require("./var")

function checkOddOrEven(num) {
  if (num % 2)
    return odd;
  return even;
}
module.exports = checkOddOrEven;
```

```js
// index.js
const {odd, even} = require("./var");
const checkNumber = require("./func");

function checkStringOddOrEven(str) {
  return checkNumber(str.length)
}
```

### 3.4. 노드 내장 객체

1. `global`

   브라우저의 window같은 전역 객체

   - `global.message`는 어디에서든 접근 가능

2. `console`

   브라우저의 console과 거의 유사

   - `console.time(x)` ~ `console.timeEnd(x)` => 시간 측정
   - `console.dir(객체, {colors: false, depth: 2})` => 객체 출력

3. 타이머

   - `const id = setTimeout(callback, ms)` => `clearTimeout(id)`
   - `const id = setInterval(callback, ms)` => `clearInterval(id)`
   - `const id = setImmediate(callback, ms)` => `clearImmediate(id)`

4. 현재 파일명/경로

   - `__filename` => C:\Users\here\filename.js
   - `__dirname` => C:\Users\here

5. `exports`

   module 객체 말고 exports 객체로도 모듈 만들 수 있음

   - exports =참조=> module.exports =참조=> { }
   - `exports.odd = "홀수입니다"` == `module.exports = odd`

6. `process`

   현재 실행되고 있는 노드 프로세스에 대한 정보

### 3.5. 노드 내장 모듈 사용하기

1. `os`

   운영체제 정보

   ```js
   const os = require("os");
   console.log(os.platform())
   ```

2. `path`

   파일의 경로를 쉽게 조작하도록 도와주는 모듈

   ```js
   const path = require("path");
   ```

3. `url`

   인터넷 주소를 쉽게 조작하도록 도와주는 모듈

   ```js
   const url = require("url");
   const myURL = new URL("http://~~~~")
   ```

4. `querystring`

   url을 객체로 분해하고 문자열로 조립

   ```js
   const querystring = require("querystring");
   ```

5. `crypto`

   암호화를 도와주는 모듈

   ```js
   const crypto = require("crypto");
   crypto.createHash("sha512").update("비밀번호").digest("base64"); // 알고리즘 - 변환할 문자열 - 인코딩
   ```

### 3.7. 이벤트

- `on(이벤트명, callback)`
  - == `addListener(이벤트명, callback)`
- `emit(이벤트명)` 
  - 이벤트를 호출하는 메서드. 이벤트 이름을 인자로 넣어주면 미리 등록해뒀던 이벤트 콜백이 실행됨. (예: 클릭을 실행시키는 셈)
- `once(이벤트명, callback)`
  - 한 번만 실행되는 on
- `removeAllListeners(이벤트명)`
  - 이벤트에 연결된 모든 이벤트 리스너를 제거
- `removeEventListener(이벤트명, 리스너)`
  - 이벤트에 연결된 리스너를 하나씩 제거
  - == `off(이벤트명, 리스너)`
- `listenerCount(이벤트명)`

### 3.8. 예외 처리하기

에러가 발생할 것 같은 부분  try catch로 감싸기

```js
setInterval(() => {
  try {
    throw new Error("강제로 에러 발생시키면")
  } catch (err) {
    console.error(err); // 여기서 실행됨
  }
}, 1000);
```

최후의 수단. (프로세스가 종료되지는 않지만, 다음 동작이 제대로 될지 보장하지는 않음)

```js
process.on("uncaughtException", (err) => {
  console.error("예기치 못한 에러", err)
  process.exit() // 걍 종료시키고 기록용으로 사용하는 것을 추천
})
```

