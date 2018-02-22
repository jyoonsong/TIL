# ref로 DOM에 이름을 달아주자

###1. 개념

**ref**란, reference를 의미하며 DOM 요소에 이름을 달아준다. 

> HTML id와의 차이점

- HTML의 id와 사뭇 비슷하나, `id`는 일반 DOM 요소에 특정 DOM 메소드만 사용할 수 있는 반면, `ref`는 DOM 요소뿐만 아니라 컴포넌트에도 사용할 수 있으며 해당 컴포넌트가 가지고 있는 메소드 및 변수들을 사용할 수 있다.

> 언제 써야할까?

- 남용해서는 안된다! 비록 ref를 사용하면 코드가 간결해지기는 하나, **state/props로 해결할 수 없는 부분에서만 사용**하는 것이 바람직하다.
- 컴포넌트에 의해 렌더된 DOM에 직접 어떠한 처리를 해야할 경우
- 큰 프로젝트에 React 컴포넌트를 사용하는 경우. (예: 타 웹프레임워크와 혼용)

<br>



### 2. ref 사용하기

#### 2.1. 문자열 Attribute 사용 (deprecated)

```jsx
class Hello extends React.Component {
    render() {
        return (
          <div> 
            <input ref="myInput"> {/* ref="refName" 형식으로 ref 지정 */}
            </input>
          </div>
        )
    }
  
    componentDidMount() {
      this.refs.myInput.value = "Hi, I used ref to do this";
      // this.refs.refName 으로 접근 (컴포넌트가 렌더링 된 후에 사용해야 함!)
    }
}

ReactDOM.render(
  <Hello/>,
  document.getElementById('app')
);
```

#### 2.2. Callback 함수 사용

```jsx
class Hello extends React.Component {
  render() {
    return(
      <div>
        <input ref={ref => this.input = ref}></input>
      </div>
    )
  }
  componentDidMount() {
    this.input.value = "I used ref to do this";
  }
}

ReactDOM.render( <Hello/>, document.getElementById('app') );
```

- 지정 : `ref = {ref => this.refName = ref}`
- 사용 : `this.refName`

<br>



### 3. 예제

#### 3.1. 응용

위에서 ref와 HTML id의 차이는 일반 DOM요소뿐만 아니라 컴포넌트 자체에 적용하여 컴포넌트의 내장 메소드 및 변수를 사용할 수 있는 점이라고 했다. 그 예제를 살펴보도록 하자. (예시일 뿐 좋은 코드 아님.)

```jsx
class Hello extends React.Component {
  handleClick() {
    this.textBox.input.value = "I used ref";
  }
  render() {
    return (
      <div>
      	<TextBox ref={ref => this.textBox = ref}/>
        <button onClick={this.handleClick.bind(this)}>Click Me</button>
      </div>
    )
  }
}
class TextBox extends React.Component {
  render() {
    return(
      <input ref={ref => this.input = ref}></input>
    )
  }
}
ReactDOM.render( <Hello/>, document.getElementById('app') )
```

#### 3.2. ref를 사용하기 적절한 사례

```jsx
class Hello extends React.Component {
  handleClick() {
    this.input.value = ""; // input 초기화
    this.input.focus(); // input focus하는 DOM 메소드
  }
  render() {
    return (
      <div>
      	<input ref={ref => this.input = ref}/>
        <button onClick={this.handleClick.bind(this)}>Click Me</button>
      </div>
    )
  }
}
ReactDOM.render( <Hello/>, document.getElementById('app') )
```



