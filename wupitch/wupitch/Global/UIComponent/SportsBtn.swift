//
//  SportsBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit

// 스포츠 버튼
class SportsBtn : UIButton {
    
    var status : Bool = false
    
    // 버튼 아이디
    var btnId : Int?
    
    // 연령대
    var ageInt : Int?
    
    // 추가정보 아이디
    var extraId : Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSportsBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSportsBtn()
    }
    
    init() {
        super.init(frame: .zero)
        defaultSportsBtn()
    }
}

extension SportsBtn {
    func defaultSportsBtn() {
        self.backgroundColor = .gray04
        self.tintColor = .gray02
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
        self.makeRounded(cornerRadius: 8.adjusted)
        status = false
    }
    
    func colorSportsBtn() {
        self.backgroundColor = .main20
        self.tintColor = .main
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.main.cgColor
        self.makeRounded(cornerRadius: 8.adjusted)
        status = true
    }
    
    // 중복 가능한 버튼
    func graySportsBtn() {
        self.backgroundColor = .gray04
        self.tintColor = .gray02
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
        self.makeRounded(cornerRadius: 8.adjusted)
        status = false
        self.addTarget(self, action: #selector(touchUpBtn), for: .touchUpInside)
    }
    
    @objc func touchUpBtn() {
        changeBtn()
    }
    
    // 중복 가능한 버튼
    func changeBtn() {
        if self.status == false {
            self.colorSportsBtn()
        }
        else {
            self.defaultSportsBtn()
        }
        
    }
    
}
