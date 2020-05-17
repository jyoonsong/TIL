### 개념

* Node.js is an open-source, cross-platform, JavaScript runtime environment that **executes JavaScript code outside of a browser**
* Express.js, or simly Express, is **a web application framework for Node.js**



### 다운로드 및 프로젝트 생성

- node.js
  - `node -v`로 확인

- `npm init`

  - 기본값, author은 이름 쓰기

- express

  - `npm install express --save`

- `index.js` 생성

  - 시작점

    ```js
    const express = require("express");
    const app = express();
    const port = 3000; 
    
    app.get('/', (req, res) => res.send("Hello world!"))
    
    app.listen(port, () => console.log("Example app listening on port ${port}"))
    ```

- `package.json`

  - 명령어

    ```json
    "scripts": {
      "start": "node index.js",
      ...
    }
    ```

- `npm run start` (= npm run node index.js)



### Nodemon

- 소스를 변경할 때 그걸 감지해서 자동으로 서버를 재시작해주는 tool

  (그 전까진 소스 변경 후 다시 npm run start 해야 했음)

- 다운로드

  `npm install nodemon --save-dev`

  (개발 모드에서만 사용, 배포에서는 사용하지 않음)

- 시작할 때 nodemon으로 시작하기 위해 start 스크립트 수정

  ```json
  "scripts": {
    "start": "node index.js",
    "backend": "nodemon index.js",
    ...
  }
  ```

  앞으로는 `npm run backend`로 시작

