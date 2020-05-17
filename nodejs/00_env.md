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



### 몽고 DB 연결

* mongodb.com 로그인

* build a new cluster 

  * aws
  * 가장 가까운 free tier (singapore)
  * MO Sandbox 선택
  * cluster name 원하는 것으로 바꾸기
  * create cluster 버튼

* MongoDb 유저 생성

  * connect 버튼
  * create a mongoDB user
  * username, password 원하는 것 적고 기억해놓은 다음 create MongoDB user
  * Conncet Web application
  * connection string only 부분을 copy해서 기록해두기

* Mongoose

  * 몽고DB를 편하게 쓸 수 있는 object modeling tool

  * `npm install mongoose --save`

    ```js
    // index.js
    const express = require("express");
    const app = express();
    const port = 3000; 
    
    const mongoose require('mongoose')
    mongoose.connect('mongodb+srv://username:password쳐주기@react~~', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
     	useFindAndModify: false
    }).then(() => console.log("MongoDB connected..."))
      .catch(err => console.log(err))
    
    app.get('/', (req, res) => res.send("Hello world!"))
    
    app.listen(port, () => console.log("Example app listening on port ${port}"))
    ```

    

