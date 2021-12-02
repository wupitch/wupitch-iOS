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

    var detailInfo : BungaeDetailResult?
    lazy var bungaeDetailDataManager = BungaeDetailService()
    lazy var bungaeRegisterDataManager = BungaeRegisterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCVDelegate()
        bungaeDetailDataManager.getBungaeDetail(delegate: self)
    }
    
    private func setStyle() {
        modalView.alpha = 0.0
        
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
        detailCV.register(BungaeImageCVCell.nib(), forCellWithReuseIdentifier: BungaeImageCVCell.identifier)
        
        detailCV.register(DetailCrewHeaderCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailCrewHeaderCRV")
        
        detailCV.register(BungaeTitleCVCell.nib(), forCellWithReuseIdentifier: BungaeTitleCVCell.identifier)
        detailCV.register(BungaeIntroduceCVCell.nib(), forCellWithReuseIdentifier: BungaeIntroduceCVCell.identifier)
        //detailCV.register(DtailCrewContentCVCell.nib(), forCellWithReuseIdentifier: DtailCrewContentCVCell.identifier)
    }
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        
        let stringChange = doubleToString.split(separator: ".")
        
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        
        return stringDate
    }
    
    
    @IBAction func touchUpRegisterBtn(_ sender: Any) {
        // 사용자의 자기소개 부분이 비어있다면 정보가 부족하다는 알림창을 띄워주고, 그렇지 않다면 가입 신청이 완료되었다는 창 띄워주기
        if SignUpUserInfo.shared.introduce == nil {
            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                dvc.introducePopUp = self
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
        }
        else {
            
            // 가입 완료 팝업 창 띄워줌
            let storyBoard: UIStoryboard = UIStoryboard(name: "JoinComplete", bundle: nil)
            
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinCompleteVC") as? JoinCompleteVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
            bungaeRegisterDataManager.postBungaeRegisterService(delegate: self)
        }
    }
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   


 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - 211) {
        print("얼만큼 내려왓나?")
    }
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

extension BungaeDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeImageCVCell.identifier, for: indexPath) as? BungaeImageCVCell else{
                return UICollectionViewCell()
            }
            // 사진이 있을 때
            if detailInfo?.impromptuImage != nil {
                cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.impromptuImage ?? ""))
            }
            // 사진이 없을 때
            else {
                cell.mainImgView.image = UIImage(named: "imgBungaeThumb")
            }
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeTitleCVCell.identifier, for: indexPath) as? BungaeTitleCVCell else{
                return UICollectionViewCell()
            }
            
            // 디데이 숫자가 1일때만 백그라운드 색 진하게
            if  detailInfo?.dday == 1 {
                cell.tagView.backgroundColor = .bk
                cell.tagLabel.textColor = .wht
            }
            else {
                cell.tagView.backgroundColor = .gray03
                cell.tagLabel.textColor = .wht
            }
            
            // 나머지
            cell.titleLabel.text = detailInfo?.title
            cell.tagLabel.text = String("D-") + String(detailInfo?.dday ?? 0)
            cell.topDateLabel.text = String(detailInfo?.date ?? "") + " " + String(detailInfo?.day ?? "")
            cell.bottomDateLabel.text = stringDate(doubleDate: detailInfo?.startTime ?? -1.0) + " - " + stringDate(doubleDate: detailInfo?.endTime ?? -1.0)
            cell.locationLabel.text = detailInfo?.location
            cell.moneyLabel.text = "참여비" + " " + String(detailInfo?.dues ?? 0) + "원"
            cell.countLabel.text = String(detailInfo?.nowMemberCount ?? -99) + "/" + String(detailInfo?.recruitmentCount ?? -99) + "명 참여"
            
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeIntroduceCVCell.identifier, for: indexPath) as? BungaeIntroduceCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "소개"
            cell.contentsLabel.text = detailInfo?.introduction
            
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeIntroduceCVCell.identifier, for: indexPath) as? BungaeIntroduceCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "준비물"
            //cell.contentLabel.text = detailInfo?.materials
            
            return cell
        }
        else if indexPath.section == 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeIntroduceCVCell.identifier, for: indexPath) as? BungaeIntroduceCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "문의"
            //cell.contentLabel.text = detailInfo?.inquiries
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeIntroduceCVCell.identifier, for: indexPath) as? BungaeIntroduceCVCell else{
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = "안내사항"
            cell.contentsLabel.text = " - 번개 참여는 번개 리더의 승인 없이 바로 가능합니다.\n\n - 번개 참여 신청 취소는 마이페이지 – 참여 신청한 크루 및 번개에서 가능합니다.(단, 운동 하루 전까지 취소 가능) \n\n - 번개 리더에 의한 번개 삭제 시 푸시 알림을 통해 알려드립니다. \n\n - 번개 참여 신청이 완료된 후, 운동일 하루 전 푸시 알림을 통해 알려드립니다."
            cell.contentsLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            
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
            return CGSize(width: width, height: 320)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension BungaeDetailVC: GuestModalDelegate, IntroduceDelegate {
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    
    func selectBtnToOpenPopup() {
        // 자기소개가 없으면 정보가 부족하다는 알럿창 띄우고, 있으면 손님으로 가입 되었다는 알림창 띄울 수 있도록
        if SignUpUserInfo.shared.introduce == nil {
            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                dvc.introducePopUp = self
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "GuestComplete", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "GuestCompleteVC") as? GuestCompleteVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }
    func dismissIntroducePopup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileNickname", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "ProfileNicknameVC") as? ProfileNicknameVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension BungaeDetailVC {
    func didSuccessBungaeDetail(result: BungaeDetailResult) {
        print("번개 디테일 데이터가 성공적으로 들어왔습니다.")
        self.detailInfo = result
        detailCV.reloadData()
    }
    
    func didSuccessBungaeRegister(result: BungaeRegisterResult) {
        print("번개 등록(가입)이 성공적으로 되었습니다.")
        print("번개 등록 결과는? ",result.result)
    }

    func failedToRequest(message: String) {
        print("번개 디테일데이터가 들어오지 않았습니다.")

    }
}
