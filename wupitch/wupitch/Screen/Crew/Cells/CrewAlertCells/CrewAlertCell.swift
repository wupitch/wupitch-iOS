//
//  CrewAlertCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import UIKit

class CrewAlertCell: UITableViewCell {

    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var alertImageView: UIImageView!
    
    static let identifier = "CrewAlertCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.isHidden = true
        titleLabel.CrewAlertTitleLabel()
        dateLabel.makeCrewSubTitleLabel()
        alertImageView.makeRounded(cornerRadius: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
