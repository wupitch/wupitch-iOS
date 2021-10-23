//
//  AgreeCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/23.
//

import UIKit

class AgreeCVCell: UICollectionViewCell {
    
    static let identifier = "AgreeCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AgreeCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
