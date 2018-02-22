# 컴포넌트 LifeCycle API

###1. 개념

**LifeCycle API**란, 컴포넌트가 DOM 위에 생성되기 전후 및 데이터가 변경되어 상태를 업데이트하기 전후로 실행되는 메소드들을 가리킨다.

- **컴포넌트 생성할 때**

  `constructor` >> `componentWillMount` >> `render` >> `componentDidMount`

- **컴포넌트 제거할 때**

  `componentWillmount`

- **컴포넌트의 prop이 변경될 때**

  `componentWillReceiveProps` >> `shouldComponentUpdate` >> `componentWillUpdate` >> `render` >> `componentDidUpdate`

- **컴포넌트의 state이 변경될 때**

   `shouldComponentUpdate` >> `componentWillUpdate` >> `render` >> `componentDidUpdate`


위 메소드 실행 순서를 정리하면 다음과 같다.

<img src="https://velopert.com/wp-content/uploads/2016/03/Screenshot-from-2016-12-10-00-21-26-1-768x493.png" alt="LifeCycle API 정리">

<br>



### 2. 각 메소드의 역할

#### 2.1. `constructor`

```jsx
constructor(props) {
  super(props);
  console.log("constructor");
}
```

컴포넌트가 처음 만들어질 때 실행. 이 메소드에서 기본 state를 정할 수 있음



#### 2.2. `componentWillMount` 

```jsx
componentWillMount() {
  console.log("componentWillMount")
}
```

컴포넌트가 DOM 위에 렌더링되기 전에 실행.




#### 2.3. `render` 

```jsx
render() {
  console.log("render")
}
```

컴포넌트를 DOM 위에 렌더링.



#### 2.4. `componentDidMount` 

```jsx
componentDidMount() {
  console.log("componentDidMount")
}
```

컴포넌트가 만들어지고 렌더링을 다 마친 후 실행. 이 안에서 다른 JavaScript 프레임워크를 연동하거나, `setTimeout`, `setInterval` 및 AJAX 처리 등을 넣는다.

 

#### 2.5. `componentWillReceiveProps` 

```jsx
componentWillReceiveProps() {
  console.log("componentWillReceiveProps")
}
```

컴포넌트가 prop을 새로 받았을 때 실행. prop에 따라 state를 업데이트해야할 때 사용하면 유용. 이 안에서 `this.setState()`를 하더라도 추가적으로 렌더링하지 않음.



#### 2.6. `shouldComponentUpdate` 

```jsx
shouldComponentUpdate(nextProps, nextState) {
  console.log("shouldComponentUpdate: " + JSON.stringify(nextProps) + " " + JSON.stringify(nextState));
  return true;
}
```

prop 또는 state가 변경되었을 때 리렌더링을 할지말지 정하는 메소드. 참고로 `JSON.stringify()`를 쓰면 여러 field를 편하게 비교할 수 있음. 위 예제에선 무조건 true를 반환하도록 하였지만, 실제로 사용할 때에는 필요한 비교를 하고 값을 반환하도록 함. 

예: `return nextProps.id !== this.props.id;`



#### 2.7. `componentWillUpdate` 

```jsx
componentWillUpdate(nextProps, nextState) {
  console.log("componentWillUpdate: " + JSON.stringify(nextProps) + " " + JSON.stringify(nextState))
}
```

컴포넌트가 업데이트되기 전에 실행. 이 메소드 안에선 `this.setState()`를 **사용해선 안됨** (무한루프 발생)



#### 2.8. `componentDidUpdate` 

```jsx
componentDidUpdate(prevProps, prevState) {
  console.log("componentDidUpdate: " + JSON.stringify(prevProps) + " " + JSON.stringify(prevState))
}
```

컴포넌트가 리렌더링(업데이트)을 마친 후 실행.



#### 2.8. `componentWillUnmount`

```jsx
componentWillUnmount() {
  console.log("componentWillUnmount")
}
```

컴포넌트가 DOM에서 사라진 후 실행.

