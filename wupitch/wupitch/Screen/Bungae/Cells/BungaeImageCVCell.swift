//
//  BungaeImageCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import UIKit

class BungaeImageCVCell: UICollectionViewCell {
    var status : Bool = false
    lazy var bungaePinUpToggle = BungaePinupToggleService()
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var pinBtn: UIButton!
    
    static let identifier = "BungaeImageCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeImageCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pinBtn.layer.zPosition = 999;
    }
    
    func colorBtn() {
        status = true
        pinBtn.setImage(UIImage(named: "selecPin"), for: .normal)
    }
    
    func grayBtn() {
        status = false
        pinBtn.setImage(UIImage(named: "pin"), for: .normal)
    }

    @IBAction func touchUpPinBtn(_ sender: Any) {
        status = !status
        if status == true {
            colorBtn()
        }
        else {
            grayBtn()
        }
        print(status)
        bungaePinUpToggle.patchBungaePinUpToggleService(delegate: self)
    }
}

extension BungaeImageCVCell {
    func didSuccessBungaePinUpToggle(result: BungaePinUpToggleResult) {
        print("번개 핀업 토글이 성공적으로 들어옵니다.")
        print("번개 핀업",result.result)
    }

    func failedToRequest(message: String) {
        print("번개 핀업 데이터가 들어오지 않았습니다.")

    }
}
