//
//  SportsBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit

class SportsBtn : UIButton {
    
    var status : Bool = false
    
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
        self.layer.cornerRadius = 8.adjusted
        status = false
    }
    
    func colorSportsBtn() {
        self.backgroundColor = .main20
        self.tintColor = .main
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.main.cgColor
        self.layer.cornerRadius = 8.adjusted
        status = true
    }
}


//extension CheckBtn {
//    private func layout() {
//        self.setImage(UIImage(named: "grayCheck"), for: .normal)
//        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
//    }
//
//    func changeBtnImg() {
//        if let checkImg = self.image(for: .normal) {
//            switch checkImg {
//            case UIImage(named: "grayCheck"):
//                status = true
//                self.setImage(UIImage(named: "check"), for: .normal)
//            case UIImage(named: "check"):
//                status = false
//                self.setImage(UIImage(named: "grayCheck"), for: .normal)
//            default:
//                break
//            }
//        }
//    }
//
//    func allAgreeBtnImg() {
//        self.setImage(UIImage(named: "check"), for: .normal)
//        status = true
//    }
//
//    @objc func touchUp() {
//        checkDelegate?.pushNext(btn: self)
//    }
//}



