//
//  DetailCrewInquireCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/02.
//

import UIKit

class DetailCrewInquireCVCell: UITableViewCell {
    
    @IBOutlet weak var thirdContentLabel: UILabel!
    @IBOutlet weak var secondContentLabel: UILabel!
    @IBOutlet weak var firstcontentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "DetailCrewInquireCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewInquireCVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        firstcontentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        firstcontentLabel.textColor = .bk
        firstcontentLabel.setTextWithLineHeight(text: firstcontentLabel.text, lineHeight: 22.adjusted)
        
        secondContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        secondContentLabel.textColor = .bk
        secondContentLabel.setTextWithLineHeight(text: secondContentLabel.text, lineHeight: 22.adjusted)
        
        thirdContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        thirdContentLabel.textColor = .bk
        thirdContentLabel.setTextWithLineHeight(text: thirdContentLabel.text, lineHeight: 22.adjusted)

    }
    
}
