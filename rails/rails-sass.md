### SASS/SCSS 개발환경 세팅하기

> 기본 세팅

- Rails에는 SASS 젬이 자동으로 포함되어 있다. 따라서 따로 설치해줄 필요는 없으나, 배포 시에는 코드가 자동 압축되도록 `production.rb`에서는 아래와 같은 설정을 해주도록 하자.

  ```ruby
  # production.rb
  config.assets.css_compressor = :sass
  ```

- SASS를 사용하는 이유 중 하나는 모듈화된 **partial sass 파일을 import**할 수 있기 때문이다. 아래와 같은 디렉토리 구조를 따르면 이러한 SASS의 장점을 Rails가 디폴트로 제공하는 **Asset Pipeline과 조화**시킬 수 있다. 

  ```
  # directory structure
  +--- assets/
  |   +--- stylesheets/
  |       +--- /application.css
  |       +--- /main.scss
  |           +--- test/
  |               +--- /_test.scss
  ```

  `application.css`에서는 `require_tree .` 를 삭제해주는 대신 `main.scss` 파일을 포함시켜준다.

  ```scss
  # app/assets/stylesheets/application.css
  /*
   *= require_self
   *= require main
   */
  ```

  `main.scss`에서는 각 컴포넌트 단위 스타일 시트를 임포트 해준다.

  ```ruby
  # app/assets/stylesheets/main.scss
  @import 'test/test';
  ```

  `assets/stylesheets/test` 디렉토리를 만든 후 안에 `_test.scss`파일을 생성해준다.

  ```ruby
  # app/assets/stylesheets/test/_test.scss
  body {
    background: black;
  }
  ```

- `rails s`를 했을 때 뜨는 화면 배경색이 까맣다면 개발 환경이 성공적으로 세팅된 것이다.

<br>

>  외부 플러그인 붙이기

-  `vendor/assets` 폴더 안으로 다운받은 후,  `config/initializers/assets.rb` 에 vendor를 추가해준다

  ```ruby
  Rails.application.config.assets.paths << Rails.root.join('node_modules', 'vendor')
  ```

-  `application.js` 와 `application.css` 에서 해당 파일을 불러온다.

  ```js
  //= require material.min
  ```