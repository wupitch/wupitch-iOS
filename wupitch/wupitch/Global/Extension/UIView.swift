//
//  UIView.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/24.
//

import UIKit

extension UIView {
// UIView 의 모서리가 둥근 정도를 설정
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
}
