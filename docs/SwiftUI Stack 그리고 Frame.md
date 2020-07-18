#  SwiftUI 스택 그리고 프레임

<br>

UI 설계는 적절한 컴포넌트를 선택하고 뷰를 어떻게 배치할 지 결정한 뒤, 서로 다른 화면간 뷰들 간 이동을 구현하는 것이다.

앞서 살펴봤듯, SwiftUI에는 토글 뷰, 텍스트 필드, 버튼, 레이블, 슬라이더 등 앱 개발에 필요한 다양한 종류의 인터페이스 컴포넌트를 내장하고 있다.

또한 UI 구성방법과 화면의 방향 및 크기에 따라 대응하는 방법을 정의하는 레이아웃 뷰를 제공한다.

이번에는 대표적인 컨테이너 뷰 **StackView** 에 대하여 알아보며, UI를 보다 쉽게 설계하는 방법에 대해 알아보도록 한다.

<br>

## SwiftUI 스택
---

SwiftUI 가 기본적으로 제공하는 스택은 VStack(수직), HStack(수평), ZStack(중첩) 이 존재한다.

스택은 이름 그대로 차곡차곡 쌓아가는 방식이며 쌓인 컴포넌트들을 보여주는 방법만 다를 뿐이다.

아래 예시는 3개의 이미지 뷰가 HStack에 포함되는 코드다.

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "goforward.10")
            Image(systemName: "goforward.15")
            Image(systemName: "goforward.30")
        }
    }
}
```

코드가 매우 직관적이며 readable 하다.

위 코드를 프리뷰로 살펴보면 이미지 3개가 수평으로 표현된다.

마찬가지로, 수직 스택으로 동일하게 구현해보도록 한다.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "goforward.10")
            Image(systemName: "goforward.15")
            Image(systemName: "goforward.30")
        }
    }
}
```

이는 3개의 이미지가 수직방향으로 표현된다.

물론 스택 안에 스택을 포함시키는 것 또한 가능하다. -> 이를 통해 복잡한 레이아웃을 훨씬 수월하게 설계할 수 있다.

<br>

### Spacer, alignment, padding
---

SwiftUI에서는 뷰와 뷰 사이 공간을 추가히기 위한 `Spacer()` 컴포넌트를 갖고 있다.

Spacer를 이용하며 배치된 뷰들 사이 간격을 제공하며 간격의 방향은 스택의 방향에 따라 유연하게 확장/축소 된다.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        HStack(alignment: .top) {
            
            Text("Q1 sales")
                .font(.headline)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("January")
                Text("Febuary")
                Text("March")
            }
            
            Spacer()
        }
        
    }
    
}
```

위 코드를 보면 Stack을 선언할 때 마다 `alignment` 인자를 사용하고 있는 것을 볼 수 있다.

이는 이름 그대로 해당 스택의 정렬 기준을 정하는 것이다.

또한, Stack 선언시 `spacing` 값을 지정하여 내부 컴포넌트 별 간격을 조절할수도 있다.

뷰 주변의 간격은 `padding` 수정자를 통해 구현할 수 있다.

만일 padding에 매개변수를 제공하지 않으면 화면 크기에 맞춰 최적의 간격을 제공한다.


```swift
Text("Test 1")
    .padding()

Text("Test 1")
    .padding(10)

Text("Test 1")
    .padding(.top, 10)
```

위와 같이 아무 인자 없이 사용도 가능하고, 간격값을 직접 제공할수도 있고, 간격을 줄 위치를 지정할수도 있다.

<br>

## SwiftUI 프레임
---

뷰는 자신의 content와 자신이 속한 레이아웃에 따라 자동으로 크기가 조절된다.

대부분의 뷰의 크기과 위치는 스택 레이아웃을 통해 조절할 수 있지만 종종은 뷰 자체의 크기나 영역이 맞아야 하는 경우도 있다.

이러한 경우를 위해 SwiftUI는 `frame` 수정자를 제공한다.

```swift
Text("Hello World")
    .font(.largeTitle)
    .border(Color.black)
```

폰트와 경계선 색상을 변경한 텍스트 뷰다.

`frame` 수정자가 없으면 텍스트 뷰 내부 content에 따라서 크기가 조절된다.

하지만, Text뷰 의 프레임을 직접 지정하고 싶을때는 `frame` 수정자를 아래와 같이 사용한다.
```swift
Text("Hello World")
    .font(.largeTitle)
    .border(Color.black)
    .frame(width: 100, height: 100, alignment: .center)
```

위와 같이 작성할 경우, Text 뷰에는 프레임의 크기가 커스텀된다.

<br>

UI를 설계한다는 것은 컴포넌트들을 가져다가 직관적인 UX를 제공할 수 잇도록 화면에 배치하는 것이다.

이를 위해 SwiftUI는 몇 가지 레이아웃 뷰와 컴포넌트를 제공한다.

이번에는 레이아웃 스택 뷰와 프레임에 대해 간단히 알아보았다.

기본적으로, 뷰는 뷰 내부에 포함하는 content에 따라 크기가 정해진다. 만일 뷰가 사용할 공간이 충분하지 않은 경우에는 내부 content가 잘리게 된다.

이러한 경우에는 우선순위를 지정하여 원하는 content를 보여줄 수 있다.



<br>

## Summary
---

- SwiftUI에는 토글 뷰, 텍스트 필드, 버튼, 레이블, 슬라이더 등 앱 개발에 필요한 다양한 종류의 인터페이스 컴포넌트를 내장하고 있다.
- 스택 뷰는 SwiftUI에서 사용하는 대표적인 컨테이너 뷰이다.
- 스택 내에 스택을 포함시켜 복잡한 레이아웃을 훨씬 수월하게 설계할 수 있다.
- Spacer 와 padding을 통해 뷰와 뷰, 컴포넌트와 컴포넌트 사이 간격을 조절한다.
