####1. React의 개념 및 Virtual DOM

- **React란?**
  - 재사용 가능한 UI를 생성할 수 있도록 해주는 라이브러리.
  - Virtual DOM 개념을 사용하여 상태의 변함에 따라 선택적으로 UI 렌더링 (최소한의 DOM 처리로 컴포넌트 업데이트)

- **Virtual DOM의 필요성**

  - DOM의 개념

    - Document Object Model 

    - 객체 => 구조화된 문서 (XML/HTML)

      웹 브라우저는 DOM을 활용하여 Object에 JavaScript와 CSS를 적용.

    - 트리 형태

      특정 node를 찾기, 수정, 제거, 삽입 가능

  - DOM의 문제점

    - 동적 UI에 불리.

      각 데이터를 표현하는 요소(element)들이 수없이 많은 경우 DOM에 직접 접근하여 변화를 주다보면 성능상의 이슈 발생(속도 저하)

    - Reflow/Repaint 때문

      DOM 자체는 빠름 but 브라우저 딴에서 DOM의 변화가 일어나면 다시 CSS를 연산하고 레이아웃을 구성하고 페이지를 리페인트하는 것이 느린 것.

      - **Reflow** - 레이아웃을 새로 구성하면서 계산하는 것

        ex) `element.offsetLeft`

        ex) `element.style.padding` (both)

      - **Repaint** - 색상 변경 등 레이아웃과 무관한 것

        ex) `element.style.color`

  - 브라우저가 하는 것과 못하는 것

    - 최적화 O

      그때그때 reflow는 비효율적. 짧은 시간 내에 여러 reflow가 발생하려고 할 시, 이 작업을 미루고 한꺼번에 처리하여 성능저하 단축

    - 최적화 X

      그러나 `offsetTop`, `scrollTop`, `getComputedStyle()` 등은 현재 값이 중요하므로 reflow가 여러 번 발생할 수 밖에 없음.

  - 해결법

    - DOM 작업을 **가상화**하여 미리 처리한 후, 한꺼번에 적용하자 => 최소한의 DOM 조작

    ​

- **Virtual DOM은 어떻게 작동**

  - 실제 DOM의 가벼운 사본

    실제 DOM에 접근하여 조작하는 대신, 이를 추상화시킨 JavaScript 객체를 구성하여 사용

  - 실제 DOM 업데이트 절차

    0) React에서 데이터가 변하면

    1) 전체 UI를 Virtual DOM에 리렌더링

    2) 이전 Virtual DOM에 있던 내용과 현재의 내용을 비교

    3) 바뀐 부분만 브라우저 상의 실제 DOM에 적용

- **React 특징 및 장단점**

  - 특징

    - Virtual DOM 사용

    - JSX 사용 

      JavaScript의 확장 문법. DOM 요소를 만들 때, JavaScript 형식으로 작성해야 하는 것을 XML과 유사한 형식으로 작성하게 해줌. 권장사항이지만 안 쓰면 불편.

    - Components

      React는 결국 Component에 관한 것. 모든 것을 Component로 생각하라.

  - 장점

    - Virtual DOM을 사용한 성능 향상
    - 클라이언트에서도 서버측에서도 렌더링 가능. 
      - 브라우저 측 초기 렌더링 딜레이 축소 
      - SEO호환도 가능해짐
    - Component의 가독성으로 쉬운 유지보수 가능
    - 라이브러리이므로 타 프레임워크와 사용 가능.

  - 제한

    - "지속해서 데이터가 변화하는 대규모 애플리케이션 구축"에 적절.
    - View레이어만 다루므로 이외의 부분은 다른 모듈 사용해야 함 (Ajax, Router 등)
    - React 버전 v15부터 IE8이하 버전을 지원하지 않음

- **webpackbin으로 React 맛보기**

  ```jsx
  // Hello.js
  import React from 'react' // var React = require('react');

  function Hello (props) { // Stateless Functions
    return (
      <h1>Hello from React {props.name}</h1> 
    )
  }

  export default Hello
  ```

  - webpack이라는 도구를 사용하여 require(import)로 모듈을 불러올 수 있음. (HTML은 script태그 사용)
    - Entry 파일에서 bundling 된다
  - Return 안에 따옴표가 없는 게 JSX의 특징
  - JSX에서 JavaScript 값을 렌더링할 때에는 `{}`로 감싸면 된다.

  ```jsx
  // main.js
  import React from 'react'
  import {render} from 'react-dom'
  import Hello from './Hello'

  render(<Hello name="jaeyoon"/>, document.querySelector('#app'))
  ```

  - webpack의 Entry

    - **Bundling** - main.js에서 이렇게 import(require)한 모듈들을 불러와서 재귀적으로 한 파일로 합침

  - Hello.js에서 만든 컴포넌트는 React-dom 모듈을 불러와 Render 함수로 페이지에 렌더링

    render( 파라미터1, 파라미터2)

    - 파라미터1 - 렌더링될 것. JSX형태 코드. `<컴포넌트명/>`
    - 파라미터2 - 렌더링할 곳. HTML 요소.

  ```html
  <!-- index.html -->
  <!doctype html>
    <html>
      <head>
        <meta charset="utf-8"/>
      </head>
      <body>
        <div id="app"></div> <!-- 여기에 Hello.js를 렌더링하게 됨 -->
        <script src="main.js"></script>
      </body>
    </html>
  ```

