//
//  BungaeMemberTVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/09.
//

import UIKit

class BungaeMemberTVCell: UITableViewCell {

    @IBOutlet weak var allowBtn: UIButton!
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
    }
    
    private func setStyle() {
        // profile image view
        profileImageView.makeRounded(cornerRadius: nil)
        profileImageView.layer.borderWidth = 1.adjusted
        profileImageView.layer.borderColor = UIColor.gray04.cgColor
        // bungaeMember Name
        bungaeMemberLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        bungaeMemberLabel.textColor = .bk
        // allowBtn
        allowBtn.backgroundColor = .main
        allowBtn.setTitleColor(UIColor.wht, for: .normal)
        allowBtn.makeRounded(cornerRadius: 8.adjusted)
        allowBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
    }
}
