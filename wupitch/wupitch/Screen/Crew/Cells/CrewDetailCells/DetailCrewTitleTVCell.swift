//
//  DetailCrewTitleCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewTitleTVCell: UITableViewCell {

    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var moneyIcon: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet var moneyLabel: [UILabel]!
    @IBOutlet var dayLabel: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    static let identifier = "DetailCrewTitleTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewTitleTVCell", bundle: nil)
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
        
        for i in 0...2 {
            dayLabel[i].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            dayLabel[i].textColor = .bk
        }
        
        locationLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        locationLabel.textColor = .bk
        
        for i in 0...1 {
            moneyLabel[i].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            moneyLabel[i].textColor = .bk
        }
    }
}
