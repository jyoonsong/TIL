### Login 만들기

- Login Route 만들기

  ```js
  // index.js
  const cookieParser = require("cookie-parser");
  app.use(cookieParser());
  
  app.post("/login", (req, res) => {
    // Step1. 요청된 이메일을 DB에 있는지 확인
    User.findOne({
      email: req.body.email
    }, (err, user) => {
      if (!user) {
        return res.json({
          loginSuccess: false,
          message: "제공된 이메일에 해당하는 유저가 없습니다"
        })
      }
      
      // Step2. 요청된 이메일이 있다면, 비밀번호가 같은지 확인한다
      user.comparePassword(req.body.password, (err, isMatch) => {
        if (!isMatch)
          return res.json({
            loginSuccess: false,
            message: "비밀번호가 틀렸습니다"
          })
        
        // Step3. 비밀번호가 맞다면, 그 유저를 위한 token을 생성
        user.generateToken((err, user) => {
          if (err)
            return res.status(400).send(err);
          
          // Step4. token을 cookie에 저장
          res.cookie("x_auth", user.token)
          .status(200)
          .json({
            loginSuccess: true,
            userId: user._id
          })
        })
        
      })
    })
  })
  ```

- `comparePassword`를 user 모델에서 만든다

  ```js
  // models/User.js
  const jwt = require("jsonwebtoken");
  
  userSchema.methods.comparePassword = function(plainPassword, cb) {
    // Step 2.5. plain 비번 vs hash된 비번 비교
    // 복호화는 불가하므로 plain 비번도 암호화해서 비교하면 됨
    bcrypt.compare(plainPassword, this.password, function(err, isMatch) {
      if (err)
        return cb(err);
      cb(null, isMatch); // true일 것
    })
  }
  
  userSchema.methods.generateToken = function(cb) {
    var user = this;
    
    // Step 3.5. jsonwebtoken을 이용해서 token을 생성하기
    var token = jwt.sign(user._id.toHexString(), "secretToken");
    user.token = token;
    user.save(function(err, user) {
      if (err)
        return cb(err);
      cb(null, user);
    })
  }
  ```

---

1. 데이터베이스에서 요청한 Email 찾기

   `User.findOne()`

2. 데이터베이스에서 요청한 이메일이 있다면, 비밀번호가 같은지 확인

   `bcrypt.compare()`를 이용하여 plain password와 hashed password가 같은지 확인

3. 비밀번호까지 같다면 token을 생성

   - 토큰 생성을 위해 jwt 필요

     `npm install jsonwebtoken --save`

   ```js
   var jwt = require("jsonwebtoken");
   var token = jwt.sign({foo: 'bar'}, "shhhhh");
   // {foo: 'bar'} + shhhhh를 합해서 토큰을 생성
   ```

4. 생성된 토큰을 Cookie에 저장

   - Cookie에 저장하기 위해 express에서 제공하는 cookieParser가 필요

     `npm install cookie-parser --save`

---

- 확인하기

  - postman에서 localhost:3000/login으로 send

    ```json
    {
      email: "daf@ajf.com",
      password: "12345678"
    } // 회원가입을 한 내용으로 해야 함
    ```

    