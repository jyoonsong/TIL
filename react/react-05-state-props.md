# 컴포넌트의State와 Props 사용하기

###1. Props

`props`는 컴포넌트에서 사용할 데이터 중 **변동되지 않는 데이터(immutable data)**를 다룰 때 사용된다. (예컨대 setProps는 deprecated mehod) 
거의 대부분의 데이터를 표현하는 중요한 방법. (mutatable state들은 prop으로 대체 표현되거나 한 곳으로 몰아넣을 수 있다) 
**parent** 컴포넌트에서 **child** 컴포넌트로 데이터를 전할 때, `props`가 사용된다.

- **`props` 추가하기**

  `render()` 메소드 내부에 `{ this.props.propsName }` 형식으로 추가한다.

  ```jsx
  // src/components/Header.js
  import React from 'react';
  class Header extends React.Component {
      render(){
          return (
              <h1>{ this.props.title }</h1>
          );
      }
  }
  export default Header;
  ```


- **`props` 사용하기**

  컴포넌트를 사용할 때, `< >` 괄호 안에 `propsName = "value"`를 넣어 값을 설정한다. 

  `App` 컴포넌트에 props를 넣어주고, 해당 props 값을 child 컴포넌트들로 전달해준다.

  ```jsx
  // src/components/App.js
  import React from 'react';
  import Header from './Header';
  import Content from './Content';

  class App extends React.Component {
      render(){
          return  (
              <div>
                  <Header title={ this.props.headerTitle }/>
                  <Content title = { this.props.contentTitle}
                            body = { this.props.contentBody }/>
              </div>
          );
      }
  }

  export default App;
  ```

  ```jsx
  // src/index.js 에서 지정해줌
  import React from 'react';
  import ReactDOM from 'react-dom';
  import App from './components/App';
  
  const rootElement = document.getElementById('root');    
  ReactDOM.render(<App headerTitle = "Welcome!"
                       contentTitle = "Stranger,"
                       contentBody = "Welcome to example app"/>, rootElement);
  ```

- **기본값 설정하기**

  `props` 값을 임의로 지정해주지 않았을 때 적용될 디폴트 값을 설정할 때는,

  컴포넌트 클래스 하단에 `className.defaultProps = { propName: value }` 를 삽입한다.

  ```jsx
  // src/components/App.js
  import React from 'react';
  import Header from './Header';
  import Content from './Content';

  class App extends React.Component {
      render(){
          return  (
              <div>
                  <Header title={ this.props.headerTitle }/>
                  <Content title = { this.props.contentTitle}
                            body = { this.props.contentBody }/>
              </div>
          );
      }
  }

  App.defaultProps = {
      headerTitle: 'Default header',
      contentTitle: 'Default contentTitle',
      contentBody: 'Default contentBody'
  };

  export default App;
  ```

  ```jsx
  // src/index.js 에서 지정 안해줌
  import React from 'react';
  import ReactDOM from 'react-dom';
  import App from './components/App';
  
  const rootElement = document.getElementById('root');    
  ReactDOM.render(<App />, rootElement);
  ```


<br>



### 2. State 

컴포넌트에서 **유동적인 데이터**를 다룰 때 `state`를 사용한다. 

> React 어플리케이션을 만들 땐 `state`를 사용하는 컴포넌트의 개수를 최소화하도록 노력해야 한다. 예컨대 10개의 컴포넌트에서 유동적인 데이터를 사용할 땐, 각 데이터에 `state`를 사용할 게 아니라 `props`를 사용하고, 10개의 컴포넌트를 포함시키는 `container` 컴포넌트를 사용하는 것이 효율적이다.

- `state`의 **초기값**을 설정할 때는 `constructor` 메소드에서 `this.state = { }`
- `state`를 **업데이트**할 때는 `this.setState()` 메소드 사용. 
- `state`를 **렌더링**할 때는 `{ this.state.stateName }`

