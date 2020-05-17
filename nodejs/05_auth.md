### Auth 기능 만들기

- Why?

  - authentication
  - 로그인해야 볼 수 있는 페이지에서 "이 페이지를 볼 수 있는 사람인지" 체크하기 위해

- How?

  0. Auth route 만들기

  1. Cookie에서 저장된 token을 Server로 가져온다

  2. 가져온 token을 복호화한다

  3. 복호화하면 나오는 user id를 이용해서 DB의 User Collection에서 유저를 찾은 후, 쿠키에서 받아온 token을 유저도 갖고 있는지 확인

  4. 쿠키가 불일치하면 Auth false
  
     쿠키가 일치하면 Auth true => 해당하는 유저의 정보를 선별해서 프론트로 보내준다.

---

```js
// index.js
const { auth } = require("./middleware/auth");

app.post("/api/users/auth", auth, (req, res) => {
  // 여기까지 미들웨어를 통과해 왔다는 것은 Authentication이 true라는 의미. 즉 error 없고 성공적이었다는 의미.
  res.status(200).json({
    isAuth: true,
    _id: req.user._id,
    isAdmin: req.user.role === 0 ? false : true,
    email: req.user.email,
    name: req.user.name,
    lastname: req.user.lastname,
    image: req.user.image
  })
});
```

- `auth`는 미들웨어

  - endpoint `/api/users/auth`에서 request를 받은 다음에 callback function을 하기 전에 중간에서 뭔가를 해주는 것

  - `middleware/auth.js` 루트에 만들기

    ```js
    const {User} = require('../models/User');
    
    let auth = (req, res, next) => {
      // 인증 처리를 하는 곳
      
      // Step 1. 클라이언트 쿠키에서 토큰을 가져온다.
      let token = req.cookie.x_auth;
      
      // Step 2. 토큰을 복호화한다
      // Step 3. 유저를 찾는다.
      // Step 4. 유저의 token과 가져온 token 비교
      User.findByToken(token, (err, user) => {
        if (err) throw err;
        if (!user) return res.json({
          isAuth: false,
          error: true
        })
        
        // Step 5. request에 넣어줌으로 인해 index.js에서 이어서 user, token 정보를 이어서 사용할 수 있음
        req.token = token;
        req.user = user;
        next();
      })
      
    }
    ```

  - `models/User.js`

    ```js
    userSchema.methods.findByToken = function(token, cb) {
      var user = this;
      
      // Step 2.5. 토큰을 decode한다.
      jwt.verify(token, "secretToken", function(err, decoded) {
        // Step 3. 유저 아이디를 이용해서 유저를 찾는다
        // Step 4. 유저의 token과 가져온 token 비교
        user.findOne({
          "_id": decoded,
          "token": token
        }, function(err, user) {
          if (err)
            return cb(err)
          cb(null, user)
        })
      })
    }
    ```

    