# [실습] To-do List

### 0. 환경 세팅

#### create-react-app

초심자는 Boilerplate보다는 페이스북에서 제공하는 create-react-app 템플릿에서 시작해보는 것도 좋다.

```shell
$ yarn global add create-react-app
$ create-react-app todo-list
$ cd todo-list
$ yarn start
```



###1. Components

#### 1.1. TodoListTemplate 

```jsx
// src/components/TodoListTemplate.js
import React from 'react';
import './TodoListTemplate.css';

const TodoListTemplate = ({form, children}) => {// 비구조화 할당
	return (
		<main className="todo-list-template">
			<div className="title">
				오늘 할 일
			</div>
			<section className="form-wrapper">
				{form}
			</section>
			<section className="todos-wrapper">
				{children}
			</section>
		</main>
	);
};

export default TodoListTemplate;
```

함수형 컴포넌트. 두 가지의 props 받음.

- `children` - 나중에 이 컴포넌트 사용 시 태그 사이의 내용이 들어간다.

- `form` - 인풋, 버튼을 JSX 형태로 전달해줄 것.

  ```jsx
  <TodoListTemplate form={<input><button>이렇게 말이죠</button>}>
        <div>여기는 children 자리입니다.</div>
  </TodoListTemplate>
  ```

> 이러한 Template 컴포넌트가 필요한 이유는 무엇일까? 요구사항은 아니지만 편하다.

- 안 쓴다면?

  ```jsx
  <TodoListWrapper>
    <Form/>
    <TodoList/>
  </TodoListWrapper>
  ```

  예컨대 Form과 TodoList 사이에 구분선을 넣어주고 싶다면, Template 컴포넌트를 사용하는 경우 Template 내에서 주면 된다. 하지만 Wrapper같은 컴포넌트를 사용하는 경우 Form 혹은 TodoList 쪽에서 넣어주어야 한다.

---

#### 1.2. Form

```jsx
import React from 'react';
import './Form.css';

const Form = ({value, onChange, onCreate, onKeyPress}) => {
  return (
    <div className="form">
      <input value={value} onChange={onChange} onKeyPress={onKeyPress}/>
      <div className="create-button" onClick={onCreate}>
        추가
      </div>
    </div>
  );
};

export default Form;
```

역시 함수형 컴포넌트. 네 가지의 props 받음.

- `value` - input value
- `onCreate` - button click 시 실행될 함수
- `onChange` - input 내용 변경 시 실행될 함수
- `onKeyPress` - input에서 키를 입력할 때 실행되는 함수. (이 함수는 enter키가 눌렸을 때 onCreate한 것과 동일하도록 설정하기 위한 것)

---

#### 1.3. TodoItemList

```jsx
import React, { Component } from 'react';

export class TodoItemList extends Component {
	render() {
		const { todos, onToggle, onRemove } = this.props;
		
		return (
			<div>
				
			</div>
		);
	}
}
```

동적인 데이터를 보여주는 경우에는 Class형 컴포넌트 작성. 그래야 나중에 컴포넌트 성능 최적화를 할 수 있기 때문. 세 가지의 props 받음.

- `todos` - 객체들이 들어 있는 배열
- `onToggle` - 체크박스를 켜고 끄는 함수
- `onRemove` - 아이템을 삭제시키는 함수

---

#### 1.4. TodoItem

```jsx
import React, { Component } from 'react';

export class TodoItem extends Component {
	render() {
		return (
			<div className="todo-item" onClick={() => onToggle(id)}>
				<div className="remove" onClick={(e) => {
					e.stopPropagation(); // onToggle이 실행되지 않도록 함
					onRemove(id)
				}}>&times;</div>
				<div className="{`todo-text ${checked && 'checked'}`}">
					<div>{text}</div>
				</div>
				{
					checked && (<div className="check-mark">&#x2713;</div>)
				}
			</div>
		);
	}
}
```

다섯 가지 props

