//
//  bungaeMemberDetail.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/10.
//

import UIKit

class BungaeMemberDetailVC: UIViewController {

    @IBOutlet var betweenDots: [UILabel]!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var introduceView: UIView!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCVDelegate()
    }
    
    private func setCVDelegate() {
        //tagCV.delegate = self
        //tagCV.dataSource = self
        tagCV.register(BungaeSportsTagCVCell.nib(), forCellWithReuseIdentifier: BungaeSportsTagCVCell.identifier)
       }
    
    private func setStyle() {
        profileImageView.makeRounded(cornerRadius: nil)
        profileImageView.layer.borderWidth = 1.adjusted
        profileImageView.layer.borderColor = UIColor.gray04.cgColor
        nicknameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        nicknameLabel.textColor = .bk
        ageLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        cityLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        phoneLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        betweenDots.forEach { UILabel in
            UILabel.textColor = .gray02
        }
        ageLabel.textColor = .gray02
        cityLabel.textColor = .gray02
        phoneLabel.textColor = .gray02
        introduceView.makeRounded(cornerRadius: 8.adjusted)
        introduceLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        introduceLabel.textColor = .bk
    }
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

