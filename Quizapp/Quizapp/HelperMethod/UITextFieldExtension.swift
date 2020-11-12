//
//  UITextFieldExtension.swift
//  AppCheckInByQRCode
//
//  Created by Hoang Trong Kien on 6/26/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

extension UITextField {
  
  enum Direction {
    case Left
    case Right
  }
  
  // add image to textfield
  func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
    let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    mainView.layer.cornerRadius = 5
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    view.backgroundColor = .white
    view.clipsToBounds = true
    view.layer.cornerRadius = 5
    view.layer.borderWidth = CGFloat(0)
    view.layer.borderColor = colorBorder.cgColor
    mainView.addSubview(view)
    
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 8, y: 3.0, width: 24.0, height: 24.0)
    view.addSubview(imageView)
    
    let seperatorView = UIView()
    seperatorView.backgroundColor = colorSeparator
    mainView.addSubview(seperatorView)
    
    if(Direction.Left == direction){ // image left
      seperatorView.frame = CGRect(x: 37, y: 0, width: 2, height: 30)
      self.leftViewMode = .always
      self.leftView = mainView
    } else { // image right
      seperatorView.frame = CGRect(x: 0, y: 0, width: 2, height: 30)
      self.rightViewMode = .always
      self.rightView = mainView
    }
    
    self.layer.borderColor = colorBorder.cgColor
    self.layer.borderWidth = CGFloat(0.5)
    self.layer.cornerRadius = 5
  }
  
}
