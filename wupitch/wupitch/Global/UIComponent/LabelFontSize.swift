//
//  LabelFontSize.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import Foundation
import UIKit

// 눌렀을 때 피커 올라오는 텍스트필드
class LabelFontSize : UILabel {
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        defaultLabelStyle()
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          defaultLabelStyle()
      }
      
      init() {
          super.init(frame: .zero)
          defaultLabelStyle()
      }
}

extension LabelFontSize {
    private func defaultLabelStyle() {
        self.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        self.textColor = .bk
    }
}
