### Client-Server 통신

- Client =[Request with Body]=> Server

  - Body 데이터를 분석(parse)해서 req.body로 출력해주는 것
  - Body-parser dependency
    - 이때 body-parser가 필요하다
    - `npm install body-parser --save`로 다운로드

- client에서 request를 줘야하는데 현재 client가 없으니 임시로 postman을 이용해서 request를 보낸다

  - 인터넷에서 postman 다운로드

  - Register Route 만들기

    ```js
    // index.js
    const bodyParser = require("body-parser")
    const { User } = require("./models/User")
    
    // body parser 옵션을 줘야함
    // application/x-www-form-urlencoded
    app.use(bodyParser.urlencoded({extended: true}));
    // application/json
    app.use(bodyParser.json());
    
    app.get("/", (req, res) =>{
    	res.send("Hello World")
    })
    
    app.post("/register", (req, res) => {
    	// 회원가입에 필요한 정보들을 client에서 가져오면
      // 그것들을 데이터베이스에 넣어준다.
      
      // req.body는 bodyParser를 통해 아마도 json형태
      const user = new User(req.body)
      
      user.save((err, doc) => { // mongoDB method
        if (err) 
          return res.json({
            success: false,
            err // error message
          }) 
        else
          return res.status(200).json({
            success: true
          })
      })
    })
    ```

- test하는 법

  - `npm run start`

  - postman에서 + 누른 후

    post로 한 후, url에 `http://localhost:3000/register`

  - body - row - json 

    ```json
    {
      "name": "johnahn123",
      "email": "johnahn123@gmail.com",
      "password": "1234567"
      // 나머지는 schema 상으로 required 아니므로 굳이 안넣어도 괜찮음
    }
    ```

    send 클릭하면 success: true 가 올 것.

    