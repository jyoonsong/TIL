## 11. 웹 소켓으로 실시간 데이터 전송하기

### 개념

- 양방향 데이터 전송을 위한 기술
- HTTP와 달리 WS라는 프로토콜 사용
- 노드는 ws나 Socket.IO와 같은 패키지를 통해 웹 소켓을 사용 가능

### 설치

`npm i socket.io`

### 연결

- 웹 소켓에는 네 가지 상태가 있음
  - connecting(연결 중)
  - open(열림): 이때에만 에러 없이 `socket.emit` 메서드로 메시지를 보낼 수 있음
  - closing(닫는 중)
  - closed(닫힘)

```js
// app.js
const webSocket = require("./socket");
const server = app.listen(app.get("port"), () => {
    console.log("waiting at port no.", app.get("port"))
})
webSocket(server)
```

```js
// socket.js
const SocketIO = require("socket.io");

module.exports = (server) => {
    const io = SocketIO(server, {path: "/socket.io"});
    // 두번째 인자는 클라이언트와의 연결 경로

    io.on("connection", (socket) => {
        const req = socket.request;
        const ip = req.headers["x-forwarded-for"] || req.connection.remoteAddress;
        console.log("새로운 클라이언트 접속", ip, socket.id, req.ip);

      // 통신 과정 중 에러가 나왔을 때
        socket.on("error", (error) => {
            console.error(error)
        })

      // 클라이언트가 연결 끊었을 때
        socket.on("disconnect", () => {
            console.log("클라이언트 접속 해제", ip, socket.id);
            clearInterval(socket.interval); //이 부분 없으면 메모리 누수
        })

      // 사용자가 직접 만든 이벤트
      // 클라이언트에서 reply라는 이벤트명으로 데이터를 보낼 때
        socket.on("reply", (data) => {
            console(data);
        })
      
      // news라는 이벤트명으로 Hello Socket.IO라는 데이터를 클라이언트에게 보냄
      // 클라이언트에서 이 메시지를 받기 위해 news 이벤트 리스너 만들어둬야 함
        socket.interval = setInterval(() => {
            socket.emit("news", "Hello Socket.IO");
        }, 3000);
    })
}
```

```html
<script>
  const socket = io.connect("http://localhost:8005", {
    path: "/socket.io",
  });
  socket.on("news", (data) => {
    console.log(data);
    socket.emit("reply", "Hello Node.JS")
  })
</script>
```

