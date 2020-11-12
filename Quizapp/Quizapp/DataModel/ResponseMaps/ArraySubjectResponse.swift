//
//  ArraySubjectResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class ArraySubjectResponse: Mappable {
    
    var data: [SubjectResponse]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["array_subject"]
    }
    
    
}
