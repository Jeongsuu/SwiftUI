# State 와 Observable

우리가 공부해 온 SwiftUI는 **데이터 주도적 방식** 이라고 했다.

이는 데이터와 UI 내 뷰 사이에 Publisher - Subscriber 모델이 존재하기에 가능한 일이다.

이를 위해 SwiftUI는 상태 프로퍼티, Observable 객체, 그리고 Environment 객체를 제공하며 이들 모두는 UI의 모양과 동작을 결정하는 상태를 제공한다.

SwiftUI 내에서 UI 레이아웃을 구성하는 뷰는 코드 내에서 직접 업데이트하지 않는다.

대신에, 뷰와 바인딩된 상태 객체가 시간이 지남에 따라, 현재 뷰 상황에 따라 그 상태가 자동으로 업데이트된다.

이번에는 상태 프로퍼티, Observable 객체, Environment 객체에 대하여 공부해보도록 한다.

### 상태 프로퍼티

---

**상태 프로퍼티** 란 상태에 대한 가장 기본적이 형태를 의미한다.

**즉, 뷰 레이아웃의 형태(ex: 토글 활성 여부, 텍스트 필드 내 데이터 존재 여부..etc) 를 저장하기 위해 사용한다.**

상태 프로퍼티는 `@State` 라는 프로퍼티 래퍼를 활용하여 아래와 같이 선언한다.

```swift
struct ContentView: View {

    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        ...
    }
}
```

상태 값은 해당 뷰에 종속되기 때문에 `private` 키워드를 이용해 선언한다.

따라서, 상태 프로퍼티의 값이 변경되었다는 의미는 뷰를 다시 렌더링해야 한다는 SwiftUI의 신호를 의미한다.

**상태 프로퍼티를 선언했다면 레이아웃에 있는 뷰와 바인딩 할 수 있다.**

바인딩된 뷰에서 어떠한 변경이 일어나면 해당 상태 프로퍼티에 자동적으로 반영된다. (데이터 주도적인 특징이란 대표적으로 이런것을 의미한다.)

예를 들어, 위 예시에서는 토글 뷰와 `wifiEnabled` 상태 프로퍼티값이 바인딩 되어있을 경우, 사용자가 토글 뷰를 조작하면 SwiftUI는 새로운 토글 설정값으로 상태 프로퍼티를 자동 업데이트한다.

상태 프로퍼티와의 바인딩은 `$` 사인을 이용한다.

아래 예제는 `TextView` 뷰와 `userName` 라는 상태 프로퍼티와의 바인딩 예제이다.

```swift
struct ContentView: View {

    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        VStack {
            TextField("Enter user name", text: $userName) 
            // State property Binding
        }
    }
}
```

TextField 와 userName 이라는 상태 프로퍼티가 바인딩되어 TextView에 유저가 어떠한 입력값을 전달하게 되면 해당 텍스트 값을 userName 프로퍼티에 저장하게 된다.

그리고 userName 상태 프로퍼티는 변화가 생겼으므로 SwiftUI에 의해 다시 렌더링된다.

아래 예시를 살펴보도록 하자.

```swift
struct ContentView: View {

    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {

        VStack {
            Toggle(isOn: $wifiEnabled) {
                Text("Enable Wi-Fi")
            }
            TextField("Enter user name", text: $userName)
            Text(userName)
            Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
        }

    }

}
```

`wifiEnabled` 와 `userName` 이라는 상태 프로퍼티가 선언되었다.

이후 수직 스택 컨테이너 내에 Toggle, TextField, Text, Image 뷰가 순차적으로 생성되었다.

Toggle 뷰의 경우 `isOn` 파라미터의 타입은 `Binding<Bool>` 로 바인딩이 가능한 Bool 타입이다.

따라서, 앞서 선언한 `wifiEnabled` 상태 프로퍼티값을 `$` 사인을 통해 바인딩 해주었다.

이후 TextField에서의 파라미터 `text` 의 타입은 `Binding<Strirng>` 타입이다.

