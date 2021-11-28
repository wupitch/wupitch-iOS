//
//  DetailCrewTitleCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewTitleCVCell: UICollectionViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet var money: [UILabel]!
    @IBOutlet var moneyLabel: [UILabel]!
    
    @IBOutlet var dayLabel: [UILabel]!
    @IBOutlet var startImeLabel: [UILabel]!
    @IBOutlet var betweenLabel: [UILabel]!
    
    @IBOutlet var endTimeLabel: [UILabel]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    
    static let identifier = "DetailCrewTitleCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewTitleCVCell", bundle: nil)
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
        
    }

}
