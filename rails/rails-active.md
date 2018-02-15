## Rails에서 네비게이션에 Active 적용하기

Bootstrap이나 다른 UI 툴킷을 쓸 때, Navigation Item들 중 현재 페이지와 일치하는 녀석에 `active` 혹은 `current` 혹은 유사한 클래스를 입혀 표시해두는 경우가 많은데, 스타일링은 되어 있지만 연결은 따로 해주어야 한다. 

Rails에서는 이를 Helper 기능을 이용해서 간단히 처리한다. 네비게이션은 `application.erb`에 넣는다고 가정하였다.

```ruby
# application_helper.rb
module ApplicationHelper
  def current_class?(test_path)
    'active' if request.path == test_path
  end
end
```

위 코드에서 정의한 `current_class?(test_path)`는 현재 path와 파라미터 값이 일치하는지 판단해준다.

```erb
<!-- application.html.erb -->
<%= link_to "홈", home_path, :class => ["class1", "class2", current_class?(feeds_path)].join(" ") %>
```

만약 현재 페이지가 home과 일치하면 이는 아래와 같이 렌더링 될 것이다.

```html
<!-- rendered html -->
<a href="/home" class="class1 class2 active">홈</a>
```

