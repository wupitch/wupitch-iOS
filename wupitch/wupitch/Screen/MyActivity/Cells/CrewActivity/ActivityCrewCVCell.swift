//
//  ActivityCrewCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class ActivityCrewCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagNameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var crewoneBtn: UIButton!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var boardBtn: UIButton!
    
    static let identifier = "ActivityCrewCVCell"
        
        static func nib() -> UINib {
            return UINib(nibName: "ActivityCrewCVCell", bundle: nil)
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func setStyle() {
        tagNameView.makeRounded(cornerRadius: 12.adjusted)
        tagNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        dayLabel.textColor = .gray01
        subLabel.textColor = .gray01
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        bgView.makeRounded(cornerRadius: 16.adjusted)
        bgView.backgroundColor = .gray05
        bgView.layer.borderWidth = 1.adjusted
        bgView.layer.borderColor = UIColor.gray04.cgColor
        
        boardBtn.setTitleColor(.bk, for: .normal)
        boardBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        photoBtn.setTitleColor(.bk, for: .normal)
        photoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        crewoneBtn.setTitleColor(.bk, for: .normal)
        crewoneBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
    }
    
    @IBAction func touchUpBoardBtn(_ sender: Any) {
    }
    @IBAction func touchUpPhotoBtn(_ sender: Any) {
    }
    @IBAction func touchUPCrewBtn(_ sender: Any) {
    }
}
