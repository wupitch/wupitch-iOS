//
//  BungaeSportsTagCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/10.
//

import UIKit

class BungaeSportsTagCVCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    static let identifier = "BungaeSportsTagCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeSportsTagCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView.makeRounded(cornerRadius: 12.adjusted)
        tagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        tagLabel.textColor = .wht
    }

}
