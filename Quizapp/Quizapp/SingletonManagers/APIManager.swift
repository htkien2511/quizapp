//
//  APIManager.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager {
    static let sharedInstance = APIManager()
    var sessionManager:SessionManager
    
    init() {
        let config = URLSessionConfiguration.ephemeral
        config.httpCookieAcceptPolicy = .never
        //config.httpShouldSetCookies = false
        sessionManager = Alamofire.SessionManager(configuration: config)
    }
    
    func getValidSubjects(queryParam: Parameters, completion: @escaping (_ subjectResponse: Any?, _ error: Error?) -> ()) -> DataRequest? {
        let request = Router.getAllSubject(queryParams: queryParam)
        return sessionManager.request(request)
            .validate(statusCode: [404,200])
            .responseObject { (response: DataResponse<ArraySubjectResponse>) in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print("Error in getAllSubjects")
                    print(error)
                }
        }
    }
    
    func postCompletedSubject(queryParam: Parameters, completion: @escaping (_ subjectResponse: Any?, _ error: Error?) -> ()) -> DataRequest? {
        let request = Router.finishSubject(queryParams: queryParam)
        return sessionManager.request(request)
            .validate(statusCode: [404,400,200])
            .responseObject { (response: DataResponse<PostHTTPResponse>) in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print("Error in postCompletedSubject")
                    print(error)
                }
        }
    }
    
    func getCompletedSubjects(queryParam: Parameters, completion: @escaping (_ subjectResponse: Any?, _ error: Error?) -> ()) -> DataRequest? {
        let request = Router.getAllCompletedSubject(queryParams: queryParam)
        return sessionManager.request(request)
            .validate(statusCode: [404,200])
            .responseObject { (response: DataResponse<ArrayCompletedSubjectResponse>) in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print("Error in getCompletedSubjects")
                    print(error)
                }
        }
    }
    
    func checkLogin(queryParam: Parameters, completion: @escaping (_ userResponse: Any?, _ error: Error?) -> ()) -> DataRequest? {
        let request = Router.checkLogin(queryParams: queryParam)
        return sessionManager.request(request)
            .validate(statusCode: [404,400,200])
            .responseObject { (response: DataResponse<UserResponse>) in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print("Error in checkLogin")
                    print(error)
                }
        }
    }
    
    func getInfoUser(queryParam: Parameters, completion: @escaping (_ userResponse: Any?, _ error: Error?) -> ()) -> DataRequest? {
        let request = Router.getInfoUser(queryParams: queryParam)
        return sessionManager.request(request)
            .validate(statusCode: [404,400,200])
            .responseObject { (response: DataResponse<UserResponse>) in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print("Error in checkLogin")
                    print(error)
                }
        }
    }
}
