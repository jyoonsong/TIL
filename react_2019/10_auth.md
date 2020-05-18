### 1. HOC

들어갈 수 있는 페이지에 대한 통제는 HOC

- Auth(HOC)

  여기서 해당 유저가 해당 페이지에 들어갈 자격이 있는지 알아낸 후 자격이 되면 component로 가게 해주고 안되면 다른 페이지로 보내버린다

  - logged in component

```jsx
// _actions/types.js
export const AUTH_USER = "auth_user"
```

```jsx
// _actions/user_action.js
export function auth(dataToSubmit) {
  const request = axios.get("/api/users/auth")
  .then(response => response.data)
  
  return {
    type: AUTH_USER,
    payload: request
  }
}
```



```jsx
// _reducers/user_reducer.js
import {AUTH_USER} from "../_actions/types";

export default function(state = {}, action) {
  switch (action.type) {
      case: AUTH_USER:
	      return {...state, 
                userData: action.payload}
      	break;
    default:
      return state;
  }
}
```



```jsx
// auth.js
import {useDispatch} from 'react-redux'
import {auth} from "../_actions/user_action"

export default function(SpecificComponent, option, adminRoute = null) {
  
  function AuthenticationCheck(props) {
    
    const dispatch = useDispatch();
    
    useEffect(() => {
      dispatch(auth()).then(response => {
        console.log(response)
        
        if (!response.payload.isAuth) {
          // 로그인하지 않은 상태
          if (option === true) {
            props.history.push('/login')
          }
        }
        else {
          // 로그인한 상태
          if (adminRoute && !response.payload.isAdmin) {
            props.history.push("/")
          }
          else if (option === false) {
            props.history.push("/")
          }
        }
      });
    }, [])
  }
}
```

- SpecificComponent
  - 감쌀 component
- option
  - null 아무나 출입이 가능한 페이지
  - true 로그인한 유저만 출입이 가능한 페이지
  - false 로그인한 유저는 출입 불가능한 페이지
- adminRoute
  - null 아무나
  - true 어드민 유저만 ㅇㅇ
  - false 어드민 유저는 ㄴㄴ

```jsx
// App.js
import Auth from "./hoc/auth";

function App() {
  return (
  	<Router>
    	<div>
      	<Switch>
        	<Route exact path="/" component={Auth(LandingPage, null, )}/>
          <Route exact path="/login" component={Auth(LoginPage, false)}/>
          <Route exact path="/register" component={Auth(RegisterPage, false)}/>
        </Switch>
      </div>
    </Router>
  )
}
```



### 2. Middleware

파일 전송, 댓글 작성 같은 것은 API상 middleware 처리