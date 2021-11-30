//
//  DetailCrewImgCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewImgCVCell: UICollectionViewCell {

    var status : Bool = false
    lazy var pinUpToggle = PinupToggleService()
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var pinBtn: UIButton!
    
    static let identifier = "DetailCrewImgCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewImgCVCell", bundle: nil)
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
        
        pinUpToggle.postPinUpToggleService(delegate: self)
    }
}

extension DetailCrewImgCVCell {
    func didSuccessPinUpToggle(result: PinUpToggleResult) {
        print("핀업 토글이 성공적으로 들어옵니다.")
        print("핀업",result.result)
    }

    func failedToRequest(message: String) {
        print("크루 디테일 조회 데이터가 들어오지 않았습니다.")

    }
}
