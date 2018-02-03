## 한국에서 특히 유용한 javascript Regexp (regular expression)들

RegExp를 이용해서 validation 체크하는 방법은 여러 가지가 있다. HTML5는 똑똑해서 `pattern` 속성값에 해당 RegExp를 써주기만 해도 submit 눌렀을 때 경고를 띄워준다. 물론 늘 그렇듯 oninput, onchange로 바로바로 validation 알려주고 싶을 때에는 js 코드에서 조작을 하게 된다. 아무튼 어떤 경우에서든 유용히 사용될 수 있는 대표적인 한국적 RegExp 들을 소개한다.



1. **비밀번호 (password)**

   규정상 가장 흔한 비밀번호 조건은 영어소문자, 숫자 포함 8자 이상의 비밀번호.

   ```javascript
   input.value.match( /(?=.*\d)(?=.*[a-z]).{8,}/ )
   ```
   <br>

   ​

2. **비밀번호 확인 (password confirmation)**

   얘는 regexp 아니고 그냥 위 비밀번호와 일치 여부 보기. 단, 비밀번호가 valid한 경우에만. javaScript에서는 equals 메소드 없이 그냥 ==, ===로 String을 비교한다.

   ```javascript
   input.value === password.value
   ```
   <br>

   ​

3. **이메일 주소 (email)**

   @ 앞에는 영어소문자 . _ % + - 만 허용

   @ 골뱅이 필수. 

   @ 뒤 . 앞에는 영어소문자 . - 만 허용

   . 점 필수

   . 뒤에는 영어소문자 2자리 이상

   ```javascript
   input.value.match( /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/ )
   ```
   <br>

   ​

4. **휴대폰 번호 (phone number)**

   한국식으로 숫자 3자리. -필수. 숫자 4자리. -필수. 숫자 4자리. 형태이다.

   ```javascript
   input.value.match( /^[0-9]{3}[-]+[0-9]{4}[-]+[0-9]{4}$/ )
   ```
   다음과 같이 숫자 11자리를 인식해서 js코드로 -를 자동 삽입해줘도 좋은 UX가 될 것이다.

   ```javascript
   input.value.match( /^\d{11}$/ )
   /* 휴대폰 번호에 대시 삽입 */
   input.value = input.value.substr(0, 3) + "-" + input.value.substr(3, 4) + "-" + input.value.substr(7,4);
   ```

   ​

   <br>

   ​

5. **사업자 등록번호**

   휴대폰 번호와 거의 일치한다. 숫자만 바꿔주면 됨.

   ```javascript
   input.value.match( /^[0-9]{3}[-]+[0-9]{2}[-]+[0-9]{5}$/ )
   ```

