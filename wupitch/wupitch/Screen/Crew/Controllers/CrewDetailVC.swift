//
//  CrewDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import UIKit
import Alamofire
import SDWebImage

class CrewDetailVC: BaseVC {

    @IBOutlet weak var CrewDetailTV: UITableView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!

    lazy var crewDetailDataManager = CrewDetailService()
    lazy var crewRegisterToggle = CrewRegisterService()
    var detailInfo : CrewDetailResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
        setCellRegister()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crewDetailDataManager.getCrewDetail(delegate: self)
       
    }

    func setStyle() {
        // 테이블 뷰 경계션 없애기
        CrewDetailTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
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
    func setDelegate() {
        CrewDetailTV.delegate = self
        CrewDetailTV.dataSource = self
    }
    // setCellRegister
    func setCellRegister() {
        // cell
        self.CrewDetailTV.register(DetailCrewImgTVCell.nib(), forCellReuseIdentifier: DetailCrewImgTVCell.identifier)
        self.CrewDetailTV.register(DetailCrewTitleTVCell.nib(), forCellReuseIdentifier: DetailCrewTitleTVCell.identifier)
        self.CrewDetailTV.register(DetailCrewIntroduceTVCell.nib(), forCellReuseIdentifier: DetailCrewIntroduceTVCell.identifier)
        self.CrewDetailTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.CrewDetailTV.register(DetailCrewInquireCVCell.nib(), forCellReuseIdentifier: DetailCrewInquireCVCell.identifier)
        self.CrewDetailTV.register(DetailCrewFooterTVCell.nib(), forCellReuseIdentifier: DetailCrewFooterTVCell.identifier)
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
        if UserDefaults.standard.string(forKey: "introduce") == nil {
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
            crewRegisterToggle.postCrewRegisterService(delegate: self)
        }
    }
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
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

// MARK: - Extension
extension CrewDetailVC: UITableViewDelegate, UITableViewDataSource {
    // 셀 섹션
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
        
    }
    // 사이즈 자동 조정에 기준이 되는 값
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 211
        }
        else {
            return UITableView.automaticDimension
        }
    }

    // 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewImgTVCell.identifier) as? DetailCrewImgTVCell else{
                return UITableViewCell()
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
                    cell.mainImgView.image = UIImage(named: "imgBadThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 3:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgVollThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 4:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgBaskThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 5:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgHikeThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 6:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgRunThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            default:
                break
            }
            
            // 핀업이 됐을 때 안됐을 때
            if detailInfo?.isPinUp == true {
                cell.status = true
                cell.pinBtn.setImage(UIImage(named: "selecPin"), for: .normal)
            }
            else {
                cell.status = false
                cell.pinBtn.setImage(UIImage(named: "pin"), for: .normal)
            }
            
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewTitleTVCell.identifier) as? DetailCrewTitleTVCell else{
                return UITableViewCell()
            }
            
            // 스포츠 아이디 라벨에 맞게
            switch detailInfo?.sportsID {
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
            
            // 무조건 있는 값들
            cell.titleLabel.text = detailInfo?.clubTitle
            cell.tagLabel.textColor = .wht
            
            // 지역이 없을 때
            if detailInfo?.areaName == nil {
                cell.locationLabel.text = "장소미정"
            } else {
                cell.locationLabel.text = detailInfo?.areaName
            }
            
            // 정기회비가 없을 때
            if detailInfo?.dues == nil {
                cell.moneyLabel[0].text = "정기회비가 없어요."
                cell.moneyLabel[0].textColor = .bk
            }
            else {
                cell.moneyLabel[0].text = "정기회비" + " " + String(detailInfo?.dues ?? 0) + "원"
            }

            // 손님비가 없을 때
            if detailInfo?.guestDues == nil {
                cell.moneyLabel[1].text = "손님비가 없어요."
            }
            else {
                cell.moneyLabel[1].text = "손님비" + " " + String(detailInfo?.guestDues ?? 0) + "원"
            }
            
            
            cell.dayLabel[indexPath.row].text = String(detailInfo?.schedules?[indexPath.row].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules?[indexPath.row].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules?[indexPath.row].endTime ?? 0)
            
            cell.dayLabel[1].isHidden = true
            cell.dayLabel[2].isHidden = true
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewIntroduceTVCell.identifier) as? DetailCrewIntroduceTVCell else{
                return UITableViewCell()
            }
            
            // 디테일 페이지 손님 참여할 때 바텀 시트에 값 넣어주기 위해
            SignUpUserInfo.shared.bottomDates = detailInfo?.schedules ?? []
            
            cell.titleLabel.text = "소개"
            // 인원이 없을 때
            if detailInfo?.memberCount == nil {
                cell.peopleLabel.isHidden = true
            }
            else {
                cell.peopleLabel.isHidden = false
                cell.peopleLabel.text = "인원:" + " " + String(detailInfo?.memberCount ?? 0) + "명"
            }
            // 연령대가 있을 때
            if let age = detailInfo?.ageTable {
                cell.ageLabel.isHidden = false
                for i in age {
                    cell.ageLabel.text = "연령:" + " " + i
                }
            }
            else {
                cell.ageLabel.isHidden = true
            }
            cell.contentLabel.text = detailInfo?.introduction
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            cell.titleLabel.text = "준비물"
            if detailInfo?.materials == nil {
                cell.contentLabel.text = "준비물이 없어요."
            }
            else {
                cell.contentLabel.text = detailInfo?.materials
            }
            return cell
        } else if indexPath.section == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewFooterTVCell.identifier) as? DetailCrewFooterTVCell else{
                return UITableViewCell()
            }
            return cell
        } else if indexPath.section == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            cell.titleLabel.text = "문의"
            cell.contentLabel.text = detailInfo?.inquiries
            return cell
        } else if indexPath.section == 6 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewInquireCVCell.identifier) as? DetailCrewInquireCVCell else{
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
}
extension CrewDetailVC: GuestModalDelegate {
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    func selectBtnToOpenPopup() {
        // 자기소개가 없으면 정보가 부족하다는 알럿창 띄우고, 있으면 손님으로 가입 되었다는 알림창 띄울 수 있도록
        if UserDefaults.standard.string(forKey: "introduce") == nil {
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
//        UserDefaults.standard.string(forKey: "clubID")
        self.detailInfo = result
        print("정기회비", result.dues)
        print("손님비", result.guestDues)
        
        CrewDetailTV.reloadData()
    }

    func didSuccessCrewRegister(result: CrewRegisterData) {
        print("크루 등록 토글이 성공적으로 들어옵니다.")
        print(result.message)
    }

    func didSuccessPinUpToggle(result: PinUpToggleData) {
        print("핀업 토글이 성공적으로 들어옵니다.")
        print(result.message)
        CrewDetailTV.reloadData()
    }
    
    func didSuccessGuestRegister(result: GuestRegisterData) {
        print("게스트 참여가 성공적으로 들어옵니다.")
        
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
