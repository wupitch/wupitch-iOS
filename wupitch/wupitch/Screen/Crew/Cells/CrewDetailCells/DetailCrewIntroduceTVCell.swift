//
//  DetailCrewIntroduceCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewIntroduceTVCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    static let identifier = "DetailCrewIntroduceTVCell"

    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewIntroduceTVCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk

        peopleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        peopleLabel.textColor = .bk

        ageLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        ageLabel.textColor = .bk

        contentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        contentLabel.textColor = .bk
        contentLabel.setTextWithLineHeight(text: contentLabel.text, lineHeight: 26.adjusted)
    }
}
