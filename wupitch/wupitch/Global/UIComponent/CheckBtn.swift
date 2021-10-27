//
//  CheckBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit

class CheckBtn : UIButton {
    
    var checkDelegate : CheckDelegate?
    var status : Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
}

extension CheckBtn {
    private func layout() {
        self.setImage(UIImage(named: "grayCheck"), for: .normal)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }
    
    func changeBtnImg() {
        if let checkImg = self.image(for: .normal) {
            switch checkImg {
            case UIImage(named: "grayCheck"):
                status = true
                self.setImage(UIImage(named: "check"), for: .normal)
            case UIImage(named: "check"):
                status = false
                self.setImage(UIImage(named: "grayCheck"), for: .normal)
            default:
                break
            }
        }
    }
    
    func allAgreeBtnImg() {
        self.setImage(UIImage(named: "check"), for: .normal)
        status = true
    }
    
    @objc func touchUp() {
        checkDelegate?.pushNext(btn: self)
    }
}

protocol CheckDelegate {
    func pushNext(btn:CheckBtn)
}

