//
//  CrewCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/01.
//

import UIKit

class CrewCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagNameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "CrewCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagNameView.makeRounded(cornerRadius: 12.adjusted)
        tagNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        circleView.layer.cornerRadius = circleView.frame.height/2
        
        regionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        contentView.makeRounded(cornerRadius: 16.adjusted)
        bgView.backgroundColor = .gray05
        bgView.layer.borderWidth = 1.adjusted
        bgView.layer.borderColor = UIColor.gray04.cgColor
        
        
        
    }

}
