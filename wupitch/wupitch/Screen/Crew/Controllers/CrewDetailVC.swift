//
//  CrewDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/01.
//

import UIKit
import Alamofire

// 크루 디테일 뷰
class CrewDetailVC: BaseVC {
    
    // MARK: - IBOutlet
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var detailCV: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    lazy var crewDetailDataManager = CrewDetailService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
        crewDetailDataManager.getCrewDetail(delegate: self)
    }
    
    // MARK: - Function
    private func setStyle() {
        // 모달뷰
        modalView.alpha = 0.0
        // Label
        titleLabel.text = "크루"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        // 스크롤시 안보여야하는 라인뷰
        lineView.backgroundColor = .gray04
        lineView.alpha = 0.0
        bottomLineView.backgroundColor = .gray04
        // 손님버튼
        guestBtn.setTitle("손님으로 참여", for: .normal)
        guestBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        guestBtn.tintColor = .main
        guestBtn.layer.borderWidth = 1.adjusted
        guestBtn.layer.borderColor = UIColor.main.cgColor
        guestBtn.makeRounded(cornerRadius: 8.adjusted)
        // 가입 버튼
        registerBtn.setTitle("가입하기", for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        registerBtn.tintColor = .wht
        registerBtn.backgroundColor = .main
        registerBtn.makeRounded(cornerRadius: 8.adjusted)
        // 탭바 안보이게
        tabBarController?.tabBar.isHidden = true
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
    
    // MARK: - 컬렉션 뷰의 특정 섹션에 섹션헤더, 섹션푸터 넣어주는 방법
    // CV Delegate & Register Cell
    private func setCVDelegate() {
        // delegate
        detailCV.delegate = self
        detailCV.dataSource = self
        
        // Register Cell
        detailCV.register(DetailCrewImgCVCell.nib(), forCellWithReuseIdentifier: DetailCrewImgCVCell.identifier)
        detailCV.register(DetailCrewTitleCVCell.nib(), forCellWithReuseIdentifier: DetailCrewTitleCVCell.identifier)
        detailCV.register(DetailCrewIntroduceCVCell.nib(), forCellWithReuseIdentifier: DetailCrewIntroduceCVCell.identifier)
        detailCV.register(DtailCrewContentCVCell.nib(), forCellWithReuseIdentifier: DtailCrewContentCVCell.identifier)
        
        // Register Reusable View Cell
        detailCV.register(DetailCrewHeaderCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailCrewHeaderCRV")
        detailCV.register(DetailCrewFooterCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "DetailCrewFooterCRV")
    }
    
    // MARK: - IBAction
    // 가입하기 버튼
    @IBAction func touchUpRegisterBtn(_ sender: Any) {
        // 사용자의 자기소개 부분이 비어있다면 정보가 부족하다는 알림창을 띄워주고, 그렇지 않다면 가입 신청이 완료되었다는 창 띄워주기
                if SignUpUserInfo.shared.introduce == nil {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
                    if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
                        dvc.modalPresentationStyle = .overFullScreen
                        dvc.modalTransitionStyle = .crossDissolve
        
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
            }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    // 손님 버튼
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
}

extension CrewDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // 섹션 개수 지정
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewTitleCVCell.identifier, for: indexPath) as? DetailCrewTitleCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "가나다라마바사아자차카타파하"
            cell.tagView.backgroundColor = .red
            cell.tagLabel.text = "농구"
            cell.tagLabel.textColor = .wht
            cell.topDateLabel.text = "수요일 20:00 - 22:00"
            cell.bottomDateLabel.text = "일요일 11:30 - 13:30"
            cell.locationLabel.text = "가나다라마바사아자차카타파하"
            cell.moneyLabel.text = "정기회비 15,000원"
            
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewIntroduceCVCell.identifier, for: indexPath) as? DetailCrewIntroduceCVCell else{
                return UICollectionViewCell()
            }
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
    
    // kind는 supplementary view의 종류를 의미
    // section header로 넣을지 footer로 넣을지 저 kind를 통해 결정
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
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "DetailCrewFooterCRV",for: indexPath) as! DetailCrewFooterCRV
            
            switch indexPath.section {
            case 3:
                footerView.frame.size.height = 171.0
            default:
                footerView.frame.size.height = 0.0
            }
            return footerView
            
        default:
            assert(false, "응 아니야")
        }
    }
    
    // 섹션헤더 높이 지정
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
    
    // 섹션 푸터 높이 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 3:
            return CGSize(width: collectionView.bounds.width, height: 171)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        //let height =  collectionView.frame.height
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 211)
        }
        else if indexPath.section == 1 {
            return CGSize(width: width, height: 228)
        }
        else if indexPath.section == 2 {
            return CGSize(width: width, height: 724)
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

extension CrewDetailVC: GuestModalDelegate {
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
    
   
}

extension CrewDetailVC {
    func didSuccessCrewDetail(result: CrewDetailResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
        
    }
}
