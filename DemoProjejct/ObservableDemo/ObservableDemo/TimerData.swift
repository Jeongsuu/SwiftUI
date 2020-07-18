//
//  TimerData.swift
//  ObservableDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import Foundation
import Combine

// ObservableObject 프로토콜 구현 -> 관찰가능한 객체
class TimerData: ObservableObject {
    // 관찰가능한 객체가 게시할 프로퍼티 -> 다른 뷰에서 공통적으로 참조하기 위함.
    @Published var timeCount = 0            // Published 프로퍼티 래퍼를 사용하여 프로젝트 내에 있는 뷰에서 관찰 가능하도록 한다.
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
        // timer는 매 초 timerDidFire 함수를 호출한다.
    }
    
    @objc func timerDidFire() {
        timeCount += 1
    }
    
    func resetCount() {
        timeCount = 0
    }
}
