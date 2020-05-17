### 로그아웃 기능 만들기

1. 로그아웃 Route 만들기
2. 로그아웃하려는 유저를 DB에서 찾아서
3. 그 유저의 토큰을 지워준다

- Why?
  - Auth 기능에서 DB의 token과 클라이언트 쿠키의 token을 비교했음
  - 그런데 DB에 token이 없으면 비교 결과 불일치이므로 저절로 auth false가 되어 로그아웃이 된다

---

```js
// index.js

// Step 1
app.get("api/users/logout", auth, (req, res) => {
  User.findOneAndUpdate({
    _id: req.user._id // Step 2. auth middleware에서 찾아준 _id
  }, {
    token: "" // Step 3
  }, (err, user) => {
    if (err)
      return res.json({
        success: false, err
      })
    return res.status(200).send({
      success: true
    })
  })
})
```

---

확인

- 먼저 login해서 success true
- postman에서 `http://localhost:3000/api/users/logout`
- success true한 후 DB를 보면 token 없어졌을 것