# SwiftUI 리스트와 네비게이션

List는 이름 그대로 수직 방향의 목록 형태로 사용자에게 정보를 제공한다.

기존의 UIKit 에서의 TableView 와 매우 흡사하다.

List 뷰에서 각 항목을 터치했을때 다음 페이지로 전환하는 방식은 네비게이션을 이용한다.

네비게이션은 `NavigationView` 컴포넌트와 `NavigationLink` 컴포넌트를 사용하여 구현한다.

List 뷰는 정적 데이터와 동적 데이터를 모두 표현할 수 있으며 추가, 삭제, 리오더링 등의 작업을 할 수 있도록 확장되기도 한다.

<br>

## SwiftUI 리스트
---

List 뷰에는 셀에 포함된 하나 이상의 뷰의 각 행을 수직 방향으로 목록화한다.

아래 예시를 살펴보자.

```swift
struct ContentView: View {
    var body: some View {
        List {
            Text("test 1")
            Text("test 2")
            Text("test 3")
            Text("test 4")
        }
    }
}
```

이를 프리뷰 캔버스로 살펴보면 기존 TableView와 동일한 형태라는 것을 알 수 있다.

리스트를 구성하는 셀에는 단 하나의 컴포넌트만 사용해야한다는 제약은 없다.

따라서, 여러 컴포넌트를 조합하여 하나의 셀을 구성할 수 있다.

정적 리스트 방식부터 살펴보도록 한다.

```swift
struct ContentView: View {
    var body: some View {
        List {
            HStack {
                Image(systemName: "trash.circle.fill")
                Text("Test 1")
                
            }
            HStack {
                Image(systemName: "person.2.fill")
                Text("Test 2")
            }
            HStack {
                Image(systemName: "car.fill")
                Text("Test 3")
            }
        }
    }
```

위 예시를 살펴보면 List 뷰를 구성하는 각각의 셀을 HStack을 통해 이미지와 텍스트가 순차적으로 나열되도록 하였다.

<br>

### SwiftUI 동적 리스트
---

동적 리스트는 시간이 지남에 따라 데이터가 변화해야 하는 항목들을 포함하는 리스트를 의미한다.

다시 말하여 항목이 추가, 편집, 삭제가 될 수 있고, 이러한 변화를 동적으로 반영하도록 리스트를 업데이트한다.

동적 리스트를 이용하려면 **Identifiable** 프로토콜을 따르는 클래스 혹은 구조체 내에 포함되어야 한다.

Identifiable 프로토콜을 사용하려면 리스트에서 각 항목을 식별할 수 있는 `id` 라는 프로퍼티가 객체 내에 존재해야한다.

`id` 프로퍼티는 다양한 타입으로 정의할 수 있으며 이번엔 UID를 기반으로 id 프로퍼티를 정의하는 예시를 살펴본다.

```swift

struct TodoItem: Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}
```

UUID() 를 이용하면 각 항목마다 고유한 ID를 자동으로 생성해주기 때문에 고유 식별이 가능하다.

위에서 생성한 TodoItem 구조체를 이용하여 데이터소스를 생성해본다.

```swift
.
.
var listItem: [Todoitem] = [
    TodoItem(task: "Take out trash", imageName: "trash.circle.fill"),
    TodoItem(task: "Pick up the kids", imageName: "person.2.fill"),
    TodoItem(task: "Wash the car", imageName: "car.fill")
]

struct contentView: View {
    var body: some View {
        List(listData) { item in
            HStack {
                Image(systemName: item.imageName)
                Text(item.task)
            }
        }
    }
}
.
.
```

위와 같은 방식으로 데이터소스를 활용하여 정적 리스트가 아닌 동적 리스트를 생성할 수 있다.

아래 예제에서는 정적 항목과 동적 항목 모두를 이용하는 리스트를 살펴본다.

```swift

struct ContentView: View {
    
    // State Property
    @State private var toggleStatus = true
    .
    .
    .
    var body: some View {
        List {
            // 정적 항목 토글 뷰
            Toggle(isOn: $toggleStatus) {
                Text("Allow Notifications")
            }

            // 동적 항목 listData 뷰
            ForEach(listData) { item in
                HStack {
                    Image(systemName: item.imageName)
                    Text(item.task)
                }
            }
        }
    }
}
```
정적 항목으로 Toggle 뷰를 생성하고 그 외 항목은 동적 항목으로 구성한다.

동적 항목은 ForEach 문을 통해 listData 배열을 순차적으로 순회하며 각각의 항목을 생성한다.

<br>

SwiftUI의 List 뷰에서는 Section 뷰를 이용하여 헤더와 푸터가 있는 섹션으로 나눌 수 있다.

```swift
struct ContentView: View {
    
    @State private var toggleStatus = true
    
    var body: some View {
        
        List {
            // 섹션 뷰 넣기.
            Section(header: Text("Settings")) {
                Toggle(isOn: $toggleStatus) {
                    Text("Allow Notification")
                }
            }
            
            // 섹션 뷰 넣기.
            Section(header: Text("Todo task")) {
                ForEach(listData) { item in
                    HStack {
                        Image(systemName: item.imageName)
                        Text(item.task)
                    }
                }
            }
        }
    }
}
```

섹션 뷰로 정적 항목과 동적 항목을 각각 감싸주고 헤더 뷰를 추가시켜줬다.

<br>

## NavigationView 와 NavigationLink
---

이제는 리스트 뷰를 구성하는 각각의 항목 터치시 다른 화면으로 이동하는 네비게이션 뷰에 대하여 알아보도록 한다.

