//
//  CompletedSubjectResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class CompletedSubjectResponse: Mappable {
    var id: String?
    var name: String?
    var point: Float?
    var maxPoint: Float?
    var completedDay: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["ten"]
        point <- map["diem"]
        maxPoint <- map["diem_toi_da"]
        completedDay <- map["ngay_hoan_thanh"]
    }
    
    
}
