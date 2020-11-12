//
//  AccountViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import Alamofire

class AccountViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lbInfoUser: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbClass: UILabel!
    @IBOutlet weak var lbMssv: UILabel!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbUserClass: UILabel!
    @IBOutlet weak var lbUserMssv: UILabel!
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    lazy var idUser: String = {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: "idUser") as! String
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        setUpElements()
        loadData()
    }
    
    func loadData() {
        let parameter: Parameters = [
            "id_user": idUser
        ]
        let _ = APIManager.sharedInstance.getInfoUser(queryParam: parameter) { (userResponse, error) in
            if let userResponse = userResponse as? UserResponse, let apiSuccess = userResponse.apiSuccess {
               if apiSuccess == false {
                    
                }
                else {
                    self.lbUserName.text = userResponse.name!
                    self.lbUserClass.text = userResponse.classUser!
                    self.lbUserMssv.text = userResponse.mssv!
                }
                
            } else if let errorMessage = error {
                
                print(errorMessage)
            }
        }
    }

    func setUpNavigation() {
        //self.title = "BK QUIZ"
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        navigationItem.titleView = imageView
    }
    
    func setUpElements() {
        containerView.shadow()
        containerView.corner(radius: 15)
        
        btnLogout.shadow()
        btnLogout.corner()
        btnChangePass.shadow()
        btnChangePass.corner()
        
        lbInfoUser.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 5)
        lbName.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 5)
        lbClass.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        lbMssv.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        lbUserName.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 5)
        lbUserClass.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        lbUserMssv.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        btnLogout.titleLabel?.shadow()
        btnChangePass.titleLabel?.shadow()
    }

    @IBAction func actionChangePass(_ sender: Any) {
        print("Change pass")
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        LoadingDialog.showLoadingDialog(self)
        // remove
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "idUser")
        
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.initStartApp()
        }
    }
    
}
