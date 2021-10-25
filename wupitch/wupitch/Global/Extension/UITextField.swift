//
//  UITextField.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/25.
//

import UIKit

extension UITextField {
    
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 12, y: 12, width: 16, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
    
}
