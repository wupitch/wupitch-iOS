//
//  BungaeMemberTVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/09.
//

import UIKit

class BungaeMemberTVCell: UITableViewCell {

    @IBOutlet weak var waitLabel: UILabel!
    @IBOutlet weak var waitView: UIView!
    @IBOutlet weak var bungaeLeaderImageView: UIImageView!
    @IBOutlet weak var bungaeMemberLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    static let identifier = "BungaeMemberTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeMemberTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
        bungaeLeaderImageView.isHidden = true
        waitView.isHidden = true
    }
    
    private func setStyle() {
        // profile image view
        profileImageView.makeRounded(cornerRadius: nil)
        profileImageView.layer.borderWidth = 1.adjusted
        profileImageView.layer.borderColor = UIColor.gray04.cgColor
        // bungaeMember Name
        bungaeMemberLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        bungaeMemberLabel.textColor = .bk
        waitView.makeRounded(cornerRadius: 10.adjusted)
        waitView.backgroundColor = .gray03
        waitLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        waitLabel.textColor = .wht
    }
}
