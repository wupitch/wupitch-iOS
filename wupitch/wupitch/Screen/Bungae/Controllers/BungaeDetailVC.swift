//
//  BungaeDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/18.
//

import UIKit
import Alamofire
import SDWebImage

class BungaeDetailVC: BaseVC {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var detailTV: UITableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    var registerCheck : BungaeRegisterData?
    var detailInfo : BungaeDetailResult?
    lazy var bungaeDetailDataManager = BungaeDetailService()
    lazy var bungaeRegisterDataManager = BungaeRegisterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setCVDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bungaeDetailDataManager.getBungaeDetail(delegate: self)
        
    }
    private func setStyle() {
        // 테이블 뷰 경계션 없애기
        detailTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
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
        detailTV.delegate = self
        detailTV.dataSource = self
        self.detailTV.register(BungaeImageCVCell.nib(), forCellReuseIdentifier: BungaeImageCVCell.identifier)
        self.detailTV.register(BungaeTitleCVCell.nib(), forCellReuseIdentifier: BungaeTitleCVCell.identifier)
        self.detailTV.register(DetailCrewIntroduceTVCell.nib(), forCellReuseIdentifier: DetailCrewIntroduceTVCell.identifier)
        self.detailTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.detailTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.detailTV.register(BungaeInfoCVCell.nib(), forCellReuseIdentifier: BungaeInfoCVCell.identifier)
    }
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        
        let stringChange = doubleToString.split(separator: ".")
        
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        
        return stringDate
    }
    @IBAction func touchUpRegisterBtn(_ sender: Any) {
        // 사용자의 자기소개 부분이 비어있다면 정보가 부족하다는 알림창을 띄워주고, 그렇지 않다면 가입 신청이 완료되었다는 창 띄워주기
//        if UserDefaults.standard.string(forKey: "introduce") == nil && UserDefaults.standard.string(forKey: "pageAreaName") == nil && UserDefaults.standard.string(forKey: "pageSports") == nil && UserDefaults.standard.string(forKey: "pageAge") == nil && UserDefaults.standard.string(forKey: "pagePhone") == nil {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
//                dvc.modalPresentationStyle = .overFullScreen
//                dvc.modalTransitionStyle = .crossDissolve
//                dvc.introducePopUp = self
//                dvc.subLabel = "모든 프로필에 정보가 기입되어야 \n 번개에 신청할 수 있습니다."
//                // present 형태로 띄우기
//                self.present(dvc, animated: true, completion: nil)
//            }
//        }
//        else {
//            // 가입 완료 팝업 창 띄워줌
//            let storyBoard: UIStoryboard = UIStoryboard(name: "GuestComplete", bundle: nil)
//
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "GuestCompleteVC") as? GuestCompleteVC {
//                dvc.modalPresentationStyle = .overFullScreen
//                dvc.modalTransitionStyle = .crossDissolve
//                dvc.firstLabel = "참여 신청이 완료됐습니다! \n 문의를 통해 번개 리더와 연락할 수 있어요."
//                dvc.secondLabel = "페이지 하단 문의를 통해 번개 리더에게 \n 연락해주세요."
//
//                // present 형태로 띄우기
//                self.present(dvc, animated: true, completion: nil)
//            }
            bungaeRegisterDataManager.postBungaeRegisterService(delegate: self)
//        }
    }
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension BungaeDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeImageCVCell.identifier) as? BungaeImageCVCell else{
                return UITableViewCell()
            }
            // 사진이 있을 때
            if detailInfo?.impromptuImage != nil {
                cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.impromptuImage ?? ""))
            }
            // 사진이 없을 때
            else {
                cell.mainImgView.image = UIImage(named: "imgBungaeThumb")
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
        else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeTitleCVCell.identifier) as? BungaeTitleCVCell else{
                return UITableViewCell()
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
            cell.countLabel.text = String(detailInfo?.nowMemberCount ?? 0) + "/" + String(detailInfo?.recruitmentCount ?? 0) + "명 참여"
            
            return cell
        }
        else if indexPath.section == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewIntroduceTVCell.identifier) as? DetailCrewIntroduceTVCell else{
                return UITableViewCell()
            }
            cell.titleLabel.text = "소개"
            cell.contentLabel.text = detailInfo?.introduction
            cell.peopleLabel.isHidden = true
            cell.ageLabel.isHidden = true
            
            return cell
        }
        else if indexPath.section == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "준비물"
            cell.contentLabel.text = detailInfo?.materials
            
            return cell
        }
        else if indexPath.section == 4 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            cell.titleLabel.text = "문의"
            cell.contentLabel.text = detailInfo?.inquiries
            return cell
        }
        else if indexPath.section == 5 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeInfoCVCell.identifier) as? BungaeInfoCVCell else{
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension BungaeDetailVC: GuestModalDelegate, IntroduceDelegate {
    
    func toProfile() {
        //
    }
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    func selectBtnToOpenPopup(check:Bool) {
        //
    }
    func dismissIntroducePopup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileDetail", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "ProfileDetailVC") as? ProfileDetailVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension BungaeDetailVC {
    func didSuccessBungaeDetail(result: BungaeDetailResult) {
        print("번개 디테일 데이터가 성공적으로 들어왔습니다.")
        self.detailInfo = result
        detailTV.reloadData()
    }
    
    func didSuccessBungaeRegister(result: BungaeRegisterResult) {
        print("번개 등록(가입)이 성공적으로 되었습니다.")
        // 성공하면 가입 완료 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "GuestComplete", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "GuestCompleteVC") as? GuestCompleteVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            dvc.firstLabel = "참여 신청이 완료됐습니다! \n 문의를 통해 번개 리더와 연락할 수 있어요."
            dvc.secondLabel = "페이지 하단 문의를 통해 번개 리더에게 \n 연락해주세요."
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
        if message == "필요한 모든 정보를 입력해주세요." {
            let storyBoard: UIStoryboard = UIStoryboard(name: "UserInfoWarning", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "UserInfoWarningVC") as? UserInfoWarningVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                dvc.introducePopUp = self
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }
}
