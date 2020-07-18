//
//  Car.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

// JSON 데이터를 스위프트 객체로 변환하기 위해 Codable, 동적 리스트를 만들기 위해 Identifiable 채택
struct Car: Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var isHybrid: Bool
    var imageName: String
    
    // car 구조체는 Identifiable 프로토콜을 따르기 때문에 각 인스턴스는 List 뷰에서 식별될 수 있다.
}

