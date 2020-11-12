//
//  LoginViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import Alamofire

enum ErrorLogin: String {
    case mssvNil = "Mã số sinh viên không thể trống!"
    case passwordNil = "Mật khẩu không thể trống!"
    case mssvInvalid = "Mã số sinh viên không hợp lệ!"
    case mssvPasswordIncorrect = "Mã số sinh viên hoặc mật khẩu sai!"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var containerLoginView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbLogin: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var tfMssv: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var errorLogin: ErrorLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login View Controler")
        print(navigationController)
        tfMssv.delegate = self
        tfPassword.delegate = self
        setUpElements()
        setUpViewWhenKeyboardAppear()
        setUpImageViewInsideTextField()
    }
    
    func setUpImageViewInsideTextField() {
        changeImageView(textField: tfMssv, nameImage: "email")
        changeImageView(textField: tfPassword, nameImage: "password")
    }
    
    func changeImageView(textField: UITextField, nameImage: String) {
        if let myImage = UIImage(named: nameImage){
            textField.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.blue, colorBorder: UIColor.black)
        }
    }
    
    func setUpViewWhenKeyboardAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 200
            }
        }
        
        //
        let viewIsTap = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
        view.addGestureRecognizer(viewIsTap)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
        //
        view.gestureRecognizers?.removeAll(where: { (gestureRecognizer) -> Bool in
            return gestureRecognizer is UITapGestureRecognizer
        })
    }
    
    @objc func viewIsTapped() {
        view.endEditing(true)
    }
    
    func setUpElements() {
        containerLoginView.shadow()
        containerLoginView.corner(radius: 15)
        
        btnLogin.shadow()
        btnLogin.corner()
        
        lbLogin.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 5)
        lbEmail.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        lbPassword.shadow(color: UIColor.black.cgColor, opacity: 0.1, radius: 1)
        btnLogin.titleLabel?.shadow()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        view.endEditing(true)
        checkLogin()
    }
    
    func checkLogin() {
        let mssv = tfMssv.text!
        let password = tfPassword.text!
        guard mssv != "" else {
            showError(message: ErrorLogin.mssvNil.rawValue)
            errorLogin = .mssvNil
            return
        }
        guard password != "" else {
            showError(message: ErrorLogin.passwordNil.rawValue)
            errorLogin = .passwordNil
            return
        }
        guard checkMSSV(mssv: mssv) else {
            showError(message: ErrorLogin.mssvInvalid.rawValue)
            errorLogin = .mssvInvalid
            return
        }
        
        login(mssv: mssv, password: password)
    }
    
    private func checkMSSV(mssv: String) -> Bool {
        if mssv.count != 9 { return false }
        let num = Int(mssv)
        if num == nil { return false }
        return true
    }
    
    private func showError(message: String) {
        lbError.isHidden = false
        lbError.text = message
    }
    
    private func login(mssv: String, password: String) {
        LoadingDialog.showLoadingDialog(self)
        let parameters: Parameters = [
            "mssv": mssv,
            "password": password
        ]
        let _ = APIManager.sharedInstance.checkLogin(queryParam: parameters) { (userResponse, error) in
            if let userResponse = userResponse as? UserResponse, let apiSuccess = userResponse.apiSuccess {
                
                if apiSuccess == false {
                    self.errorLogin = .mssvPasswordIncorrect
                    self.showError(message: userResponse.apiResonpse!)
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismiss(animated: true) {
                            print("go to main")
                            let vc = CustomTabBarController()
                            UserDefaults().set(userResponse.id, forKey: "idUser")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                
            } else if let errorMessage = error {
                
                print(errorMessage)
            }
        }
    }
}

// MARK: - Text Field Delegate
extension LoginViewController: UITextFieldDelegate {
    // move into password textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            checkLogin()
        }
        return true
    }
    
    // ẩn thông báo lỗi khi nhập mới email hoặc password
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard errorLogin != nil else { return }
        let isEmailError = errorLogin == ErrorLogin.mssvNil ||
            errorLogin == ErrorLogin.mssvPasswordIncorrect
        let isPasswordError = errorLogin == ErrorLogin.passwordNil ||
            errorLogin == ErrorLogin.mssvPasswordIncorrect
        let isEmailInValid = errorLogin == ErrorLogin.mssvInvalid
        
        if textField == tfMssv {
            if isEmailInValid && textField.text?.count == 9 {
                lbError.isHidden = true
            }
            else if isEmailError {
                lbError.isHidden = true
            }
        }
        else if textField == tfPassword && isPasswordError {
            lbError.isHidden = true
        }
    }
}
