

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



### 비밀 설정 정보 관리

* 소스 코드를 git에 올리면 다른 사람들이 secret한 정보를 보게 됨.

  * 예: `mongoose.connect('mongodb+srv://username:password...')` 부분

* 그래서 이런 부분을 따로 파일을 떼어놓은 후

  * `config/dev.js` (local 환경)

    ```js
    module.exports = {
      mongoURI: 'mongodb+srv://~~'
    }
    ```

  * 혹은 HEROKU에서는 config vars를 헤로쿠 사이트에서 직접 관리해줌. 

    `config/prod.js` (production 환경)

    ```js
    module.exports = {
      mongoURI: process.env.MONGO_URI // heroku의 config vars와 이름을 똑같이 해주면 됨
    }
    ```

  * 환경변수로 각 환경마다 다르게 해줌

    `config/key.js`

    ```js
    if (process.env.NODE_ENV === 'production') {
      module.exports = require('./prod');
    }
    else {
      module.exports = require('./dev');
    }
    ```

  * 이제 index.js도 바꿔주자

    ```js
    const config = require('./config/key');
    
    const mongoose = require('mongoose')
    mongoose.connect(config.mongoURI, {
      ...
    })
    ```

*  `.gitignore`에 그 파일을 추가 (root에 파일 만들기)

  ```
  node_modules
  dev.js
  ```

  git status 로 확인

