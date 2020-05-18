### 개념

- class components vs functional components 차이

  - lifecycle 
  - state

  => hooks 덕분에 functional component에서도 사용 가능해짐

```jsx
class Hello extends Component {
  constructor(props) {
    super(props);
    this.state = {name: ""};
  }
  
  componentDidMount() {
    axios.get("/api/user/name")
    .then(response => {
      this.setState({name: response.data.name})
    })
  }
  
  render() {
    return(
      <div>{this.state.name}</div>
    )
  }
}
```

```jsx
function Hello() {
  const [Name, setName] = useState("");
  
  useEffect(() => {
    axios.get("/api/user/name")
    .then(response => {
      setName(response.data.name)
    })
  })
  
  return(
    <div>{Name}</div>
  )
}
```



### 예시

```jsx
// LoginPage.js
import {useDispatch} from "react-redux";
import {withRouter} from "react-router-dom"

function LoginPage() {
  const dispatch = useDispatch();
  
	const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  
  const onEmailHandler = (event) => {
    setEmail(event.currentTarget.value)
  }
  const onPasswordHandler = (event) => {
    setPassword(event.currentTarget.value)
  }
  const onSubmitHandler = (event) => {
    event.preventDefault();
    
    console.log("Email", Email);
    console.log("Password", Password)
    
    let body = {
      email: Email,
      password: Password
    }
    
    dispatch(loginUser(body));
  }
  
  return(
  	<div>
    	<form onSubmit={onSubmitHandler}>
      	<label>Email</label>
        
      </form>
    </div>
  )
}

export default withRouter(LoginPage);
```

```jsx
// _actions/user_aaction.js
import axios from "axios";
import {LOGIN_USER} from "./types";

export function loginUser(dataToSubmit) {
  
    const request = axios.post("/api/users/login", body)
    .then(response => {
      response.data
    })
    
    return {
      type: LOGIN_USER,
      response: request
    }
}
```

```js
// _actions/types.js
export const LOGIN_USER = "login_user"
```

- previousState가 `body`
- action이 `loginUser` 안의 axios call

```js
// _reducers/user_reducer.js
import {LOGIN_USER} from "../_actions/types";

function (prevState = {}, action) {
  switch (action.type) {
    case LOGIN_USER:
      return {...state, 
              response: action.response}
      // {loginSuccess: true, userId: "adasf"}
      break;
    default:
      return state;
      break;
  }
}
```

