//
//  CrewDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/01.
//

import UIKit
import Alamofire
import SDWebImage

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
    var detailInfo : CrewDetailResult?
    var status = false
    lazy var crewRegisterToggle = CrewRegisterService()
    
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
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        
        let stringChange = doubleToString.split(separator: ".")
        
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        
        return stringDate
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
            }
        crewRegisterToggle.postCrewRegisterService(delegate: self)
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
            
            switch detailInfo?.sportsID {
            case 1:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgFootThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 2:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgBaskThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 3:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgBadThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 4:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgVollThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 5:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgRunThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 6:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgHikeThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            default:
                break
            }
        
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewTitleCVCell.identifier, for: indexPath) as? DetailCrewTitleCVCell else{
                return UICollectionViewCell()
            }
            
            cell.titleLabel.text = detailInfo?.clubTitle
            
            cell.tagLabel.text = detailInfo?.sportsName
            cell.tagLabel.textColor = .wht

            cell.dayLabel[0].text = String(detailInfo?.schedules[0].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].endTime ?? 0)
            cell.dayLabel[1].text = String(detailInfo?.schedules[1].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].endTime ?? 0)
            cell.dayLabel[2].text = String(detailInfo?.schedules[2].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[indexPath.row].endTime ?? 0)
            
            switch detailInfo?.sportsID {
            case 1:
                cell.tagLabel.text = "축구/풋살"
                cell.tagView.backgroundColor = .sub04
            case 2:
                cell.tagLabel.text = "농구"
                cell.tagView.backgroundColor = .sub02
            case 3:
                cell.tagLabel.text = "배드민턴"
                cell.tagView.backgroundColor = .sub03
            case 4:
                cell.tagLabel.text = "배구"
                cell.tagView.backgroundColor = .sub01
            case 5:
                cell.tagLabel.text = "런닝"
                cell.tagView.backgroundColor = .sub05
            case 6:
                cell.tagLabel.text = "등산"
                cell.tagView.backgroundColor = .sub06
            default:
                break
            }

            cell.locationLabel.text = detailInfo?.areaName

            cell.moneyLabel[0].text = "정기회비" + " " + String(detailInfo?.dues ?? 0)
            cell.moneyLabel[1].text = "손님비" + " " + String(detailInfo?.guestDues ?? 0)
            
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewIntroduceCVCell.identifier, for: indexPath) as? DetailCrewIntroduceCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "소개"
            cell.peopleLabel.text = "인원:" + " " + String(detailInfo?.memberCount ?? 0) + "명"
            cell.ageLabel.text = detailInfo?.ageTable[indexPath.row]
            
            cell.contentLabel.text = detailInfo?.introduction
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "준비물"
            cell.contentLabel.text = detailInfo?.materials
            return cell
        }
        else if indexPath.section == 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "문의"
            cell.contentLabel.text = detailInfo?.inquiries
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "안내사항"
            cell.contentLabel.text = " - 가입 신청 및 손님 참여 신청 취소는 마이페이지 – 참여 신청한 크루 및 번개에서 가능합니다. \n (단, 손님 신청의 경우 운동 하루 전까지 취소 가능)\n\n - 가입 신청 및 손님 참여 신청 현황은 마이페이지 – 참여 신청한 크루 및 번개에서 확인 가능합니다. \n\n - 크루 가입 신청 승인 시 푸시 알림을 통해 알려드리며, 승인 시부터 내 활동에서 가입한 크루의 소식을 확인 가능합니다. \n\n"
            
            cell.contentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
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
                footerView.frame.size.height = 147.0
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
            return CGSize(width: collectionView.bounds.width, height: 147)
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
            return CGSize(width: width, height: 260)
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
            return CGSize(width: width, height: 300)
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
    
   
}

extension CrewDetailVC {
    func didSuccessCrewDetail(result: CrewDetailResult) {
        print("크루 디테일 조회 데이터가 성공적으로 들어왔습니다.")
        self.detailInfo = result
        detailCV.reloadData()
    }
    
    func didSuccessCrewRegister(result: CrewRegisterData) {
        print("크루 등록 토글이 성공적으로 들어옵니다.")
        print(result.message)
    }
    
    func didSuccessPinUpToggle(result: PinUpToggleData) {
        print("핀업 토글이 성공적으로 들어옵니다.")
        print(result.message)
        detailCV.reloadData()
    }

    func failedToRequest(message: String) {
        print("크루 디테일 조회 데이터가 들어오지 않았습니다.")

    }
}

extension CrewDetailVC: IntroduceDelegate {
    func dismissIntroducePopup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileNickname", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "ProfileNicknameVC") as? ProfileNicknameVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
