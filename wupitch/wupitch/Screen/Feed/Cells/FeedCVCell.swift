//
//  FeedCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class FeedCVCell: UICollectionViewCell {
    
    static let identifier = "FeedCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FeedCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
