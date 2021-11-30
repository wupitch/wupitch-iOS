//
//  DetailCrewFooterCRV.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/03.
//

import UIKit

class DetailCrewFooterCRV: UICollectionReusableView {

    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    static let identifier = "DetailCrewFooterCRV"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewFooterCRV", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundView.makeRounded(cornerRadius: 16.adjusted)
        backgroundView.backgroundColor = .main10
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .main
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        subLabel.textColor = .main
        subLabel.setTextWithLineHeight(text: subLabel.text, lineHeight: 24.adjusted)
    }
    
}
