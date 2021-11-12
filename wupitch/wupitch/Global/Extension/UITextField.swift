//
//  UITextField.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/25.
//

import UIKit

extension UITextField {
    
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 12, y: 12, width: 16, height: 16))
    self.leftView = paddingView
      self.rightView = paddingView
    self.leftViewMode = ViewMode.always
      self.rightViewMode = ViewMode.always
  }
    
    func loginVIewPadding() {
        let paddingView = UIView(frame: CGRect(x: 12, y: 12, width: 20, height: 20))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightViewMode = ViewMode.always
    }
    
}
