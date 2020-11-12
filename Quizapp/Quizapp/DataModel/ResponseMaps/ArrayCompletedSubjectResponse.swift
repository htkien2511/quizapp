//
//  ArrayCompletedSubjectResponse.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class ArrayCompletedSubjectResponse: Mappable {
    
    var data: [CompletedSubjectResponse]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["array_completed_subject"]
    }
    
    
}