리스트에 있는 항목을 터치했을때 다음 화면으로 이동하기 위해서는 일단 리스트를 `NavigationView`로 감싸줘야 한다.

이후 각 행에 `NavigationLink`로 감싸서 터치시 이동할 목적지 뷰를 전달해야한다.

아래 예시를 살펴보자.

```swift
var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                
                Section(header: Text("Todo task")) {
                    ForEach(listData) { item in
                        HStack {
                            Image(systemName: item.imageName)
                            Text(item.task)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Todo List"))
            .navigationBarItems(trailing: Button(action: addTask) {
                Text("Add")
            })
        }
    }
```

위와 같이 List를 NavigationView로 감싼다.

이후, NavigationBarTitle 과 NavigationBarItems 를 이용하여 적절히 꾸며준다.

```swift
struct ContentView: View {
    
    @State private var toggleStatus = true
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                Section(header: Text("Todo task")) {
                    ForEach(listData) { item in
                        HStack {
                            // 네비게이션 링크 추가
                            // 터치시 item.task 출력 뷰로 전환
                            NavigationLink(destination: Text(item.task)) {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Todo List"))
            .navigationBarItems(trailing: Button(action: addTask) {
                Text("Add")
            })
        }
    }
}
```

이후 ForEach문을 통해 동적 항목을 생성할 때, NavigationLink를 걸어준다.

이 때, 해당 셀 내에 보여질 데이터들은 NavigationLink 내부에 작성해야 한다.

<br>

### 편집 기능 제공하기
---

앱 내에서 리스트의 항목을 삭제하거나 다른 위치로 옮길 수 있도록 하는 기능은 일반적이다.

삭제 기능은 데이터 소스에서 해당 항목을 삭제하는 `.onDelete()` 수정자를 각각의 셀에 추가하면 활성화 할 수 있다.

onDelete 수정자를 호출하기 위해서는 파라미터로 삭제될 행의 offset 값을 갖는 IndexSet 객체를 전달해야한다.

따라서 ForEach 괄호 뒤에 아래와 같이 기재한다.
```swift
.onDelete(perform: deleteItem)
```

이후 `deleteItem` 이라는 함수를 정의한다.

```swift
func deleteItem(at offset: IndexSet) {
    // delete logic
}
```

다음으로 리스트의 항목 재정렬 기능을 제공하기 위해서는 데이터 소스에서 항목의 순서를 변경하는 `.onMove()` 수정자를 셀에 적용해야 한다.

해당 수정자는 이동할 행의 현재 위치를 담고 있는 IndexSet 객체와 이동하게 될 곳을 가리키는 정수를 전달한다.

```swift
import SwiftUI

// Data Model
struct TodoItem: Identifiable {
    var id: UUID = UUID()
    var task: String
    var imageName: String
}

// Dummy data
var listData: [TodoItem] = [
    TodoItem(task: "Take out trash", imageName: "trash.circle.fill"),
    TodoItem(task: "Pick up the kids", imageName: "person.2.fill"),
    TodoItem(task: "Wash the car", imageName: "car.fill")
]


struct ContentView: View {
    
    @State private var toggleStatus = true
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                Section(header: Text("Todo task")) {
                    ForEach(listData) { item in
                        HStack {
                            // 네비게이션 링크 추가
                            // 터치시 item.task 출력 뷰로 전환
                            NavigationLink(destination: Text(item.task)) {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                    // onDelete &  onMove
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .navigationBarTitle(Text("Todo List"))
        .navigationBarItems(trailing: EditButton())
        }
    }
}

extension ContentView {
    
    func deleteItem(at offset: IndexSet) {
        // delete logic
    }
    
    func moveItem(from source: IndexSet, to destionation: Int) {
        // move logic
    }

}
```

<br>

SwiftUI의 List 뷰는 셀을 포함하고 있는 각 항목을 나열할 수 있도록 한다.

List는 정적 항목과 동적 항목 또는 두 개의 항목을 조합한 형태로 만들 수 있다.

일반적으로 List 뷰는 다른 화면으로 이동할 수 있는 수단으로 사용되곤 한다.

화면 이동을 구현할 때는 NavigationView 와 NavigationLink를 활용한다.

또한, 리스트는 섹션으로 나눌 수 있으며, 바 타이틀, 바 버튼 등을 가질 수 있다.



<br>
<br>

## Summary
---

- List 뷰는 기존 TableView와 매우 흡사하다.
- 화면 전환은 네비게이션 방식을 이용하며 이는 NavigationView 와 NavigationLink를 이용한다.
- List 뷰를 구성하는 셀은 여러 컴포넌트를 조합하여 하나의 셀을 구성할 수 있다.
- 각 항목 내 데이터가 변화하는 동적 리스트를 이용할때는 **Identifiable** 프로토콜을 준수한다.
- Identifiable 프로토콜을 준수하기 위해서는 각각의 객체를 식별할 수 있는 `id` 프로퍼티를 구현해야한다.
- UUID() 를 이용하면 각 항목마다 고유한 ID를 자동으로 생성해주기 때문에 고유 식별이 가능하다.
- SwiftUI의 List 뷰에서는 Section 뷰를 이용하여 헤더와 푸터가 있는 섹션으로 나눌 수 있다.
- 삭제 기능은 데이터 소스에서 해당 항목을 삭제하는 `.onDelete()` 수정자를 각각의 셀에 추가하면 활성화 할 수 있다. 
- 재정렬 기능은 데이터 소스에서 항목의 순서를 변경하는 `.onMove()` 수정자를  셀에 적용해야 한다.