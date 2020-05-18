### 개념

- Redux 데이터 Flow 

  - strict **unidirectional** data flow
  - action => reducer => store
  - action <=dispatch(action)= react component <=subscribe=store

- **action**

  - a plain object describing what happened

    ```js
    {
      type: "LIKE_ARTICLE", //좋아요했다
      articleId: 42
    }
    ```

- **reducer**

  - a function describing how the application's state changes

    ```js
    (previousState, action) => nextState
    ```

  - 이전 state가 action object를 거쳐 next state가 되었다.

- **store**

  - the object that brings state together
  - a store holds the whole state tree of your application
  - the only way to change the state inside it is to dispatch an action on it.
  - A store is not a class. It's just an **object** with few methods on it.

### vanilla-redux

```javascript
import { createStore } from "redux";

const ADD = "ADD";
const MINUS = "MINUS";

// reducer (data modifier)
const countModifier = (count = 0, action) => {
  switch (action.type) {
    case "ADD":
      return count + 1;
    case "MINUS":
      return count - 1;
    default:
      return count;
  }
}

// store (data storer)
const countStore = createStore(countModifier);

// 1. getState()
console.log(countStore.getState())

const handleAdd = () => {
  // 2. dispatch()
	countStore.dispatch({ type: ADD })
	// redux는 다음을 할 것: countModifier(0, {type: "ADD"})
}
const handleMinus = () => {
	countStore.dispatch({ type: MINUS }) // actions must have "type"
}

add.addEventListener("click", handleAdd)
minus.addEventListener("click", handleMinus)

// 3. subscribe
const onChange = () => {
	number.innerText = countStore.getState();
}
countStore.subscribe(onChange);
```

- how are we going to modify count?

  - with actions

  - action is a way that we communicate with the countModifier

    telling that he should return `count + 1` or `count - 1`

- how do you send action to the countModifier?

  - `store.dispatch(action)`

- You don't mutate previous state. You return a new state.

  - push, splice X
  - [...] , filter

### vanilla-redux example: TODO

```javascript
const ADD_TODO = "ADD_TODO";
const DELETE_TODO = "DELETE_TODO";

const addTodo = text => {
  store.dispatch({type: "ADD_TODO", text})
}

const deleteTodo = e => {
  const id = parseInt(e.target.parentNode.id);
  store.dispatch({type: "DELETE_TODO", id})
}

const reducer = (state = [], action) => {
  switch (action.type) {
    case ADD_TODO:
      return [{text: action.text, id: Date.now()}, ...state]; // push in the beginning of the array
    case DELETE_TODO:
      return state.filter(todo => todo.id !== action.id);
    default:
      return state;
  }
};

const store = createStore(reducer)

// paint
const paintTodos = () => {
  const todos = store.getState();
  ul.innerHTML = "";
  todos.forEach(todo => {
    const li = document.createElement("li");
    const btn = document.createElement("button");
    btn.innerText = "delete";
    btn.addEventListener("click", deleteTodo)
    li.id = todo.id
    li.innerText = todo.text
    
    li.appendChild(btn);
    ul.appendChild(li);
  })
}
store.subscribe(paintTodos);

const onSubmit = e => {
  e.preventDefault();
  const todo = input.value;
  input.value = "";
  addTodo(todo)
}

form.addEventListener("submit", onSubmit)
```

### react-redux

`npm install redux`

`npm install react-redux`

```jsx
// Home.js
import React, { useState } from "react";
import {connect} from "react-redux";
import {actionCreators} from "../store";

function Home({todos, addTodo}) {
  const [text, setText] = useState
  function onChange(e) {
    setText(e.target.value);
  }
  function onSubmit(e) {
    e.preventDefault();
    addTodo(text)
    setText("");
  }
  return (
    <div>
    	<h1>TODO</h1>
    	<form onSubmit={onSubmit}>
      	<input type="text" value={text} onChange={onChange}/>
      	<button>Add</button>
    	</form>
      <ul>{todos.map(todo =>
          <Todo key = {todo.id} {...todo} />
        )}</ul>
     </div>     
		
  );
}

function mapStateToProps(state) { // getState 역할
  return { todos: state };
}
function mapDispatchToProps(dispatch) {
	return { 
    addTodo: (text) => dispatch(actionCreators.addTodo(text))
  };
}
 
export default connect(mapStateToProps, mapDispatchToPropps)(Home);
```

```jsx
// store.js
import {createStore} from "redux";

const ADD = "ADD"
const DELETE = "DELETE"

const addTodo = text => {
  return {
    type: ADD,
    text
  }
}
const deleteTodo = id => {
  return {
    type: DELETE,
    id: parseInt(id)
  }
}

const reducer = (state = [], action) => {
  switch (action.type) {
    case ADD:
      return [{text: action.text, id: Date.now()}, ...state];
    case DELETE:
      return state.filter(todo => todo.id !== action.id);
    default:
      return state;
  }
}

const store = createStore();

export const actionCreators = {
  addTodo,
  deleteTodo
}

export default store;
```

```jsx
//index.js
import {Provider} from "react-redux";
import store from "./store"

ReactDOM.render(
	<Provider store={store}>
    <App/>
  </Provider>
)
```

```jsx
// Todo.js
import React from "react";
import {connect} from "react-redux"

function Todo({text, deleteTodo, id}) {
  return(
		<li>
      <Link to={`/${id}`}>
    	{text} <button onClick={deleteTodo}>DEL</button>
      </Link>
    </li>
  )
}

function mapDispatchToProps(dispatch, ownProps) {
	return { 
    deleteTodo: () => dispatch(actionCreators.deleteTodo(ownProps.id))
  };
}

export default connect(null, mapDispatchToProps) Todo;
```

```jsx
// Detail.js
import {useParams} from "react-router-dom";

function Detail({todo}) {
  const id = useParams();
  return <div>
    <h1>Detail</h1>
    {todo?.text}<br/>
    created at: {todo?.id}
  </div>
}

function mapStateToProps(state, ownProps) {
  const {match: {params: id}} = ownProps;
  return {todo: state.find(todo => todo.id === parseInt(id))}
}

export default connect(mapStateToProps)(Detail);
```

