//
//  QuizViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import Alamofire

class QuizViewController: UIViewController {
    
    @IBOutlet weak var lbCount: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDeadline: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var btnResultBack: UIButton!
    @IBOutlet weak var resultContainerView: UIView!
    
    lazy var idUser: String = {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: "idUser") as! String
    }()
    var point: Float = 0
    var indexSubject = 0
    var isResult = false {
        didSet {
            if isResult {
                containerView.isHidden = true
                resultContainerView.isHidden = false
            }
            else {
                containerView.isHidden = false
                resultContainerView.isHidden = true
            }
        }
    }
    var data = SubjectResponse()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config() {
        self.title = data.name
        lbCount.text = "\(String(describing: data.count!))"
        lbTime.text = "\(String(describing: data.time!)) phút"
        lbDeadline.text = data.deadline
        
        containerView.layer.borderWidth = CGFloat(1)
        btnBack.layer.borderWidth = CGFloat(1)
        btnStart.layer.borderWidth = CGFloat(1)
        btnResultBack.layer.borderWidth = CGFloat(1)
        resultContainerView.layer.borderWidth = CGFloat(1)
    }
        
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func startAction(_ sender: Any) {
        let startQuizVC = StartQuizViewController()
        startQuizVC.questionData = data.data!
        startQuizVC.name = data.name!
        startQuizVC.time = data.time!
        startQuizVC.delegate = self
        startQuizVC.modalPresentationStyle = .fullScreen
        present(startQuizVC, animated: true, completion: nil)
    }
    
    @IBAction func resultBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}

extension QuizViewController: FinishQuiz {
    func finishQuiz(result: Int) {
        isResult = true
        point = Float(result) * Float(data.maxPoint!) / Float(data.data!.count)
        lbResult.text = "\(point)/\(data.maxPoint!)"
        
        let parameters: Parameters = [
            "id_user": idUser,
            "point": point,
            "id_subject": data.id,

        ]
        
        let _ = APIManager.sharedInstance.postCompletedSubject(queryParam: parameters) { (postHTTPResponse, error) in
            if let postHTTPResponse = postHTTPResponse as? PostHTTPResponse {
                if postHTTPResponse.success! {
                    //
                }
                else {
                    // show error message
                }
               
            } else if let errorMessage = error {

                print(errorMessage)
            }
        }
    }
    
    
}
