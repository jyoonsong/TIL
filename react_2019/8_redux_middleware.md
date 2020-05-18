### setting up redux

- dependencies

  - `npm install redux react-redux redux-promise redux-thunk --save`

  - 뒤 두 개는 middleware

    - 왜 필요한가?

      => a basic redux store will only accept dispatching **plain object actions**

      => But it doesn't always get plain object

      ​	ex) Promise, Functions 처럼 다양한 형태

      => So, a middleware can "**teach**" dispatch() how to **accept** something that is not a plain action object, by intercepting the value and doing something else instead.

      - redux-thunk "teaches" dispatch how to accept **functions** , by intercepting the function and calling it instead of passing it on to the reducers
      - redux-promise "teaches" dispatch how to accept **promises**, by intercepting the promise and dispatching actions when the promise resolves or rejects

- Redux 기본 구조(scaffolding) 만들기

  ```jsx
  // index.js
  import {Provider} from 'react-redux';
  import {applyMiddleware, createStore} from 'redux';
  import promiseMiddleware from 'redux-promise';
  import ReduxThunk from 'redux-thunk'
  
  import Reducer from './_reducers';
  
  // middleware와 함께 store를 만들어주자
  const createStoreWithMiddleware = applyMiddleware(promiseMiddleware, ReduxThunk)(createStore)
  
  ReactDOM.render(
  	<Provider
      store={createStorewithMiddleware(Reducer,
            window.__REDUX_DEVTOOLS_EXTENSION__ &&
  					window.__REDUX_DEVTOOLS_EXTENSION__())} // extension 연결
      >
      <App />
    </Provider>
  )
  
  ```

  ```jsx
  // reducers/index.js
  import {combineReducers} from 'redux';
  import user from './user_reducer';
  
  const rootReducer = combineReducers({
    user,
  });
  
  export default rootReducer;
  ```

  