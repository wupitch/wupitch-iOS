//
//  DateBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class DateBtn : UIButton {
    
    var dateDelegate : DateDelegate?
    var dayId : Int?
    var status : Bool = false {
        didSet {
            status ? colorDateBtn() : grayDateBtn()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultDateBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultDateBtn()
    }
    
    init() {
        super.init(frame: .zero)
        defaultDateBtn()
    }
}

extension DateBtn {
    func defaultDateBtn() {
        self.backgroundColor = .gray04
        self.tintColor = .gray02
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
        self.makeRounded(cornerRadius: 8.adjusted)
        
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }
    
    @objc func touchUp() {
        self.status = !self.status
        dateDelegate?.clickDate(btn: self)
    }
    
    func colorDateBtn() {
        self.backgroundColor = .main20
        self.tintColor = .main
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.main.cgColor
    }
    
    func grayDateBtn() {
        self.backgroundColor = .gray04
        self.tintColor = .gray02
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
    }
}

protocol DateDelegate {
    func clickDate(btn:DateBtn)
}
