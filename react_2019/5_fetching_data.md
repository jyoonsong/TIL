### How are we going to fetch data?

- `fetch`
- `axios`
  - nice little layer on top of `fetch`
  - 땅콩 주위의 초콜릿 커버
  - `npm i axios`

- API
  - `https://yts-proxy.now.sh/list_movies.json`
    - like a mirror
    - url keep changes => error
- axios might be slow
  - we want to tell javascript that  the function that has it might take a little while
    - add `async`
    - add `await` for axios to finish



```jsx
import axios from "axios";

class App extends React.Component{
  getMovies = async () => {
    const { data: { data: {movies} }} = await axios.get("https://yts-proxy.now.sh/list_movies.json")
    // data.data.movies
    this.setState({ 
      movies: movies,
      isLoading: false
    })
  }
  componentDidMount() {
    this.getMovies(); // Network 탭의 header에서 확인 가능
  }
}
```



