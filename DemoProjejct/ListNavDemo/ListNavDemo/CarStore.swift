//
//  CarStore.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI
import Combine

// Car 객체 배열 형식의 게시된 프로퍼티를 가지고 있으며, 초기화로 전달된 배열을 게시자로 한다.
class CarStore: ObservableObject {
    // 옵저버블 객체가 게시할 프로퍼티
    @Published var cars: [Car]
    
    init(cars: [Car] = []) {
        self.cars = cars
    }
}
