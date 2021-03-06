//
//  TextFiledTapPicker.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import Foundation
import UIKit

// 눌렀을 때 피커 올라오는 텍스트필드
class tapTextField : UITextField {
    
    var status : Bool = false
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        defaultTapTextFiledStyle()
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          defaultTapTextFiledStyle()
      }
      
      init() {
          super.init(frame: .zero)
          defaultTapTextFiledStyle()
      }
}

extension tapTextField {
    func defaultTapTextFiledStyle() {
        // placehoder 색은 각자 주자
        self.tintColor = .clear
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        self.layer.borderColor = UIColor.gray02.cgColor
        self.layer.borderWidth = 1.adjusted
        self.makeRounded(cornerRadius: 8.adjusted)
    }
    
    func colorTapTextFiledStyle() {
        self.textColor = .main
        self.layer.borderColor = UIColor.main.cgColor
        status = true
    }
    
    func regionTextFieldStyle() {
        self.tintColor = .clear
        self.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderColor = UIColor.gray02.cgColor
        self.layer.borderWidth = 1.adjusted
        self.makeRounded(cornerRadius: 8.adjusted)
    }
}
