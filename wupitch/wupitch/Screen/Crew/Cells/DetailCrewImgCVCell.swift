//
//  DetailCrewImgCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewImgCVCell: UICollectionViewCell {

    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var pinBtn: UIButton!
    
    static let identifier = "DetailCrewImgCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewImgCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