이에 맞춰 `userName` 상태 프로퍼티를 `$` 사인을 통해 바인딩 해주었다.

이후에는 Text 뷰에 `userName` 값을 참조하여 출력해주도록 하고 Image 뷰는 삼항 연산자를 이용하여 `wifiEnabled`의 Bool 값에 따라 적절한 이미지를 출력하도록 한다.

실행해보면 알 수 있듯, 상태 프로퍼티값에 따라 뷰가 렌더링되는 것을 알 수 있다.

<br>

### 상태 바인딩

---

상태 프로퍼티는 `private` 키워드로 선언되기 때문에 선언된 뷰에서만 사용이 가능하다.

그러나, 어떤 뷰가 하나 이상의 하위 뷰를 가지고 있고 동일한 상태 프로퍼티에 대한 접근이 필요할 경우가 존재하는데 하위 뷰는 해당 상태 프로퍼티에 대한 참조가 불가능하다.

```swift
.
.
VStack {
    Toggle(isOn: $wifiEnabled) {
        Text("Enable WiFi")
    }
    TextField("Enter user name", text: $userName)
    WifiImageView()     // 자식 뷰 
    }
}
.
.
struct WifiImageView: View {

    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}
```

기존의 예제에서 이미지 뷰 부분을 하위 뷰로 분리하였다.

WifiImageView 내부에서 `wifiEnabled` 라는 상태 프로퍼티에 대한 참조가 필요하지만 분리된 하위 뷰는 이제 private scope 범위 밖에 존재한다.

즉, WifiImageView 입장에서 wifiEnabled는 정의되지 않은 변수인 것이다.

이러한 문제는 `@Binding` 프로퍼티 래퍼를 이용하여 상태 바인딩을 통해 해결이 가능하다.

```swift
struct WifiImageView: View {

    @Binding var wifiEnabled: Bool  // 상태 바인딩

    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}
```

이제 메인 뷰에서 하위 뷰가 호출될 때 상태 프로퍼티에 대한 바인딩 값만 전달하면 된다.

```
WifiImageView(wifiEnabled: $wifiEnabled)
```

<br>

### Observable 객체

---

상태 프로퍼티는 뷰의 상태를 저장하는데에 이용되며 선언된 뷰에서만 사용할 수 있다.

이러한 문제를 해결하기 위해 우리는 앞서 **상태 바인딩** 을 통해 부모 뷰와 자식 뷰 사이의 상태 프로퍼티를 공유하는 방법에 대해 알아보았다.

하지만 상태 프로퍼티는 일시적인 프로퍼티기 때문에 부모 뷰가 사라진다면 그 상태 또한 자연스레 사라진다.

애플은 이러한 경우를 위해 영구적인 데이터를 표현할 수 있도록 `Observable` 객체를 제공한다.

**Observable 객체는 다른 뷰에서의 접근 또한 가능하며 영구적인 데이터를 표현하기 위해 사용한다.**

Observable 객체는 `ObservableObject` 프로토콜을 따르는 클래스 혹은 구조체 형태다.

Observable 객체는 일반적으로 시간에 따라 변경되는 데이터 값을 모으고 관리하는 역할을 하며, 타이머 혹은 알람과 같은 이벤트 처리에 적합하다.

Observable 객체는 published Property로 부터 데이터 값을 게시한다.

Observer 객체가 Publisher를 구독하고, 게시된 프로퍼티가 변경될 때 마다 업데이트를 받는다.

이는 **Combine** 프레임워크를 이용하며 해당 프레임워크가 제공하는 Observable 객체를 활용하여 Publisher와 Subscriber간의 관계를 구축한다.

Observable 객체의 게시된 프로퍼티를 구현하는 가장 쉬운 방법은 프로퍼티 선언시 `@Published` 프로퍼티 래퍼를 활용하는 것이다.

**즉, 관찰가능한 객체(Observable Object)가 프로퍼티를 게시(@Pubhlished) 하면 관찰자(Observer)가 이를 구독하는 개념이다.**

