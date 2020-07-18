//
//  ContentView.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // ObservableObject 구독 -> 변화가 생기면 렌더링
    @ObservedObject var carStore: CarStore = CarStore(cars: carData)
    // JSON 데이터를 Car 배열로 변환한 값을 인자로 전달
    
    var body: some View {
        NavigationView{
            List {
                // ForEach문을 통해서 항목 생성
                ForEach(carStore.cars) { car in
                    ListCell(car: car)
                }
            .onDelete(perform: deleteItems)
            .onMove(perform: moveItems(from:to:))
            }
            .navigationBarTitle(Text("Car_Store"))
            .navigationBarItems(leading: NavigationLink(destination: AddNewCar(CarStore: carStore)) {
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// 자식 뷰
struct ListCell: View {
    
    var car: Car        // 상세 페이지 연결용 프로퍼티
    
    var body: some View {
        // 네비게이션 링크 -> 상세 페이지 연결
        NavigationLink(destination: CarDetail(selectedCar: car)) {
            // 수평 스택
            HStack {
                // 이미지 -> 사이즈 변경, 비율에 맞게,
                Image(car.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                // 텍스트 -> 자동차 이름
                Text(car.name)
            }
        }
        
    }
}

extension ContentView {
    func deleteItems(at offsets: IndexSet) {
        carStore.cars.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destionation: Int) {
        carStore.cars.move(fromOffsets: source, toOffset: destionation)
    }
}
