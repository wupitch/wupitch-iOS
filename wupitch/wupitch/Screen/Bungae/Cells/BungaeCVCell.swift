//
//  BungaeCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/18.
//

import UIKit

class BungaeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagNameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bungaeCountLabel: UILabel!
    
    static let identifier = "BungaeCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagNameView.makeRounded(cornerRadius: 12.adjusted)
        tagNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        dayLabel.textColor = .gray01
        
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        subLabel.textColor = .gray01
        
        bungaeCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        bungaeCountLabel.textColor = .gray01
        
        bgView.makeRounded(cornerRadius: 16.adjusted)
        bgView.backgroundColor = .gray05
        bgView.layer.borderWidth = 1.adjusted
        bgView.layer.borderColor = UIColor.gray04.cgColor
    }

}
