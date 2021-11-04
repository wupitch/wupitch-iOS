//
//  ModalSportsBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit

// 스포츠 바텀 시트
class ModalSportsBtn : UIButton {
    
    var status : Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultModalBtnStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultModalBtnStyle()
    }
    
    init() {
        super.init(frame: .zero)
        defaultModalBtnStyle()
    }
    
    func defaultModalBtnStyle() {
        self.layer.cornerRadius = 8.adjusted
        self.layer.borderWidth = 1.adjusted
        self.layer.borderColor = UIColor.gray02.cgColor
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.tintColor = .gray02
        self.backgroundColor = .none
        status = false
    }
    
    func changeModalBtn() {
        self.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.tintColor = .black
        self.layer.cornerRadius = 8.adjusted
        self.layer.borderWidth = 1.adjusted
        self.layer.borderColor = UIColor.bk.cgColor
        status = true
    }
    
}
