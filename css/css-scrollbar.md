## CSS Scrollbar 없애기

윈도우 혹은 특정 브라우저에서 스크롤바가 다음과 같이 뜨는 경우가 있다:

![스크롤바 난장판](https://jandi-box.com/files-thumb/13597036/fe8868e9eca403a9d326e1ed41bdc3c3.png?size=640)

이는 간단한 CSS 코드로 쉽게 해결 가능한 문제이다.

1. **우선 스크롤이 아예 필요 없는 경우**

```scss
th, td {
  overflow: hidden;
}
```

2. **가로축만 스크롤 되게 하고 싶은 경우**

```scss
th, td {
  overflow-y: hidden;
  overflox-x: auto; // 스크롤 있는 경우에만 표시
}
```

3. **스크롤바만 없애되, 스크롤은 유지하고픈 경우**

```scss
th, td {
  -ms-overflow-style: none; // IE에서 스크롤바 감춤
  &::-webkit-scrollbar { 
    display: none !important; // 윈도우 크롬 등
  }
}
```




#### Ref

[https://stackoverflow.com/questions/3296644/hiding-the-scrollbar-on-an-html-page](https://stackoverflow.com/questions/3296644/hiding-the-scrollbar-on-an-html-page)

[https://developer.mozilla.org/en-US/docs/Web/CSS/overflow](https://developer.mozilla.org/en-US/docs/Web/CSS/overflow)