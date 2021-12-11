//
//  CrewBoardActivityTVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/10.
//

import UIKit

class CrewBoardActivityTVCell: UITableViewCell {

    @IBOutlet weak var gongjiContentsLabel: UILabel!
    @IBOutlet weak var gongjiLabel: UILabel!
    @IBOutlet weak var gongjiView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var leaderImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    static let identifier = "CrewBoardActivityTVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewBoardActivityTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    private func setStyle() {
        profileImageView.makeRounded(cornerRadius: nil)
        profileImageView.layer.borderWidth = 1.adjusted
        profileImageView.layer.borderColor = UIColor.gray04.cgColor
        
        nicknameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        nicknameLabel.textColor = .bk
        contentsLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        contentsLabel.textColor = .bk
        likeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        likeBtn.titleLabel?.textColor = UIColor.gray03
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        dateLabel.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        gongjiView.makeRounded(cornerRadius: 14.adjusted)
        gongjiView.layer.borderColor = UIColor.main.cgColor
        gongjiView.layer.borderWidth = 1.adjusted
        gongjiLabel.textColor = .main
        gongjiLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
    }
}
