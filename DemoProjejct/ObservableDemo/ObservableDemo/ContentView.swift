//
//  ContentView.swift
//  ObservableDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // 관찰할 객체 = TimerData 인스턴스
//    @ObservedObject var timerData: TimerData = TimerData()
    
    // Environment로 생성하면 여러개의 뷰에 위와같이 객체를 생성하지 않아도 접근할 수 있다.
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        
        // 네비게이션 뷰
        NavigationView {
            
            // 수직 스택
            VStack {
                Text("Timer count = \(timerData.timeCount)")        // ObservedObject인 timerData가 게시(@Published)하는 timeCount 프로퍼티 참조.
                    .font(.largeTitle)
                    .fontWeight(.bold)
                .padding()
                
                // 버튼 생성, 터치시 resetCount 실행,
                Button(action: resetCount) {
                    Text("Reset Counter")
                }
                
                .padding()
                
                // Environment 버전 -> 아래처럼 객체를 생성하지 않아도 된다.
                NavigationLink(destination: SecondView()) {
                    Text("Navigation Link")
                    
                   // Observable 버전
//                NavigationLink(destination: SecondView(timerData: timerData)) {
//                    Text("Navigation Link")
                }
                
            }
        }
    }
    
    func resetCount() {
        timerData.resetCount()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView().environmentObject(TimerData())
    }
}