```jsx
import React from 'react';

class StateExample extends React.Component {
  constructor(props) {
    super(props); // `this.props`로 접근할 수 있게 해줌. 
    this.state = {
      header: "Header Initial State",
      content: "Content Initial State"
    };
  }
  updateHeader(text) {
    this.setState({
      header: "Header has changed"
    });
  }
  render() {
    return(
      <div>
        <h1>{this.state.header}</h1>
        <h2>{this.state.content}</h2>
        <button onClick={this.updateHeader.bind(this)}>Update</button>
      </div>
    );
  }
}
export default StateExample;
```

- `super`
  - `super()` : access and call functions on an object's parent (여기서는 React.Component가 parent) props를 접근하게 해줌.
  - `super(props)` : `this.props`로 접근하게 해줌. (참고 https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/super)
- `bind`  [참고](https://blog.andrewray.me/react-es6-autobinding-and-createclass/) 
  - ES6 class에서는 auto binding이 되지 않는다(관계를 상실한다). 즉 `this`가 무엇을 가리키는지 정확히 정의되지 않는다.
  - 따라서 setState 메소드를 사용하게 될 메소드(여기서는 updateHeader)를 `bind` 함으로써 관계를 정의해주어야 한다. 

<br>



### 3. 적용: Props & State 

> 유동적인 데이터를 렌더링 하며 parent 컴포넌트와 communicate하는 컴포넌트 RandomNumber를 만들어보자.

```jsx
// src/components/RandomNumber.js
import React from 'react';
import ReactDOM from 'react-dom';

class RandomNumber extends React.Component {
  constructor(props) { // React Component의 Constructor(생성자)
    super(props); // super로 상속 받은 React.Component의 생성자 메소드를 실행한 후
    this.updateNumber = this.updateNumber.bind(this); // update 메소드에서 this.props에 접근할 수 있도록 binding을 해준다
  }
  updateNumber() {
    let value = Math.round(Math.random()*100);
    this.props.onUpdate(value); // props로 받은 함수를 실행한다.
  }
  render() { 
    // 랜덤 숫자를 나타내는 h1 요소와 새로운 랜덤값으로 바꾸는 button 요소 렌더링
    // 두 가지 prop을 사용 (1)number (2)onUpdate
    return (
      <div>
        <h1>Random Number: {this.props.number}</h1>
        <button onClick={this.updateNumber}>Randomize</button>
        {/* 버튼을 클릭했을 시 update() 메소드를 실행한다 */}
      </div>
    )
  }
}
export default RandomNumber;
```

```jsx
// src/components/App.js
import React from 'react';
import ReactDOM from 'react-dom';
import Header from './Header';
import Content from './Content';
import RandomNumber from './RandomNumber'; // import

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: Math.round(Math.random()*100) // 초기 state 설정
    };
    this.updateValue = this.updateValue.bind(this);
    // updateValue() 메소드에서 this.setState에 접근할 수 있도록 바인딩
  }
  updateValue(randomValue) {
    this.setState({ // state 변경
      value: randomValue
    });
  }
  render() {
    return (
      <div>
        <Header title={ this.props.headerTitle }/>
        <Content title={ this.props.contentTitle }
          		  body={ this.props.contentBody }/>
        <RandomNumber number={ this.state.value }
          		onUpdate={ this.updateValue }/>
      </div>
    );
  }
}
App.defaultProps = {
    headerTitle: 'Default header',
    contentTitle: 'Default contentTitle',
    contentBody: 'Default contentBody'
};
export default App;
```

<br>



### 4. React에서의 데이터 흐름

- **React에서의 데이터흐름은**

  - **one-way data flow**

    Parent로부터 Child에게로 흐른다. DOM의 parent-child 관계와 거의 비슷하지만, DOM의 `node.parentNode`와 같은 API는 없으므로, 하위 컴포넌트는 상위 컴포넌트에 대해 거의 알 수 없음.

  - **Reactive**

    데이터의 갱신에 반응하여 뷰를 갱신한다.

- **props**

  





#### Ref

React Official Documentation https://reactjs.org/docs/hello-world.html

Velopert React 강좌 https://velopert.com/

[http://webframeworks.kr/tutorials/react/react-dataflow/](http://webframeworks.kr/tutorials/react/react-dataflow/)