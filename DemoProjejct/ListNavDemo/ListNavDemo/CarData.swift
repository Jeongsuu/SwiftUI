//
//  CarData.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import UIKit
import SwiftUI

// JSON 데이터를 스위프트 객체로 생성하기 위해 다른 곳에서 접근이 가능한 배열을 초기화하는 함수를 작성한다.

var carData: [Car] = loadJson("carData.json")

// Json -> 파일 -> 데이터 -> T타입 변환
func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else { fatalError("\(filename) not found.")}
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): (error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): (error)")
    }
    
}

/*
    loadJson 함수는 Decodable한 제네릭 타입이며 filename을 파라미터로 전달받아 T 타입을 반환한다.
 
 */