- `text` - todo의 내용
- `checked` - 체크박스의 상태 (boolean)
- `id` - todo의 고유 아이디


- `onToggle` - 체크박스를 켜고 끄는 함수
- `onRemove` - todo item을 삭제시키는 함수

<br>



### 2. State Management (상태관리)

#### 2.1. 초기 State 정의

```jsx
// src/App.js
import React, { Component } from 'react';
import TodoListTemplate from './components/TodoListTemplate';
import Form from './components/Form';
import TodoItemList from './components/TodoItemList';


export default class App extends Component {

  id = 3 // 이미 0,1,2 가 존재하므로 3으로 설정

  state = {
    input: '',
    todos: [
      { id: 0, text: ' 리액트 소개', checked: false },
      { id: 1, text: ' 리액트 소개', checked: true }
      { id: 2, text: ' 리액트 소개', checked: false }
    ]
  }

  render() {
    return (
      <TodoListTemplate form={<Form/>}>
        <TodoItemList/>
      </TodoListTemplate>
    );
  }
}
```

---

#### 2.2. Form 기능 구현하기

Form에서 구현해야할 기능은 다음과 같다.

- 텍스트 내용 바뀌면 `onChange` => state 업데이트
- 버튼이 클릭되면 `onClick`(내장) => 새로운 todo 생성 후 `todos` 업데이트 `onCreate`
- 인풋에서 enter 누르면 `onKeyPress` => 버튼 클릭되면과 동일한 작업 진행 `onCreate`

```diff
// src/App.js
import React, { Component } from 'react';
import TodoListTemplate from './components/TodoListTemplate';
import Form from './components/Form';
import TodoItemList from './components/TodoItemList';


export default class App extends Component {

  id = 3 // 이미 0,1,2 가 존재하므로 3으로 설정

  state = {
    input: '',
    todos: [
      { id: 0, text: ' 리액트 소개', checked: false },
      { id: 1, text: ' 리액트 소개', checked: true }
      { id: 2, text: ' 리액트 소개', checked: false }
    ]
  }

+ handleChange = (e) => {
+   this.setState({
+     input: e.target.value // input 의 다음 바뀔 값
+   });
+ }

+ handleCreate = () => {
+   const { input, todos } = this.state;
+   this.setState({
+     input: '', // 인풋 비우고
+     // concat 을 사용하여 배열에 추가
+     todos: todos.concat({
+       id: this.id++,
+       text: input,
+       checked: false
+     })
+   });
+ }

+ handleKeyPress = (e) => {
+   // 눌려진 키가 Enter 면 handleCreate 호출
+   if(e.key === 'Enter') {
+     this.handleCreate();
+   }
+ }

  render() {
+   const { input } = this.state;
+   const {
+     handleChange,
+     handleCreate,
+     handleKeyPress
+   } = this;

    return (
      <TodoListTemplate form={
+      	<Form value={input} onKeyPress={handleKeyPress} 
+ 			  onChange={handleChange} onCreate={handleCreate}/>
      }>
        <TodoItemList/>
      </TodoListTemplate>
    );
  }
}
```

---

#### 2.3. TodoItem Iteration

이제 추가된 데이터를 화면에 보여주자. 이를 위해 우선 **`todos` 배열을 컴포넌트 배열로 변환**해주어야 한다. 배열 변환에는 `map`을 사용한다.

```diff
// src/App.js
  render() {
+   const { input, todos } = this.state;
    const {
      handleChange,
      handleCreate,
      handleKeyPress
    } = this;

    return (
      <TodoListTemplate form={(
        <Form 
          value={input}
          onKeyPress={handleKeyPress}
          onChange={handleChange}
          onCreate={handleCreate}
        />
      )}>
+       <TodoItemList todos={todos}/>
      </TodoListTemplate>
    );
  }
```

---

#### 2.4. 체크 하기/풀기

 배열의 값을 직접 수정하면 안된다. Spread Operator `[…spread]` 이용

