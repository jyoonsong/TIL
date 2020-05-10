### Component Life Cycle

- react class components has more than just a render method
  - **life cycle methods**
    - called before & after render function

> mounting

= being born

- `constructor()`

  - not from react. 

    when class is created **on javascript**
  
- `render()`

  - and then render

- `componentDidMount()`

  - when component renders, this function runs

> updating

= changing state

your fault! made by you.

`setState` 부르면 render => componentDidUpdate

- `shouldComponentUpdate()`
- `render()`
- `componentDidUpdate()`

> unmounting

= dying (e.g., replace)

- `componentWillUnmount()`





```jsx
class App extends React.Component{
  state = {
    count: 0
  }
	add = () => {
    this.setState(current => ({
      count: current.count + 1
    }))
  };
  minus = () => {
    this.setState(current => ({
      count: current.count - 1
    }))
  };

	constructor(props) {
    super(props)
    console.log("1")
  }
	componentDidMount() {
    console.log("3 component rendered")
  }
	componentDidUpdate() {
    console.log("3 I just updated")
  }
	componentWillUnmount() {
    console.log("Goodbye, I'm gone")
  }

  render() {
  	console.log("2 I am rendering")
	  return (<div>
      <h1>The number is {this.state.count}</h1>
      <button onClick={this.add}>Add</button>
      <button onClick={this.minus}>Minus</button>
    </div>
  )};
}
```



### Planning the Movie Component

```jsx
class App extends React.Component{
  state = {
    isLoading: true,
    movies: [] // good practice to declare, but not must-do
  }
  render() {
    const { isLoading } = this.state;
	  return (<div>
      {isLoading ? "Loading" : "We are ready"}
    </div>
  )};
	componentDidMount() {
    // fetch data and if we complete fetching it, we will set "isLoading" to false and render again
    setTimeout(() => {
      this.setState({
        isLoading: false
      }, 3000)
    })
  }
}
```





