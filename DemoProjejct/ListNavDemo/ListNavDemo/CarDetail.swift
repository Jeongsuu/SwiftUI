//
//  CarDetail.swift
//  ListNavDemo
//
//  Created by Yeojaeng on 2020/07/18.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import SwiftUI

struct CarDetail: View {
    
    let selectedCar: Car
    
    var body: some View {
        // 폼 컨테이너 뷰 : 뷰들을 그룹핑하고 섹션으로 나눌 수 있음.
        Form {
            // 헤더가 있는 섹션 생성
            Section(header: Text("Car Details")) {
                // 이미지 -> 사이즈 변경, 모서리 둥글게, 비율에 맞게
                Image(selectedCar.imageName)
                    .resizable()
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                // 텍스트 -> 자동차명
                Text(selectedCar.name)
                    .font(.headline)
                
                // 텍스트 -> 자동차 설명
                Text(selectedCar.description)
                    .font(.body)
                
                // 수평 스택
                HStack {
                    // Hybird 여부
                    Text("Hybrid")
                        .font(.headline)
                    Spacer()
                    Image(systemName: selectedCar.isHybrid ? "checkmark.circle" : "xmark.circle")
                }
            
            }
        }
        
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        CarDetail(selectedCar: carData[0])
    }
}
