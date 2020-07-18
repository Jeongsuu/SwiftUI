//
//  SecondView.swift
//  ObservableDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var timerData: TimerData
    
    
    // 관찰할 객체 지정, 객체를 생성하진 않았다.
//    @ObservedObject var timerData: TimerData = TimerData()
    
    var body: some View {
        // 수직 스택
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")                // 관찰중인 객체(ObservedObject) timerData가 Published 한 timeCount를 여기서 또 참조한다.
                .font(.headline)
        }
    .padding()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        
        SecondView().environmentObject(TimerData())
        
//        SecondView()
//        SecondView(timerData: TimerData())          // 여기서 객체를 생성하여 전달. -> 이건 상관없음, 뷰 내에서 인스턴스를 생성해도 된다.
    }
}
