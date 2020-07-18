# SwiftUI로 커스텀 뷰 만들기

<br>

SwiftUI 뷰를 사용함과 동시에 커스텀 뷰를 만들어 자신이 원하는 UI 레이아웃을 어떻게 선언하는지 배워본다.


<br>

## SwiftUI 뷰
---

UI 레이아웃은 뷰 사용과 생성, 그리고 결합을 통해 SwiftUI로 구성된다.

**뷰**는 View 프로토콜을 따르는 구조체로 선언된다.


구조체가 View 프로토콜을 준수하기 위해서는 `body` 프로퍼티를 가지고 있어야 하며, `body` 프로퍼티 안에 뷰가 선언되어야 한다.

SwiftUI에는 UI를 구축할 때 사용될 수 있는 다양한 뷰 (ex: TextLabel, TextField, Menu, Toggle...etc) 가 내장되어 있다.

해당 **뷰**들은 모두 View 프로토콜을 준수하는 독립적인 객체다.

<br>

## 기본 뷰 생성
---

SwiftUI 프로젝트를 생성하면 ContentView.swift 라는 파일이 생성된다.

해당 파일은 아래와 같은 기본 구조를 갖는다.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

`ContentView` 라는 이름을 가진 구조체는 View 프로토콜을 준수하며 필수 요소인 `body` 프로퍼티를 가지고 있다.

내부에는 내장 컴포넌트 `Text` 가 존재하며 해당 컴포넌트가 `body` 프로퍼티 내애 포함되어 있다.

이후 아래에 있는 `Preview` 구조체는 ContentView의 인스턴스를 생성하기 위해 필요하며, 프리뷰 캔버스에 보여지게 된다,

<br>

## 뷰 추가하기
---

`body` 프로퍼티 내에 원하는 뷰를 배치하여 다른 뷰를 추가할 수 있다.

하지만 `body` 프로퍼티는 단일 뷰를 반환하기 때문에 아래와 같이 2개 이상의 뷰를 사용하면 에러가 발생한다.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        Text("Hello, World!")
    }
}
```

뷰를 추가하기 위해서는 `stack` 혹은 `Form` 과 같은 **컨테이너 뷰**를 이용하여 내부에 뷰를 배치해야 한다.

이번 예제는 Vertical Stack에 두 개의 텍스트뷰를 배치해보도록 한다.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
        }
        
    }
}
```

수직 스택의 이름에서 알 수 있듯이, `VStack`으로 감싸진 뷰들은 수직 방향으로 순차적인 배치를 갖게된다.

<br>

## 하위 뷰로 작업하기
---

애플은 최대한 뷰를 작고 가벼운 상태를 유지하는 것을 권장한다.

이를 통해 재사용할 수 있는 컴포넌트 생성을 권장하고, 뷰 선언을 더욱 쉽게 관리하며, 레이아웃이 더욱 효율적으로 렌더링될 수 있도록 한다.

만일 우리가 만든 커스텀 뷰의 선언부가 복잡하다면 하위 뷰로 나눌 수 있는 부분을 찾아야한다.

아래 코드를 살펴보자.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Text 1")
                Text("Text 2")
                MyStackView()
            }
        }
        
    }
}

struct MyStackView: View {
    var body: some View {
        HStack {
            Text("Text 3")
            Text("Text 4")
        }
    }
}
```

위와 같이 ContentView 의 body 프로퍼티 내부에서 `MyStackView` 라는 하위 뷰를 호출하는 것을 확인할 수 있다.

호출되는 MyStackView는 ContentView 구조체 바로 아래에 구현되어있다.

<br>

### 뷰 변경하기
---

SwiftUI와 함께 제공되는 모든 뷰는 커스텀이 필요없을 정도로 우리의 입맛에 맞게 정확히 제공되는 것은 아니기 때문에 **수정자(Modifier)**를 뷰에 적용하여 커스텀이 가능하다.

수정자는 뷰의 모양 또는 동작을 변경하는데 사용된다.

수정자는 뷰의 인스턴스 메서드 형태를 취하며 원래의 뷰를 다른 뷰로 감싸는 방식으로 변경이 진행된다.

예를 들어, 다음은 Text 뷰의 폰트와와 포그라운드 색상을 변경하는 에시이다.

```swift
Text("Text 1")
    .font(.headline)
    .foregroundColor(.red)
```

마찬가지로, 다음 예제는 Image 뷰가 허용하는 공간 안에 이미지를 정비율로 표현하는 예시이다.
```swift
Image(systemName: "car.fill")
    .resizable()
    .aspectRatio(contentMode: .fit)
