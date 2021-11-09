//
//  CrewAlertTVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/09.
//

import UIKit

class CrewAlertTVCell: UITableViewCell {

    static let identifier = "CrewAlertTVCell"
    
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertTimeLabel: LabelFontSize!
    @IBOutlet weak var alertTitleLabel: LabelFontSize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setStyle() {
        alertTitleLabel.CrewAlertTitleLabel()
        alertTimeLabel.makeCrewSubTitleLabel()
    }

}
