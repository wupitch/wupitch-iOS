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
//        bgView.backgroundColor = .gray05
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        titleLabel.textColor = .bk
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        descriptionLabel.textColor = .gray02
    }
    
    func setCell(title: String, description: String, imageName: String){
        titleLabel.text = title
        descriptionLabel.text = description
        imgView.image = UIImage(named: imageName)
    }
    
}
