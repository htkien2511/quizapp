//
//  UserResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/12/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: Mappable {
    
    var apiSuccess: Bool?
    var apiResonpse: String?
    var id: String?
    var name: String?
    var classUser: String?
    var mssv: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        apiSuccess <- map["success"]
        apiResonpse <- map["response"]
        id <- map["response._id"]
        name <- map["response.ten"]
        classUser <- map["response.lop"]
        mssv <- map["response.mssv"]
    }
}
