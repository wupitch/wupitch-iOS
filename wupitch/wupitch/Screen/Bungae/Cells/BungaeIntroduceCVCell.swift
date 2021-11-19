//
//  BungaeIntroduceCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/19.
//

import UIKit

class BungaeIntroduceCVCell: UICollectionViewCell {

    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "BungaeIntroduceCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeIntroduceCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        contentsLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        contentsLabel.textColor = .bk
    }

}
