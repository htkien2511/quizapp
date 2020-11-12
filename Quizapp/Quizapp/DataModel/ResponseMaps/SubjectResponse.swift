//
//  SubjectResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class SubjectResponse: Mappable {
    
    var id: String?
    var name: String?
    var count: Int?
    var maxPoint: Int?
    var time: Int?
    var deadline: String?
    var data: [QuestionObj]?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        name <- map["ten"]
        count <- map["so_cau_hoi"]
        maxPoint <- map["diem_toi_da"]
        time <- map["thoi_gian"]
        deadline <- map["deadline"]
        data <- map["data"]
    }
    
    
}
