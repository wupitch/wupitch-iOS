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
    
    func makeCrewTitleLabel() {
        self.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22.adjusted)
        self.setTextWithLineHeight(text: self.text, lineHeight: 32.adjusted)
        self.textColor = .bk
    }
    
    func makeCrewSubTitleLabel() {
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        self.textColor = .gray02
    }
    
    func CrewAlertTitleLabel() {
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        self.textColor = .bk
    }
    
    func CrewNoPlaceLabel() {
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        self.textColor = .gray02
    }
    
}
