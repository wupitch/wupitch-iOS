//
//  GusetDataBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/06.
//

import UIKit

// 손님신청버튼
class GuestDateBtn : UIButton {

    var status : Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultCheckStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultCheckStyle()
    }
    
    init() {
        super.init(frame: .zero)
        defaultCheckStyle()
    }
}

extension GuestDateBtn {
    func defaultCheckStyle() {
        self.setImage(UIImage(named: "grayRadio"), for: .normal)
        status = false
    }
    
    func changeBtnImg() {
        self.setImage(UIImage(named: "radio"), for: .normal)
        status = true
    }
}
