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

    

### Bcrypt로 비밀번호 암호화하기

- Why?

  - 현재 DB에 저장된 비밀번호를 보면 너무 안전하지 못함
  - 그래서 bcrypt를 이용하여 비밀번호를 암호화하여 DB에 저장해야 함

- How?

  - `npm install bcrypt --save`

  - Register Route로 가기

    ```js
    // index.js
    
    app.post("/register", (req, res) => {
      const user = new User(req.body)
      // 유저 정보들을 DB에 저장하기 전이 암호화할 타이밍
      user.save((err, doc) => { 
        if (err) 
          return res.json({
            success: false,
            err 
          }) 
        else
          return res.status(200).json({
            success: true
          })
      })
    })
    ```

    ```js
    // models/User.js
    
    const bcrypt = require("bcrypt")
    const saltRounds = 10 // step 0
    
    // 몽구스에서 가져온 메소드로, user를 index.js에서 save하기 전에 function을 실행하겠다는 소리
    userSchema.pre("save", function(next) {
      // 여기서 비밀번호를 암호화시킨다 (bcrypt doc 참고)
      var user = this;
      
      // step 1. salt를 만든다
      bcrypt.genSalt(saltRounds, function(err, salt) {
        if (err)
          return next(err)
        
        // step 1.5. 비번 바꿀 때만 이걸 실행
        if (user.isModified('password')) {
          // step 2. 암호화된 비밀번호를 만든다
          bcrypt.hash(user.password, salt, function(err, hash) {
            if (err)
              return next(err)
            // step 3. plain 비번을 hash된 비번으로 바꾼다
            user.password = hash
            next()
          });
        }
        else {
          // step 1.5. 비번 바꾸는 게 아니면 바로 나간다. 이걸 해줘야 여길 벗어날 수 있음
          next()
        }
        
      })
    }) 
    ```

  - 0) saltRounds 는 salt 자리수

  - 1) generate a salt

  - 2) hash on separate function calls

- 확인하는 법

  - 서버 키고
  - postman으로 보낸 다음
  - 몽고디비에서 확인

