## 알아둬야 할 자바스크립트

### 2.1. ES2018+

- 2.1.1. 변수

  - var 함수 스코프
  - let, const 블록 스코프

- 2.1.2. 템플릿 문자열

  - `${num}이 숫자입니다.`

- 2.1.3. 객체 리터럴

  - 콜론 생략 가능
  - function 생략 가능

  ```js
  let sayNode = 2;
  const newObject = {
    sayJS() {
      console.log("JS");
    },
    sayNode,
    [es + 6]: "FANTASTIC"
  }
  
  newObject.sayNode;
  newObject.sayJS();
  console.log(newObject.ES6);
  ```

- 2.1.4. arrow function

  ```js
  const add = (x, y) => {
    return x + y
  }
  const add2 = (x, y) => x + y;
  const add3 = (x, y) => (x + y);
  ```

- 2.1.5. 비구조화 할당

  `const { getCandy, status: { count } } = candyMachine`

- 2.1.6. Promise

  callback 대신 Promise 기반으로  재구성 

  ```js
  const promise = new Promise((resolve, reject) => {
    if (condition) {
      resolve("success")
    }
    else {
      reject("fail")
    }
  })
  
  promise
  .then((message) => { // true => message = "success"
    return new Promise((resolve, reject) => {
      resolve(message);
    })
  })
  .then((message2) => {
    console.log(message2)
  })
  .catch((error) => { // false => error = "fail"
    console.error(error);
  })
  ```

  ```js
  function findAndSaveUser(Users) {
    Users.findOne({})
    .then((user) => {
      user.name = "zero";
      return user.save();
    })
    .then((user) => {
      return Users.findOne({gender: "m"})
    })
    .then((user) => {
      // 생략
    })
    .catch(err => {
      console.error(err)
    })
  }
  ```

- 2.1.7. async/await

  - await 붙어있으면 resolve 될 때까지 기다려짐

  ```js
  const findAndSaveUser = async (Users) => {
    try {
      let user = await Users.findOne({});
      user.name = "zero";
      user = await user.save();
      user = await Users.findOne({gender: "m"})
      // 생략
    }
    catch (error) {
      console.error(err);
    }
  }
  ```

### 2.2. 프론트엔드 자바스크립트

- 2.2.3. encodeURLComponent, decodeURLComponent

  - 한글 주소 인코딩 후 전송

    `xhr.open("GET", "https://jaeyoon.io/" + encodeURIComponent("노드"))`

