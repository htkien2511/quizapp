//
//  Router.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case getAllSubject(queryParams: Parameters)
    case finishSubject(queryParams: Parameters)
    case getAllCompletedSubject(queryParams: Parameters)
    case checkLogin(queryParams: Parameters)
    case getInfoUser(queryParams: Parameters)
    
    static let quizAppServer = "http://localhost:5000"
    
    var method: HTTPMethod {
        switch self {
        case .getAllSubject, .getAllCompletedSubject, .getInfoUser:
            return .get
        case .finishSubject, .checkLogin:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getAllSubject:
            return "/user/subject"
        case .finishSubject:
            return "/user/completed-subject"
        case .getAllCompletedSubject:
            return "/user/completed-subject"
        case .checkLogin:
            return "/user/check-login"
        case .getInfoUser:
            return "/user"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.quizAppServer.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        print("-url: \(String(describing: urlRequest.url?.absoluteString))")
        
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getAllSubject(let queryParams):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParams)
        case .finishSubject(let queryParams):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: queryParams)
        case .getAllCompletedSubject(let queryParams):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParams)
        case .checkLogin(let queryParams):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: queryParams)
        case .getInfoUser(let queryParams):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParams)
        }
        
        return urlRequest
    }
}
