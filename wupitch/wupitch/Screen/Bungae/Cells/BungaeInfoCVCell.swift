//
//  BungaeInfoCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/03.
//

import UIKit

class BungaeInfoCVCell: UITableViewCell {

    @IBOutlet var contentLabel: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "BungaeInfoCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeInfoCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        for i in 0...3 {
            contentLabel[i].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            contentLabel[i].textColor = .bk
            contentLabel[i].setTextWithLineHeight(text: contentLabel[i].text, lineHeight: 22.adjusted)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
