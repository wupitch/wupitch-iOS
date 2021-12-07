//
//  NoActivityCrewCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class NoActivityCrewCVCell: UICollectionViewCell {

    @IBOutlet weak var lookBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    static let identifier = "NoActivityCrewCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NoActivityCrewCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.borderWidth = 1.adjusted
        bgView.layer.borderColor = UIColor.main.cgColor
        bgView.makeRounded(cornerRadius: 16.adjusted)
        lookBtn.setTitleColor(.main, for: .normal)
        lookBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }
}
