# 08 HIP

> 복습

심리학 아닌 HCI를 위한 쉬운 이론. 그 뒤에는 심리학적 배경. 이것이 부족해서 파고들어간 케이스도 있지만, 대부분은 이 모형을 쓰는 것으로 해결됨.

### 3 Subsystems

Simple Reaction Time 예측 가능

- Tp, Tc, Tm 한번씩
- 복잡한 리액션의 경우 각각이 여러번 씩 등장할 수 있음.

### Perceptual System

- physical 자극 => visual image store에 저장 

- decay time 200ms정도밖에 안됨. 그 이상 기억하도록 하는 UI라면 잘못될 확률이 높다.

- Variable Perceptual Processor Rate Principle

  > 교재 2장에 HIP 모델 어떻게 쓰는지 어떤 원리인지 Principles나옴. 읽어보면 됨.
  >
  > 이중 첫번째가 Variable Perceptual Processor Rate Principle

  - Tp는 range라는 것은 사람마다 condition마다 달라질 수 있다.

  - 자극의 크기에 반비례. intense한 자극에는 낮고, 검은 배경의 회색 점처럼 아주 희미한 자극에는 굉장히 높다. 이 50~200 범위를 벗어날 수도 있다.

  - 이 것의 특징 = Cycle Time

    똑같은 자극이 세 번 주루룩 들어온다 그럼 하나로 친다는 것.

  - **Bloch's Law**

    R(Perceptual Response)

    t가 cycle time안에 있을 때에는 constant가 된다.

  - ex. 아주 스무드한 걸 만들려면 저 안에 들어가게 만들어 줘야 함



---

### Working Memory

- capacity - 7+-2

  - pure 한 capacity라기보다는 longterm 등을 함께 사용하면 7+-2가 될 수 있다.

    pure한 걸 알긴 어려움.

  - decay time 보수적으로 5초 정도는 담지만 그 이상은 까먹는다. 

    되뇌이거나 손으로 쓰거나 하는 식으로 commit to  Longterm memory 해야 함.

  - decay rate 덜 보수적으로 7초 정도. 순수하게 working memory만 사용해서 기억하라 지시한다고 되는 게 아니기 때문에 사람들이 줄곧 long term memory 쓰려고 하곤 함.

- Chunks

  - 연상작용이 일어나 호환이 되어 working memory까지 올라온다.

  - 한 꼭지 딱 꺼내기 시작하면 줄줄이 들어옴. 그 고리가 강한지 아닌지에 따라.

  - 거꾸로 하라고 하면? 3 청크 정도.

    81 청크 하는 사람이 있더라.

### Long term Memory

- **semantic** (symbolic X visual X) 하게 인코딩되어 저장된다.
- 한꼭지에 따라 줄줄이 고리를 따라 나오게 구성되어 있다. 네트워크.
- Associative Access
  - 70ms
  - 10s - noisy해서 첫자만 기억나고 다 안기억나는 그런 케이스 발생. 기억을 꺼내는 리허설을 많이 하다보면 고리가 강해진다.
- 빨리 acquisition해서 넣으려고 할 때, 그냥 막 되뇌이는 것 vs 한국어 뜻 옆에 있는 것 vs 슬라이드 속에서 보는 것 이런 **context**가 어떤 것이냐에 따라 retrieval이 잘될지 안될지를 결정.
- 지울 수도 없고, decay도 거의 없다. 그런데 왜 기억을 못하는가? (코딩하다보면 dangling 문제 생기듯이.)

### Cognitive Processor

Cycle Time 두 개가 있는데

- Recognize : working memory 가져온다
- Act : Long term에서 가져와 motor processor에게 줄 명령어를 working memory에 넣는다.