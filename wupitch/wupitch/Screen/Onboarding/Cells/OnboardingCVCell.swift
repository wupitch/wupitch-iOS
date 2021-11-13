//
//  testCViewCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "OnboardingCVCell", bundle: nil)
    }
    
    //@IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.textColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 34.adjusted)
        titleLabel.textAlignment = .center
        
        // descriptionLabel Style
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.textColor = .gray02
        descriptionLabel.textAlignment = .center
    }
    
    func setCell(title: String, description: String, imageName: String){
        titleLabel.text = title
        descriptionLabel.text = description
        imgView.image = UIImage(named: imageName)
    }
    
}
