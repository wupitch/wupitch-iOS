//
//  DetailCrewFooterCRV.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/03.
//

import UIKit

class DetailCrewFooterTVCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "DetailCrewFooterTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewFooterTVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.makeRounded(cornerRadius: 16.adjusted)
        bgView.backgroundColor = .main10
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .main
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        subLabel.textColor = .main
        subLabel.setTextWithLineHeight(text: subLabel.text, lineHeight: 24.adjusted)
    }
    
}
