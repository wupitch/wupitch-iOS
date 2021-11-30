//
//  DtailCrewContentCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DtailCrewContentCVCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "DtailCrewContentCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DtailCrewContentCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        contentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        contentLabel.textColor = .bk
    }

}
