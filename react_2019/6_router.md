### Installing the Router

- navigation

  - `npm i react-router-dom`

- N files in router = N screens = N routes

  - "okay go to about.js" or "go to home.js"

    : Takes the url and according to what we told to router it makes the app to goes to a certain page

    - `/` => Home.js
    - `/about` => About.js

### Building the Router

```jsx
// App.js
import React from 'react';
import { HashRouter, Route } from "react-router-dom";
import About from "./routes/About";
import Home from "./routes/Home";

function App() {
  return <HashRouter>
    <Route path="/" exact={true} component={Home}/>
    <Route path="/about" component={About}/>

  </HashRouter>
}

export default App;
```

- if the url **includes** `path` render `component`(s)

```jsx
function App() {
  return <HashRouter>
    <Route path="/home">
      <h1>Home</h1>
    </Route>
    <Route path="/home/introduction">
	    <h1>Introduction</h1>
    </Route>
    <Route path="/about">
	    <h1>About</h1>
    </Route>
  </HashRouter>
}
// Home
// HomeIntroduction
// About
```

- 둘다 보이지 않으려면?
  - `exact={true}`

### Buildng the Navigation

```jsx
import Navigation from "./components/Navigation";

function App() {
  return <HashRouter>
    <Navigation />
    <Route path="/" exact={true} component={Home}/>
    <Route path="/about" component={About}/>

  </HashRouter>
}

export default App;
```

- Nav의 안좋은 예
  - a를 클릭할 때마다 refresh

```jsx
import React from "react";

function Navigation() {
    return(
        <div>
            <a href="/">Home</a>
            <a href="/about">About</a>
        </div>
    )
}

export default Navigation;
```

- Nav의 좋은 예
  - 불필요한 refresh 방지
  - **단, Link는 HashRouter 안에서만 사용가능**

```jsx
import React from "react";
import { Link } from "react-router-dom";

function Navigation() {
    return(
        <div>
            <Link to="/">Home</Link>
            <Link to="/about">About</Link>
        </div>
    )
}

export default Navigation;
```

- BrowserRouter는 HashRouter과 달리 #가 없음