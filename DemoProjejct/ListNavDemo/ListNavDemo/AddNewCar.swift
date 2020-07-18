//
//  AddNewCar.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct AddNewCar: View {
    // 옵저버블 객체 구독
    @ObservedObject var CarStore: CarStore
    
    // State 프로퍼티 선언
    @State var isHybrid = false
    @State var name: String = ""
    @State var description: String = ""
    
    
    var body: some View {
        // 폼 컨테이너
        Form {
            // 헤더뷰를 갖는 섹션
            Section(header: Text("Car Details")) {
                // 이미지 -> 자동차, 사이즈 조정, 비율에 맞게
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                // 하위 뷰 생성
                // 상태 프로퍼티 바인딩 -> 값을 입력하면 각각의 상태 프로퍼티에 저장된다.
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                // 토글 뷰 생성, isHybrid 상태 프로퍼티 값에 저장
                Toggle(isOn: $isHybrid) {
                    Text("Hybrid")
                        .font(.headline)
                }.padding()
            }
            
            Button(action: AddNewCar) {
                Text("Add Car")
                
            }
        }
    }
}

extension AddNewCar {
    
    // Add Car 버튼 터치시 Action
    func AddNewCar() {
        let newCar = Car(id: UUID().uuidString, name: name, description: description, isHybrid: isHybrid, imageName: "tesla_model_3")
        
        // 구독한 객체가 publish한 프로퍼티 배열에 데이터 추가
        CarStore.cars.append(newCar)
        
    }
}


struct AddNewCar_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCar(CarStore: CarStore(cars: carData))
    }
}

// 자식 뷰
struct DataInput: View {
    
    var title: String
    // 부모 상태 프로퍼티에 접근하기 위함
    @Binding var userInput: String      // 상태 바인딩 -> 부모 뷰에서는 이게 각각 $name, $description 으로 바인딩 된다.
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
