## Component 생성 및 모듈화

> `src/components` 에 만들 컴포넌트에 대하여 알아보자

- `React.Component` 클래스를 상속하여 생성한다

  ```jsx
  class App extends React.Component {
      render(){
        return ();
      }
  }
  ```


- 한 파일엔 **여러 개의 컴포넌트**가 존재할 수 있다.

  ```jsx
  return  (
    <div>
      <Header/> {/* 컴포넌트 */}
      <Content/> {/* 컴포넌트 */}
    </div>
  );
  ```

- 한 파일엔 **여러 개의 class**가 존재할 수 있다. 하지만 유지보수 차원에서 비권장한다.

  ```jsx
  // src/components/App.js
  class App extends React.Component {
      render(){
          return  (
              <div>
                  <Header/>
                  <Content/>
              </div>
          );
      }
  }

  class Header extends React.Component {
      render(){
          return (
              <h1>Header</h1>
          );
      }
  }

  class Content extends React.Component {
      render(){
          return (
              <div>
                  <h2>Content</h2>
                  <p> Hey! </p>
              </div>
          );
      }
  }
  ```

- 따라서 `Header.js`와 `Content.js`를 생성하여 **모듈화**해준다. 모듈에서도 `react`를 import해주어야 하며, 모듈들은 export 해준다.

  ```jsx
  // src/components/Header.js
  import React from 'react';
  class Header extends React.Component {
      render(){
          return (
              <h1>Header</h1>
          );
      }
  }
  export default Header;
  ```

  ```jsx
  // src/components/Content.js
  import React from 'react';
  class Content extends React.Component {
      render(){
          return (
              <div>
                  <h2>Content</h2>
                  <p> Hey! </p>
              </div>
          );
      }
  }
  export default Content;
  ```

- 이제 export한 모듈을 `App.js`에서 import해준다.

  ```jsx
  import React from 'react';
  import Header from './Header';
  import Content from './Content';

  class App extends React.Component {
      render(){
          return  (
              <div>
                  <Header/>
                  <Content/>
              </div>
          );
      }
  }

  export default App;
  ```

  ​




#### Ref

React Official Documentation https://reactjs.org/docs/hello-world.html

Velopert React 강좌 https://velopert.com/