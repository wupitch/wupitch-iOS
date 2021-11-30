//
//  DetailCrewImgCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

protocol PinDelegate {
    func selectPinBtn()
}

class DetailCrewImgCVCell: UICollectionViewCell {

    var status = false
    var crewPinDelegate : PinDelegate?
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var pinBtn: UIButton!
    
    static let identifier = "DetailCrewImgCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewImgCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func touchUpPinBtn(_ sender: Any) {
        self.crewPinDelegate?.selectPinBtn()
        
    }
}
