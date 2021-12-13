//
//  ActivityCrewCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

// 내 활동 '활동중인 크루' 셀
class ActivityCrewCVCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagNameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var crewoneBtn: UIButton!
    @IBOutlet weak var boardBtn: UIButton!
    
    // MARK: - Cell Identifier & Nib
    static let identifier = "ActivityCrewCVCell"
    static func nib() -> UINib {
        return UINib(nibName: "ActivityCrewCVCell", bundle: nil)
    }

    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    // MARK: - Function
    // 스타일
    func setStyle() {
        // 태그 뷰 & 태그 라벨
        tagNameView.makeRounded(cornerRadius: 12.adjusted)
        tagNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        // 라벨
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        dayLabel.textColor = .gray01
        subLabel.textColor = .gray01
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        subLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        // 백그라운드 뷰
        bgView.makeRounded(cornerRadius: 16.adjusted)
        bgView.backgroundColor = .gray05
        bgView.layer.borderWidth = 1.adjusted
        bgView.layer.borderColor = UIColor.gray04.cgColor
        // 버튼
        boardBtn.setTitleColor(.bk, for: .normal)
        boardBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        crewoneBtn.setTitleColor(.bk, for: .normal)
        crewoneBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
    }
    
    // MARK: - IBAction
    // 게시판 버튼
    @IBAction func touchUpBoardBtn(_ sender: Any) {
    }
    // 크루원 버튼
    @IBAction func touchUPCrewBtn(_ sender: Any) {
    }
}
