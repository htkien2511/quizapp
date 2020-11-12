//
//  QuestionObj.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionObj: Mappable, CustomStringConvertible {
    var question: String?
    var answer: [Answer]?
    var correctAnswer: Int?
    var description: String {
        return "Question: \(question)\nAnswer: \(answer) "
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        question <- map["cau_hoi"]
        answer <- map["tat_ca_dap_an"]
        correctAnswer <- map["dap_an_dung"]
    }
    
   
}

class Answer: Mappable, CustomStringConvertible {
    var description: String {
        return "\(String(describing: answer))"
    }
    
    var id: Int?
    var answer: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        answer <- map["dap_an"]
    }
    
    
}