```diff
// src/App.js
import React, { Component } from 'react';
import TodoListTemplate from './components/TodoListTemplate';
import Form from './components/Form';
import TodoItemList from './components/TodoItemList';


class App extends Component {

  (...)

+  handleToggle = (id) => {
+    const { todos } = this.state;
+
+    // 파라미터로 받은 id 를 가지고 몇번째 아이템인지 찾습니다.
+    const index = todos.findIndex(todo => todo.id === id);
+    const selected = todos[index]; // 선택한 객체

+    const nextTodos = [...todos]; // 배열을 복사

+    // 기존의 값들을 복사하고, checked 값을 덮어쓰기
+    nextTodos[index] = { 
+      ...selected, 
+      checked: !selected.checked
+    };

+    this.setState({
+      todos: nextTodos
+    });
+  }

  render() {
    const { input, todos } = this.state;
    const {
      handleChange,
      handleCreate,
      handleKeyPress,
+     handleToggle
    } = this;


----------


    return (
      <TodoListTemplate form={(
        <Form 
          value={input}
          onKeyPress={handleKeyPress}
          onChange={handleChange}
          onCreate={handleCreate}
        />
      )}>
+       <TodoItemList todos={todos} onToggle={handleToggle}/>
      </TodoListTemplate>
    );
  }
}

export default App;
```

---

### 2.5. 삭제하기

자바스크립트 배열의 내장함수인 `words.filter(word => condition)` 이용. condition이 true인 것만 남게 됨.

```diff
import React, { Component } from 'react';
import TodoListTemplate from './components/TodoListTemplate';
import Form from './components/Form';
import TodoItemList from './components/TodoItemList';


class App extends Component {
  (...)

+ handleRemove = (id) => {
+   const { todos } = this.state;
+   this.setState({
+     todos: todos.filter(todo => todo.id !== id)
+   });
+ }

  render() {
    const { input, todos } = this.state;
    const {
      handleChange,
      handleCreate,
      handleKeyPress,
      handleToggle,
+     handleRemove
    } = this;

    return (
      <TodoListTemplate form={(
        <Form 
          value={input}
          onKeyPress={handleKeyPress}
          onChange={handleChange}
          onCreate={handleCreate}
        />
      )}>
+       <TodoItemList todos={todos} onToggle={handleToggle} onRemove={handleRemove}/>
      </TodoListTemplate>
    );
  }
}

export default App;
```

<br>



### 3. 최적화

render 안에 `console.log("rendered")`를 넣어보면 onChange처럼 렌더링이 필요없는 이벤트가 감지될 때에도 render함수가 매번 실행되고 있음을 알 수 있다. 물론 리액트에선 가상DOM을 사용하므로 render함수가 실행된다고 해서 DOM에 변화가 일어나는 것은 아니다. 하지만 대신 가상DOM에 render하는 자원이 미세하게 낭비되고 있는 셈. 따라서 **만약 업데이트가 불필요하다면 render를 아예 실행하지 않도록 하는 최적화** 작업이 필요하다. 데이터가 훨씬 많아지고 컴포넌트가 여러개가 되면 문제가 발생하기 때문.

#### 3.1. TodoItemList 최적화

```jsx
import React, { Component } from 'react';
import TodoItem from './TodoItem';

class TodoItemList extends Component {

  shouldComponentUpdate(nextProps, nextState) {
    return this.props.todos !== nextProps.todos;
    // todos와 nextTodos가 다를 때에만 render함수 실행
  }

  render() {
    (...)
  }
}

export default TodoItemList;
```

#### 3.2. TodoItem 최적화

```jsx
import React, { Component } from 'react';
import './TodoItem.css';

class TodoItem extends Component {

  shouldComponentUpdate(nextProps, nextState) {
    return this.props.checked !== nextProps.checked;
  }

  render() {
    (...)
  }
}

export default TodoItem;
```

