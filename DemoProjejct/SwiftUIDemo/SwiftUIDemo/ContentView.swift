//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK:- Properties
    var colors: [Color] = [.black, .red, .yellow, .orange]
    var colorNames: [String] = ["Black", "Red", "Yellow", "Orange"]
    
    // State Property
    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"
    
    
    //MARK:- View
    var body: some View {
        
        VStack {                        // 수직 스택 컨테이너
            Spacer()
            // 텍스트 뷰
            Text(text)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .rotationEffect(Angle(degrees: rotation))       // 상태 프로퍼티 rotation의 값이 변할때 마다 렌더링
                .animation(.easeInOut(duration: 5))
                .foregroundColor(self.colors[self.colorIndex])
            Spacer()
            Divider()           // 완벽한 분리를 위해 경계선 제공 -> Divider 뷰
            // 슬라이더 뷰
            Slider(value: $rotation)    // value: Binding<V>
                .padding()
            
            // 텍스트필드 뷰
            TextField("Enter text here", text: $text)      // 상태 프로퍼티 바인딩, 텍스트필드에 데이터 입력시 text 상태 프로퍼티에 저장
                .textFieldStyle(RoundedBorderTextFieldStyle())          // 텍스트 필드 스타일 지정
                .padding()
            
            // 피커 뷰
            Picker(selection: $colorIndex, label: Text("Color")) {
                ForEach(0 ..< colorNames.count) {       // 컬렉션으로 부터 동적으로 뷰를 생성하기 위해 ForEach문 사용
                    Text(self.colorNames[$0])
                        .foregroundColor(self.colors[$0])
                }
                
                
            }
        .padding()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
