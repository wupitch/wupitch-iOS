//
//  testCViewCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

import UIKit

class OnbordingCVCell: UICollectionViewCell {
    
    static let identifier = "OnbordingCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "OnbordingCVCell", bundle: nil)
    }
    
    //@IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28.adjusted)
        titleLabel.textColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 38.adjusted)
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.textColor = .gray02
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 22.adjusted)
        descriptionLabel.textAlignment = .center
    }
    
    func setCell(title: String, description: String, imageName: String){
        titleLabel.text = title
        descriptionLabel.text = description
        imgView.image = UIImage(named: imageName)
    }
    
}
