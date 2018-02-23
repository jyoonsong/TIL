# [실습] To-do List 부가설명 모음

### create-react-app

초심자는 Boilerplate보다는 페이스북에서 제공하는 create-react-app 템플릿에서 시작해보는 것도 좋다.

```shell
$ yarn global add create-react-app
$ create-react-app todo-list
$ cd todo-list
$ yarn start
```

<br>



### React Developer Tool

React 개발자도구 크롬 익스텐션 - [https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)

![리액트용 개발자도구](https://i.imgur.com/co0IYsI.png)

<br>



### 유용한 Sublime Text Plugins

- **Emmet for JSX**

  [https://gist.github.com/wesbos/2bb4a6998635df97c748](https://gist.github.com/wesbos/2bb4a6998635df97c748)에서 gist 복사 후,

  Sublime text3을 켜서 `Preferences - Key Bindings` 중 user 부분에 붙여넣기한다.

  혹시 그래도 안 될 경우 `"operand": "meta.group.braces.round.js, text.html",` 부분을

  `"operand": "source.js, text.html",` 로 바꿔준다.

- **Babel**

  Syntax에 `JavaScript (Babel)` 을 추가해준다.

  모든 js 파일에 적용하고 싶으면 `Users/mac/Library/Application Support/Sublime Text 3/Packages/User`의 `Preferences.sublime-settings`에서 `"ignored_packages": "javascript"` 넣어주면 된다.

- **Babel Snippets**

  React 컴포넌트 템플릿 등 Snippet 자동 완성 기능. `rcc` 치면 손으로 치던 거 다 나온다.

<br>



---

### Props

- `children` - 나중에 이 컴포넌트 사용 시 태그 사이의 내용이 들어간다.

- `form` - 인풋, 버튼을 JSX 형태로 전달해줄 것.

  ```jsx
  <TodoListTemplate form={<input><button>이렇게 말이죠</button>}>
        <div>여기는 children 자리입니다.</div>
  </TodoListTemplate>
  ```

<br>



### Template Component를 안 쓴다면?

```jsx
<TodoListWrapper>
  <Form/>
  <TodoList/>
</TodoListWrapper>
```

`TodoListTemplate ` 같은 Template 컴포넌트가 필요한 이유는 무엇일까? 요구사항은 아니지만 편하다.

예컨대 Form과 TodoList 사이에 구분선을 넣어주고 싶다면, Template 컴포넌트를 사용하는 경우 Template 내에서 주면 된다. 하지만 Wrapper같은 컴포넌트를 사용하는 경우 Form 혹은 TodoList 쪽에서 넣어주어야 한다.

<br>



---

### `e.stopPropagation()`

`onRemove`를 호출할 때 `e.stopPropagation()` 이 함께 호출된다. 이는 `onRemove` 뿐만 아니라 해당 DOM의 부모의 click event에 연결되어 있는 `onToggle`이 실행되는데, onRemove > onToggle 순으로 실행이 되면서 나는 오류를 방지하기 위함이다.

 `e.stopPropagation()` 는 **event의 확산을 멈춰주는 역할**을 한다. 즉 삭제부분에 전해진 click event가 해당 부모의 event로는 전달되지 않도록 해준다. 따라서 `onRemove`만 실행된 후 `onToggle`은 실행되지 않는 것이다.

<br>



### `onToggle/onRemove(id)` (아직)

```jsx
// NO
onClick={ onToggle(id) }
// YES
onClick={ () => onToggle(id) }
onClick={ (e) => {e.stopPropagation(); onRemove(id)} }
```

위처럼 작성할 경우 해당 함수가 렌더링될 때 호출이 되어버린다. 호출되면 데이터가 변경되고, 변경되면 리렌더링이되고, 리렌더링이 되면 호출이 되는 식으로 무한 루프가 생겨버림.

<br>



### Template Literals

```js
`string text
 multiple lines`
`string text ${expression} string text`
```

클래스명을 유동적으로 설정하고 싶을 때 사용한다. 

```js
// Same
`todo-text ${checked && 'checked'}` // true면 todo-text checked
"todo-text" + checked && "checked"  // false면 todo-text false
// false를 고치면
`todo-text ${checked? ' checked' : ''}` // false면 todo-text
// classnames 라이브러리 사용 시
className=classnames('todo-text', {checked})
```

<br>



---



### State Management (상태 관리)

우리 프로젝트에서 상태가 필요한 컴포넌트는 `Form`과 `TodoItemList`이다.

- **다음과 같이 리액트의 state를 각 컴포넌트에 넣어주어야 할까?**

  <img src="https://i.imgur.com/ckmex6Y.png" alt="잘못된 상태관리">

  NO! 다른 컴포넌트끼리 직접 데이터를 전달하는 것은 `ref`를 사용할 경우 할 수야 있겠으나 비효율적.

- **따라서 컴포넌트는 부모를 통해 대화해야 한다.**

  <img src="https://i.imgur.com/nnYKPBo.png" alt="바람직한 상태관리">

  이 경우 `App`이 두 컴포넌트의 부모 컴포넌트이므로 **`App`에 input, todos state**를 넣어주고, **각 컴포넌트에 해당 값들과 해당 값들을 업데이트하는 함수들을 props로 전달**해준다.

  > 나아가 나중에 배울 Redux는 오직 뷰만을 담당하는 컴포넌트(Presentational/Dumb Component)와, 상태관리를 담당하는 컴포넌트(Container/Smart Component)를 분리.

<br>



###배열에 데이터 추가하기 - `concat` (o) `push` (x)

`push`는 데이터 추가 후에도 가리키고 있는 배열이 같다. React에서는 최적화할 때 배열을 비교하여 같으면 리렌더링을 방지하는데, 이때 문제가 발생한다.

```js
let arrayOne = [];
let arrayTwo = arrayOne;
arrayOne.push(1);
console.log(arrayOne === arrayTwo); // true 
// push한 array1 [1] === 기존 array1 [1]
```

반면 `concat`은 새 배열을 만들기 때문에 괜찮다.

```js
let arrayOne = [];
let arrayTwo = arrayOne.concat(1);
console.log(arrayOne === arrayTwo); // false 
// 기존 array1 [] !== concat한 array1 [1]
```

https://jsfiddle.net/dfbnnLf1/11/ 참고.

<br>



### this 생략하기

```jsx
const {input, todos} = this.state; // state object 안에 있는 것들이므로
const {
  handleChange,
  handleCreate,
  handleKeyPress
} = this;
const { todos, onToggle, onRemove } = this.props;
```

혹은 그냥 this를 직접 일일이 붙여주어도 무방하다.

```jsx
return (
  <TodoListTemplate form={(
      <Form 
        value={this.state.input}
        onKeyPress={this.handleKeyPress}
        onChange={this.handleChange}
        onCreate={this.handleCreate}
        />
    )}>
    <TodoItemList todos={this.state.todos}/>
  </TodoListTemplate>
);
return (
  <TodoItem
    onToggle={this.props.onToggle}
    onRemove={this.props.onRemove}
  />
);
```

<br>



### 객체배열 > 컴포넌트배열 변환 - `map`, Destructuring Assignment, `key`

우리는 06map과 09함수형컴포넌트에서 각각을 익힌 적이 있다.

```js
// map
const todoList = todos.map(todo => todo*todo);
// Destructuring Assignment
({a, b, …rest}) = {a: 10, b: 20, c: 30, d: 40}; // rest={c:30, d:40}
```

이를 이용해 객체 배열을 컴포넌트 배열로 변환해보자. `todo`를 destructuring assignment로 나타내어 내부의 값들을 따로 레퍼런스해주었다.

```jsx
class TodoItemList extends Component {
  render() {
    const { todos, onToggle, onRemove } = this.props;

    const todoList = todos.map( // todos의 모든 todo마다
      ({id, text, checked}) => ( // todo object를 넣어주면
        <TodoItem {/* TodoItem 컴포넌트를 리턴*/}
          id={id}
          text={text}
          checked={checked}
          onToggle={onToggle}
          onRemove={onRemove}
          key={id}
        />
      )
    );

    return (
      <div>
        {todoList}    
      </div>
    );
  }
}
```

혹은 한꺼번에 전달할 수도 있다.

```jsx
const todoList = todos.map(
  todo => ( // {id: , text: , checked: }
  	<TodoItem
      {...todo} // 내부의 값들이 모두 자동으로 props로 설정이 된다
      onToggle={onToggle}
      onRemove={onRemove}
      key={todo.id}
    />
  )
);
```

이때 **배열을 렌더링할 때에는 key 값이 반드시 필요**하다. key 값이 있어야만 [컴포넌트가 리렌더링될 때 더욱 효율적으로 작동할 수 있다.](https://reactjs.org/docs/reconciliation.html#keys) 순서를 기억하고 있다가 새로이 추가된 것만을 리렌더링해줄 수 있기 때문이다.

<br>



### 배열 업데이트 - Spread Operator

배열을 업데이트할 때, push를 사용해선 안되는 것과 마찬가지의 이유로 **기존 배열의 값을 직접 수정하면 절대 안된다**.

```js
let arr1 = [ {value: 1}, {value: 2} ];
let arr2 = arr1;
arr2[0].value = 10;
console.log(arr1 === arr2) // true
```

따라서 Spread Operator(전개 연산자)를 통해 업데이트할 배열/객체의 내용을 복사해주어야 한다.

```js
// Spread Operator
myFunction(...iterableObj); // 함수 호출 시
[...iterableObj, 4, 5, 6];  // Array Literal
[a, b, ... iterableObj] = [1,2,3,4,5]; // Destructuring Assignment
```

```jsx
// src/App.js
handleToggle = (id) => {
  const { todos } = this.state;

  const index = todos.findIndex(todo => todo.id === id);
  const selected = todos[index]; // 선택한 객체

  const nextTodos = [...todos]; // 배열을 복사
  nextTodos[index] = { 
    ...selected, // 기존 값 복사
    checked: !selected.checked // checked 값만 덮어씌우기
  };

  this.setState({
    todos: nextTodos
  });
}
```

```jsx
// src/App.js
this.setState({
  todos: [
    ...todos.slice(0, index),
    {
      ...selected,
      checked: !selected.checked
    },
    ...todos.slice(index + 1, todos.length)
  ]
});
```

질문) 복사한 배열의 checked 값은 직접 바꿔도 되지 않은지? 이미 다른 배열이니.

<br>



### 배열 요소 삭제 - filter

```jsx
// src/App.js
handleRemove = (id) => {
  const {todos} = this.state;
  this.setState({
    todos: todos.filter(todo => todo.id !== id)
  });
};
```

<br>



---

### 최적화

render 안에 `console.log("rendered")`를 넣어보면 onChange처럼 렌더링이 필요없는 이벤트가 감지될 때에도 render함수가 매번 실행되고 있음을 알 수 있다. 물론 리액트에선 가상DOM을 사용하므로 render함수가 실행된다고 해서 DOM에 변화가 일어나는 것은 아니다. 하지만 대신 가상DOM에 render하는 자원이 미세하게 낭비되고 있는 셈. 따라서 **만약 업데이트가 불필요하다면 render를 아예 실행하지 않도록 하는 최적화** 작업이 필요하다. 데이터가 훨씬 많아지고 컴포넌트가 여러개가 되면 문제가 발생하기 때문.

```jsx
shouldComponentUpdate(nextProps, nextState) {
  return this.props.todos !== nextProps.todos;
}
shouldComponentUpdate(nextProps, nextState) {
  return this.props.checked !== nextProps.checked;
}
```

LifeCycle API 메소드 중 `shouldComponentUpdate` 는 컴포넌트가 리렌더링할지 말지 여부를 정해준다. 따로 구현되지 않으면 늘 true를 반환.

질문) checked말고 remove할 때에는 render함수 실행이 필요하지 않은지? onRemove가 직접적으로 포함된 것은 TodoListItem의 render함수이므로.