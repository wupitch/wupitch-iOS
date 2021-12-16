//
//  bungaeMemberDetail.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/10.
//

import UIKit
import SDWebImage

class BungaeMemberDetailVC: UIViewController {

    @IBOutlet weak var guestLabel: UILabel!
    @IBOutlet weak var guestView: UIView!
    @IBOutlet var betweenDots: [UILabel]!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var introduceView: UIView!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    lazy var crewMemberProfileDataManager = CrewMemberProfileService()
    lazy var bungaeMemberProfileDataManager = BungaeMemberProfileService()
    var profileData: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setStyle()
        setCVDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bungaeMemberProfileDataManager.getBungaeMemberProfile(delegate: self)
        crewMemberProfileDataManager.getCrewMemberProfile(delegate: self)
    }
    
    func configure() {
        tagCV.collectionViewLayout = CollectionViewLeftAlignFlowLayou()
        if let flowLayout = tagCV?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        tagCV.delegate = self
        tagCV.dataSource = self
    }
    private func setCVDelegate() {
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
        betweenDots.forEach { UILabel in UILabel.textColor = .gray02 }
        ageLabel.textColor = .gray02
        cityLabel.textColor = .gray02
        phoneLabel.textColor = .gray02
        introduceView.makeRounded(cornerRadius: 8.adjusted)
        introduceLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        introduceLabel.textColor = .bk
        guestView.makeRounded(cornerRadius: 8.adjusted)
        guestLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        guestLabel.textColor = .main
    }
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MyActivityAlert", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityAlertVC") as? MyActivityAlertVC else {return}
        dvc.modalPresentationStyle = .overFullScreen
        dvc.modalTransitionStyle = .crossDissolve
        present(dvc, animated: true, completion: nil)
    }
}

extension BungaeMemberDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("몇개나와", profileData?.count)
        return profileData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeSportsTagCVCell.identifier, for: indexPath) as? BungaeSportsTagCVCell else{
            return UICollectionViewCell()
        }
        // 스포츠 아이디 라벨에 맞게
        switch profileData?[indexPath.row] {
        case 1:
            cell.tagLabel.text = "축구/풋살"
            cell.tagView.backgroundColor = .sub04
        case 2:
            cell.tagLabel.text = "배드민턴"
            cell.tagView.backgroundColor = .sub03
        case 3:
            cell.tagLabel.text = "배구"
            cell.tagView.backgroundColor = .sub01
        case 4:
            cell.tagLabel.text = "농구"
            cell.tagView.backgroundColor = .sub02
        case 5:
            cell.tagLabel.text = "등산"
            cell.tagView.backgroundColor = .sub06
        case 6:
            cell.tagLabel.text = "런닝"
            cell.tagView.backgroundColor = .sub05
        default:
            break
        }
        return cell
    }
}


extension BungaeMemberDetailVC {
    func didSuccessBungaeMemberProfile(result: BungaeMemberProfileResult) {
        print("내활동 번개 멤버 프로필 데이터가 성공적으로 들어왔습니다.")
        profileData = result.sportsList
        print("여기는?", profileData)
        // 값 없으면 컬렉션 뷰 없애기
        if result.sportsList.count == 0 {
            tagCV.isHidden = true
        } else {
            tagCV.isHidden = false
        }
        // 손님일때
        if result.isGuest == true {
            guestView.isHidden = false
            guestLabel.text = result.guestReserveTime
        } else {
            guestView.isHidden = true
        }
        // 닉네임
        nicknameLabel.text = result.accountNickname
        // 나이
        switch result.ageNum {
        case 1:
            ageLabel.text = "10대"
        case 2:
            ageLabel.text = "20대"
        case 3:
            ageLabel.text = "30대"
        case 4:
            ageLabel.text = "40대"
        case 5:
            ageLabel.text = "50대 이상"
        default:
            break
        }
        // 지역구
        cityLabel.text = result.area
        // 폰번호
        phoneLabel.text = result.phoneNumber
        // 프로필 이미지
        if let profileImage = result.profileImage {
            profileImageView.sd_setImage(with: URL(string: profileImage))
        } else {
            profileImageView.image = UIImage(named: "profileBasic")
        }
        // 자기소개
        introduceLabel.text = result.introduction
    }
    func didSuccessCrewMemberProfile(result: CrewMemberProfileResult) {
        print("내활동 크루 멤버 프로필 데이터가 성공적으로 들어왔습니다.")
        profileData = result.sportsList
        
        // 값 없으면 컬렉션 뷰 없애기
        if result.sportsList.count == 0 {
            tagCV.isHidden = true
        } else {
            tagCV.isHidden = false
        }
        // 손님일때
        if result.isGuest == true {
            guestView.isHidden = false
            guestLabel.text = result.guestReserveTime
        } else {
            guestView.isHidden = true
        }
        // 닉네임
        nicknameLabel.text = result.accountNickname
        // 나이
        switch result.ageNum {
        case 1:
            ageLabel.text = "10대"
        case 2:
            ageLabel.text = "20대"
        case 3:
            ageLabel.text = "30대"
        case 4:
            ageLabel.text = "40대"
        case 5:
            ageLabel.text = "50대 이상"
        default:
            break
        }
        // 지역구
        cityLabel.text = result.area
        // 폰번호
        phoneLabel.text = result.phoneNumber
        // 프로필 이미지
        if let profileImage = result.profileImage {
            profileImageView.sd_setImage(with: URL(string: profileImage))
        } else {
            profileImageView.image = UIImage(named: "profileBasic")
        }
        // 자기소개
        introduceLabel.text = result.introduction
    }
    func failedToRequest(message: String) {
        print("내활동 번개 멤버 프로필 데이터가 들어오지 않습니다.")
    }
}


