//
//  PostHTTPResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/10/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class PostHTTPResponse: Mappable {
    
    var success: Bool?
    var response: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}
