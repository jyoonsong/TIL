## 2. 작업환경 설정하기

- **프로젝트 생성**

  - **npm** - `npm install -g npm` 최신 버전으로 업데이트 해야 훨씬 빠르고 가벼움.
  - **Node JS**
  - 루트 폴더 생성 후 `npm init`

- **Dependency/Plugin**

  - **react** - Component를 만들 때 사용된다. `npm install —save react react-dom`

  - **babel** - ES6 지원하지 않는 환경에서 ES6을 사용할 수 있게 해줌

  - **webpack** - 모듈 번들러. 처음 브라우저 위에서 import/require 할 수 있게 해주며 js파일을 하나로 합쳐줌 (유사 - Browserify)

  - **webpack-dev-server** - webpack에서 지원하는 간단한 개발 서버로서 별도의 서버를 구축하지 않고도 웹서버를 열 수 있으며 hot-loader를 통하여 코드가 수정될 때마다 자동 리로드.

    글로벌 `npm install -g babel webpack webpack-dev-server`

    로컬 `npm install --save-dev babel-core babel-loader babel-preset-react babel-preset-es2015`

- **디렉토리 구조**

  ```bash
  root directory
  ├── package.json         
  ├── public            # 서버 public path
  │   └── index.html    # 메인 페이지
  ├── src               # React.js 프로젝트 루트
  │   ├── components    # 컴포넌트 폴더
  │   │   └── App.js    # App 컴포넌트
  │   └── index.js      # Webpack Entry point (webpack이 가장 먼저 읽어들임)
  └── webpack.config.js # Webpack 설정파일
  ```

- **컴파일러/서버 및 로더 설정**

  - **번들러** - entry부터 시작해 필요한 모듈들을다 불러와 한 파일로 합쳐 bundle.js에 저장

    ```javascript
    // webpack.config.js
    entry: './src/index.js',
    output: {
    	path: __dirname + '/public/',
    	filename: 'bundle.js'
    }
    ```

  - **서버 설정** - 개발 서버는 파일이 변동될 때마다 다시 컴파일하고 연결되어있는 브라우저를 새로고침해줌. webpack-dev-server가 이 개발서버를 열어줌.

    ```javascript
    // webpack.config.js
    devServer: {
    	inline: true,
    	port: 7777,
    	contentBase: __dirname + '/public/'
    }
    ```

    `npm start` 명령어를 입력했을 때 자동으로 webpack-dev-server가 실행되도록 수정.

    ```javascript
    // package.json
    "scripts": {
        "start": "webpack-dev-server --hot --host 0.0.0.0"
      },
    ```

  - **컴파일러** - 추가적으로 babel 모듈을 통하여 ES6 문법으로 작성된 코드를 ES5 형태로 변환도 해준다.

    ```javascript
    // webpack.config.js
    module: {
      loaders: [
        {
          test: /\.js$/,
          loader: 'babel-loader',
          exclude: /node_modules/,
          query: {
            cacheDirectory: true,
            presets: ['es2015', 'react']
          }
        }
      ]
    }
    ```

- **HTML/JS 기본 설정**

  - **index.html** - script 태그로 bundle.js 로드 (= webpack에 의해 React 라이브러리 및 기타 js 파일들이 하나로 번들링된 파일)

    ```html
    <script src="bundle.js"></script>
    ```

  - **src/components/App.js** - 컴포넌트

    - Naming Convention - 파일 및 컴포넌트 이름 대문자로 시작

    ```javascript
    import React from 'react'; // [ES5] var React = require('react');

    class App extends React.Component { 
    // [ES5] React.createClass() - method nest 불가. prototype 사용해야 했음.
    // 모든 Component는 React.Component를 상속
        render(){ // Component에 렌더링될 데이터를 정의
            return ( // 필수는 아니지만 가독성을 위해 괄호 사용 권장
            	<h1>Hello React Skeleton</h1>
              	// React JSX는 xml-like Syntax를 Native JavaScript로 변환해주므로 따옴표로 감싸지 않는다.
            );
        }
    }

    export default App; // module.export = App
    ```

  - **src/index.js** - App 컴포넌트를 불러와서 html의 엘레먼트(여기선 #root)에 렌더링 하는 부분

    ```javascript
    import React from 'react';
    import ReactDOM from 'react-dom';
    import App from './components/App';

    const rootElement = document.getElementById('root');
    ReactDOM.render(<App />, rootElement);
    ```

- **webpack-dev-server 구동하기**

  아까 설정해줬던 대로 `npm start` 명령어를 입력하면 됨. F5 없이 자동 새로고침 된다.