```

이러한 방식으로 수정자를 사용하여 각각의 컴포넌트에 대한 형태 또는 동작을 변경할 수 있다.

하지만, 수정잘르 사용할때에도 고려해야 하는 것이 하나 있다면 적용되는 순서다.

같은 수정자들을 어떠한 순서로 사용하냐에 따라 반환되는 레이아웃이 다르기 떄문에 적용 순서에 유의해야 한다.

<br>

### 커스텀 수정자
---

SwiftUI는 자신만의 커스텀 수정자 생성또한 가능하게 한다.

이는 뷰에 공통적으로 자주 적용되는 수정자들을 사용하고자 할 때 유용하다.

아래 예시는 뷰 선언부에 공통적으로 적용될 수정자라고 가정해보자.

```swift
Text("Text 1")
    .font(.largeTitle)
    .background(color.white)
    .border(Color.gray, width: 0.2)
    .shadow(Color: Color.black, radius: 5, x: 0, y: 5)
```

위와 같이 텍스트가 나올 때 마다 4개의 수정자들을 줄줄이 써주는 것보다는 이들 수정자들을 하나로 묶어서 필요할 때 마다 참조하는 것이 더욱 효율적이다.

```swift
struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.white)
            .border(Color.gray, width: 0.2)
            .shadow(Color: Color.black, radius: 5, x: 0, y: 5)    
    }
}
```

위와 같이 `ViewModifier` 프로토콜을 준수하는 구조체를 생성한다.

```swift
Text("Text 1")
    .modifier(StandardTitle())
Text("Text 2")
    .modifier(StandardTitle())
```

이후에는 `modifier()` 메서드를 통해 커스텀 수정자를 전달하여 사용하면 된다.

<br>

### 기본적인 이벤트 처리
---

앞서 우리는 SwiftUI가 데이터 주도적이라고 표현했다.

사용자가 애플리케이션과 마주하게 되는 뷰는 사용자가 조작할 때 발생하는 이벤트 처리는 여전히 필요하다.

예를 들어, `Button` 뷰는 버튼에 담길 내용과 함께 클릭이 감지되면 호출할 메서드도 선어해야한다.

다음 구현 예시는 Text 뷰를 감싸는 Button 뷰로, 클릭시 buttonPressed() 메서드가 호출된다.

```swift

struct ContentView: View {
    var body: some View {
        Button(action: buttonPressed() {
            Text("Click me")
        }
    }

    func buttonPressed() {
        // 동작 코드
    }
}
```
위와 같이 액션함수를 따로 지정하는 대신 클로저를 통해 액션 내용을 전달할 수 있다.

```swift
Struct ContentView: View {
    var body: some View {
        Button(action: {
            // 동작 코드
        }) {
            Text("Click me")
        }
    }
}
```

<br>

### onAppear() 그리고 onDisappear()
---

레이아웃 내에 뷰가 나타나거나 사라질 때 초기화 작업과 초기화 해제 작업을 수행하기 위하여 지정된 뷰 내에 액션 메서드들을 선언하기도 한다.

이름을 보면 알 수 있듯 위 내용은 onAppear() 메소드와 onDisappear() 메소드가 진행한다.

```swift

Text("Hello World")
    .onAppear(perform: {
        // 뷰가 나타날 때 수행할 코드
    }
    .onDisappear(perform: {
        // 뷰가 사라질 대 수행할 코드
    })
)
```

<br>

SwiftUI는 SwiftUI View 파일에 선언되며 View 프로토콜을 준수한다.

View 프로토콜을 따르기 위해서 구조체는 View 자신인 body 프로퍼티를 포함해야한다.

또한, SwiftUI는 UI 설계를 위해 내장 컴포넌트 라이브러리를 제공하며 뷰의 모양과 동작을 제어하기 위해서는 수정자(Modifier)를 이용한다.

수정자를 뷰에 적용하면 매번 새로운 뷰가 반환된다. 따라서 수정자를 적용하는 순서가 뷰의 모양에 중요한 영향을 주게 된다.


<br>

## Summary

- **뷰**는 View 프로토콜을 따르는 구조체로 선언된다.

- `ContentView` 라는 이름을 가진 구조체는 View 프로토콜을 준수하며 필수 요소인 `body` 프로퍼티를 가지고 있다.

- `Preview` 구조체는 ContentView의 인스턴스를 생성하기 위해 필요하며, 프리뷰 캔버스에 보여지게 된다,

- 애플은 최대한 뷰를 작고 가벼운 상태를 유지하는 것을 권장한다, 따라서 커스텀 뷰의 선언부가 복잡하다면 하위 뷰로 나눌 수 있을 경우 최대한 나누는 것이 좋다.

- 수정자는 뷰의 모양 또는 동작을 변경하는데 사용된다.

- 수정자 적용시에는 같은 수정자들을 어떠한 순서로 사용하냐에 따라 반환되는 레이아웃이 다르기 떄문에 적용 순서에 유의해야 한다.

- 뷰의 초기화 작업과 해제 작업은 onAppear(), onDisappear() 메소드가 처리한다.

