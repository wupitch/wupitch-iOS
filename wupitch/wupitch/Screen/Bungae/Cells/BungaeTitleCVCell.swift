//
//  BungaeTitleCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/19.
//

import UIKit

class BungaeTitleCVCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bottomDateLabel: UILabel!
    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    static let identifier = "BungaeTitleCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeTitleCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    private func setStyle() {
        tagView.makeRounded(cornerRadius: 14.adjusted)
        tagLabel.tintColor = .wht
        tagLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.adjusted)
        titleLabel.tintColor = .bk
        
        topDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        topDateLabel.textColor = .bk
        
        bottomDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        bottomDateLabel.textColor = .bk
        
        locationLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        locationLabel.textColor = .bk
        
        moneyLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        moneyLabel.textColor = .bk
        
        countLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        countLabel.textColor = .bk
    }
}
