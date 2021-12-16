//
//  CrewBoardActivityTVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/10.
//

import UIKit

protocol BoardToLikeOrReport {
    func selectedCVCell(_ index: Int)
    func isAccountReportTrue()
}

class CrewBoardActivityTVCell: UITableViewCell {
    
    var boardToLikeOrReport: BoardToLikeOrReport?
    var actionBlock: (() -> Void)? = nil
    lazy var likeToggleDataManager = LikeToggleService()

    @IBOutlet weak var likeLabel: UILabel!
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
    
    var status : Bool = false
    
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
        likeBtn.setTitleColor(UIColor.gray03, for: .normal)
        likeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        gongjiContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        gongjiContentsLabel.textColor = .bk
    }
    
    func colorBtn() {
        status = true
        likeBtn.setTitleColor(UIColor.sub04, for: .normal)
        likeBtn.setImage(UIImage(named: "reactHeart"), for: .normal)
    }
    
    func grayBtn() {
        status = false
        likeBtn.setTitleColor(UIColor.gray03, for: .normal)
        likeBtn.setImage(UIImage(named: "reactHeartInact"), for: .normal)
    }
    
    // 좋아요 버튼
    @IBAction func touchUpLikeBtn(_ sender: Any) {
        status = !status
        if status == true {
            colorBtn()
        }
        else {
            grayBtn()
        }
        print(status)
//        likeToggleDataManager.patchLikeToggle(delegate: self)
    }
    // 신고 버튼
    @IBAction func touchUpReportBtn(_ sender: Any) {
        actionBlock?()
    }
}

//extension CrewBoardActivityTVCell {
//    func didSuccessLikeToggle(result: LikeToggleResult) {
//        print("게시글 좋아요 토글이 성공적으로 들어옵니다.")
//        print("좋아요 토글",result.result)
//    }
//    func failedToRequest(message: String) {
//        print("게시글 좋아요 조회 데이터가 들어오지 않습니다.")
//    }
//}
