//
//  NextBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/04.
//

import Foundation
import UIKit

// 다음 및 확인 버튼 스타일
class NextBtn : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        defaultNextBtnStyle()
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          defaultNextBtnStyle()
      }
      
      init() {
          super.init(frame: .zero)
          defaultNextBtnStyle()
      }
}

extension NextBtn {
    private func defaultNextBtnStyle() {
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        self.backgroundColor = .gray03
        self.titleLabel?.textColor = .wht
        self.makeRounded(cornerRadius: 8.adjusted)
    }
    
    func colorNextBtnStyle() {
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        self.backgroundColor = .main
        self.titleLabel?.textColor = .wht
        self.makeRounded(cornerRadius: 8.adjusted)
    }
}
