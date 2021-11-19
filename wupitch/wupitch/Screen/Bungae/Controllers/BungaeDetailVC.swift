//
//  BungaeDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/18.
//

import UIKit

class BungaeDetailVC: BaseVC {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var detailCV: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCVDelegate()
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setStyle() {
        //modalView.alpha = 0.0
        
        titleLabel.text = "번개"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)

        lineView.backgroundColor = .gray04
        lineView.alpha = 0.0
        bottomLineView.backgroundColor = .gray04
       
        registerBtn.setTitle("참여하기", for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        registerBtn.tintColor = .wht
        registerBtn.backgroundColor = .main

        registerBtn.makeRounded(cornerRadius: 8.adjusted)
        
    }
    
    private func setCVDelegate() {
        detailCV.delegate = self
        detailCV.dataSource = self
        detailCV.register(DetailCrewImgCVCell.nib(), forCellWithReuseIdentifier: DetailCrewImgCVCell.identifier)
        
        detailCV.register(DetailCrewHeaderCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailCrewHeaderCRV")
        
        detailCV.register(BungaeTitleCVCell.nib(), forCellWithReuseIdentifier: BungaeTitleCVCell.identifier)
        detailCV.register(BungaeIntroduceCVCell.nib(), forCellWithReuseIdentifier: BungaeIntroduceCVCell.identifier)
        detailCV.register(DtailCrewContentCVCell.nib(), forCellWithReuseIdentifier: DtailCrewContentCVCell.identifier)
    }
    
    @IBAction func touchUpRegisterBtn(_ sender: Any) {
        // 사용자의 자기소개 부분이 비어있다면 정보가 부족하다는 알림창을 띄워주고, 그렇지 않다면 가입 신청이 완료되었다는 창 띄워주기
//        if SignUpUserInfo.shared.userIntroduce == nil {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
//                dvc.modalPresentationStyle = .overFullScreen
//                dvc.modalTransitionStyle = .crossDissolve
//
//                // present 형태로 띄우기
//                self.present(dvc, animated: true, completion: nil)
//            }
//        }
//        else {
//
//        // 가입 완료 팝업 창 띄워줌
//        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinComplete", bundle: nil)
//
//        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinCompleteVC") as? JoinCompleteVC {
//            dvc.modalPresentationStyle = .overFullScreen
//            dvc.modalTransitionStyle = .crossDissolve
//
//            // present 형태로 띄우기
//            self.present(dvc, animated: true, completion: nil)
//        }
//        }
    }
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    // 손님
    @IBAction func touchUpGuestRegisterBtn(_ sender: Any) {
        // 손님신청 바텀시트
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewApplication", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewApplicationVC") as? CrewApplicationVC {
            dvc.modalPresentationStyle = .overFullScreen
            
            modalView.alpha = 1
            dvc.guestModalDelegate = self
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }


 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - 211) {
        print("얼만큼 내려왓나?")
    }
}
}

extension BungaeDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewImgCVCell.identifier, for: indexPath) as? DetailCrewImgCVCell else{
                return UICollectionViewCell()
            }
            //cell.mainImgView.image = UIImage(named: "test")
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeTitleCVCell.identifier, for: indexPath) as? BungaeTitleCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "가나다라마바사아자차카타파하가나다라"
            cell.tagView.backgroundColor = .red
            cell.tagLabel.text = "D-1"
            cell.tagLabel.textColor = .wht
            cell.topDateLabel.text = "수요일 20:00 - 22:00"
            cell.bottomDateLabel.text = "일요일 11:30 - 13:30"
            cell.locationLabel.text = "가나다라마바사아자차카타파하"
            cell.moneyLabel.text = "정기회비 15,000원"
            cell.countLabel.text = "2/3명 참여"
            
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeIntroduceCVCell.identifier, for: indexPath) as? BungaeIntroduceCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "소개"
            
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
        else if indexPath.section == 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "DetailCrewHeaderCRV",for: indexPath) as! DetailCrewHeaderCRV
            
            switch indexPath.section {
            case 2:
                headerView.frame.size.height = 8.0
            case 3:
                headerView.frame.size.height = 8.0
            case 5:
                headerView.frame.size.height = 8.0
            default:
                headerView.frame.size.height = 0.0
            }
            return headerView
            
//        case UICollectionView.elementKindSectionFooter:
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "DetailCrewFooterCRV",for: indexPath) as! DetailCrewFooterCRV
//
//            switch indexPath.section {
//            case 3:
//                footerView.frame.size.height = 171.0
//            default:
//                footerView.frame.size.height = 0.0
//            }
//            return footerView
            
        default:
            assert(false, "응 아니야")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 2:
            return CGSize(width: collectionView.bounds.width, height: 8)
        case 3:
            return CGSize(width: collectionView.bounds.width, height: 8)
        case 5:
            return CGSize(width: collectionView.bounds.width, height: 8)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//
//        switch section {
//        case 3:
//            return CGSize(width: collectionView.bounds.width, height: 171)
//        default:
//            return CGSize(width: collectionView.bounds.width, height: 0)
//        }
//    }
    
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height =  collectionView.frame.height
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 211)
        }
        else if indexPath.section == 1 {
            return CGSize(width: width, height: 276)
        }
        else if indexPath.section == 2 {
            return CGSize(width: width, height: 600)
        }
        else if indexPath.section == 3 {
            return CGSize(width: width, height: 200)
        }
        else if indexPath.section == 4 {
            return CGSize(width: width, height: 200)
        }
        else {
            return CGSize(width: width, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension BungaeDetailVC: GuestModalDelegate {
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    
    func selectBtnToOpenPopup() {
        // 자기소개가 없으면 정보가 부족하다는 알럿창 띄우고, 있으면 손님으로 가입 되었다는 알림창 띄울 수 있도록
//        if SignUpUserInfo.shared.userIntroduce == nil {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
//                dvc.modalPresentationStyle = .overFullScreen
//                dvc.modalTransitionStyle = .crossDissolve
//
//                // present 형태로 띄우기
//                self.present(dvc, animated: true, completion: nil)
//            }
//        }
//        else {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "GuestComplete", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "GuestCompleteVC") as? GuestCompleteVC {
//                dvc.modalPresentationStyle = .overFullScreen
//                dvc.modalTransitionStyle = .crossDissolve
//
//                // present 형태로 띄우기
//                self.present(dvc, animated: true, completion: nil)
//            }
//        }
    }
  
    // 스크롤 시 선 감지
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y+1) >= 200 {
            lineView.alpha = 1
        }
        else {
            lineView.alpha = 0.0
        }
    }
}

