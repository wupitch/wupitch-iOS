//
//  TouCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/23.
//

import UIKit

class TouCVCell: UICollectionViewCell {
    
    static let identifier = "TouCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TouCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