```swift
import Foundation
import Combine

// 관찰가능한 객체(ObservableObject) 클래스 생성
class DemoData: ObservableObject {

    // 프로퍼티 게시
    @Published var userCount = 0
    @Published var currentUser = ""

    init() {
        // 데이터 초기화
        updateData()
    }

    func updateData() {
        // 데이터를 최산 상태로 유지하기 위한 코드
    }
}
```

이후 옵저버(Subscriber)는 observable 객체를 구독하기 위해 `@ObservedObject` 프로퍼티 래퍼를 사용한다.

위 예제 클래스의 인스턴스를 구독하는 예제는 아래와 같다.

```swift
import SwiftUI

struct ContentView: View {
    // ObservableObject demoData를 구독한다.
    @observedObject var demoData: DemoData
    

    var body: some View {
        // demoData는 ObservableObject이다.
        Text("\(demoData.currentUser), you are user number \(demoData.userCount)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(demoData: DemoData())
    }
}
```

관찰가능한 객체 `ObservableObject` 인스턴스를 생성하고, 해당 클래스에서 게시(@Published)한 프로퍼티를 참조한다.

게시된(@Published) 데이터가 변경되면 SwiftUI는 새로운 상태를 반영하도록 자동으로 뷰를 렌더링한다.

<br>

## Environment 객체
---

`@Published` 는 특정 상태가 앱 내 몇몇 SwiftUI 뷰에 의해 사용되어야 할 경우 적합하다.

하지만 어떠한 뷰에서 다른 뷰로 이동(navigation) 하는데 이동될 뷰에서도 동일한 구독 객체에 접근해야 한다면, 이동할 때 대상 뷰로 구독 객체에 대한 참조체를 전달해야 할 것이다.




## Summary

-   SwiftUI는 상태 프로퍼티, Observable 객체, 그리고 Environment 객체를 제공하며 이들 모두는 UI의 모양과 동작을 결정하는 상태를 제공한다.
    
-   SwiftUI의 뷰는 코드 내에서 직접 업데이트하지 않는다, 뷰와 바인딩된 상태 객체가 시간이 지남에 따라, 현재 뷰 상황에 따라 그 상태가 자동으로 업데이트된다.
    
-   상태 프로퍼티는 뷰 레이아웃의 형태(ex: 토글 활성 여부, 텍스트 필드 내 데이터 존재 여부..etc) 를 저장하기 위해 사용한다.
    
-   상태 프로퍼티의 값이 변경되었다는 의미는 뷰를 다시 렌더링해야 한다는 SwiftUI의 신호를 의미한다.
    
-   상태 프로퍼티는 레이아웃 내 뷰와 바인딩할 수 있다.
    
-   바인딩된 뷰에서 어떠한 변경이 일어나면 해당 상태 프로퍼티에 자동적으로 반영된다.
    
-   기본적으로 자식 뷰에서는 private 키워드로 선언된 부모 뷰의 상태 프로퍼티를 접근할 수 없다. 접근이 필요한 경우애는 **상태 바인딩** 을 이용하여 문제를 해결한다.
    
-   Observable 객체는 다른 뷰에서의 접근 또한 가능하며 영구적인 데이터를 표현하기 위해 사용한다.

-   관찰가능한 객체(Observable Object)가 프로퍼티를 게시(@Published) 하면 관찰자(Observer)가 이를 구독하는 개념이다.

- 여러 뷰에서 공유하고자 하는 데이터가 있을 경우, Observable한 Object 타입 내에 `@Published` 프로퍼티 래퍼를 활용하여 데이터를 선언한다. 이후 해당 데이터를 필요로 하는 곳에서 Observable Object 타입의 인스턴스를 생헝한다. 이때는, `@ObservedObject` 라는 프로퍼티 래퍼를 이용하여 **구독** 하겠다는 것을 표시한다. 이후에는 `Published` 된 데이터들을 `Observedobject.Published_Data` 방식으로 `.` 연산자로 접근하여 사용이 가능하다.

- 만일 게시된(`@Published`) 데이터가 변경되면 SwiftUI는 이를 자동으로 다시 렌더링한다.