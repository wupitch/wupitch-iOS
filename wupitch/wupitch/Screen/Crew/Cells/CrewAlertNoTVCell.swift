//
//  CrewAlertNoCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/03.
//

import UIKit

class CrewAlertNoTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
    }
    
    static let identifier = "CrewAlertNoTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewAlertNoTVCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
