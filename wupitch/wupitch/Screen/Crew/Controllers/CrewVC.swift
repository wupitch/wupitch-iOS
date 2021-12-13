//
//  CrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit
import Foundation
import SDWebImage

// 크루 홈 VC
class CrewVC: BaseVC {
    // MARK: - IBOutlets
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var crewCV: UICollectionView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var selectRegionBtn: UIButton!
    
    // MARK: - Variables
    //lazy var testFCM = FCMTestService()
    lazy var dataManager = AreaService()
    lazy var crewFilterAreaDataMangaer = LookUpCrewAreaFiletrService()
    lazy var crewDataManager = LookUpCrewService()
    lazy var patchFCMDeviceToken = PatchFCMService()
    var lookUpCrew : [LookUpCrewContent] = []
    var basicImage : UIImage?
    var dict = [String:[Any]]()
    
    // MARK: - LifeCycle
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
        tapGesture()
        // 지역 조회 API
        dataManager.getArea(delegate: self)
        // 디바이스 토큰 수정 API
        if let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") {
            patchFCMDeviceToken.patchFCM(PatchFCMRequest(deviceToken: deviceToken), delegate: self)
        }
    }
    // vieWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // test FCM API
        //testFCM.postFCM(FCMTestRequest(contents: "뭐냥", targetToken: "dZfNlWsIUkD9hjJLeoahu_:APA91bFbDH3MSdu_WMU7QcwMi4099qwvAsVCDb7iql4ysSxOtuLwDrdcfcC10g7glhRGohNL4tvU3AvaDQ8tWjKQNRz3nDUsfDDyW87HJDrUzGWGRG_C0BJA0HIGwiF9dnpnJm0YjkcC", title: "타이틀"), delegate: self)
        // 크루 조회 API
        crewFilterAreaDataMangaer.getLookUpCrewAreaFilter(delegate: self)
        print("크루 필터 파라미터 값 유저디폴트", UserDefaults.standard.dictionary(forKey: "filterParams"))
        crewDataManager.getLookUpCrew(params: UserDefaults.standard.dictionary(forKey: "filterParams") as? [String:[Any]], delegate: self)
    }
    
    // MARK: - Functions
    private func setStyle() {
        modalView.alpha = 0.0
        selectRegionBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22.adjusted)
        floatingView.makeRounded(cornerRadius: nil)
    }
    private func setCVDelegate() {
        crewCV.delegate = self
        crewCV.dataSource = self
        crewCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
        crewCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
    }
    private func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(format: "%.2f", doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
    // FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.floatingView.addGestureRecognizer(tapGesture)
    }
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewSports", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewSportsVC") as? MakeCrewSportsVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    // MARK: - IBActions
    // 검색 버튼
    @IBAction func touchUpSearchBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewSearch", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewSearchVC") as? CrewSearchVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    // 필터 버튼
    @IBAction func touchUpFilterBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewFilter", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewFilterVC") as? CrewFilterVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    // 알림 버튼
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewAlertVC") as? CrewAlertVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    // 지역구 버튼
    @IBAction func touchUpRegionBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
            dvc.modalPresentationStyle = .overFullScreen
            modalView.alpha = 1
            SignUpUserInfo.shared.bottomSheetMethod = .main
            
            // delegate
            dvc.modalDelegate = self
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
}

// MARK: - CollectionView Extension
extension CrewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if lookUpCrew.count > 0 {
            return lookUpCrew.count
        }
        else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if lookUpCrew.count > 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
                return UICollectionViewCell()
            }
            // 크루 이름 + 색상 + 크루 기본 이미지
            switch lookUpCrew[indexPath.row].sportsID {
            case 1:
                cell.tagNameLabel.text = "축구/풋살"
                cell.tagNameView.backgroundColor = .sub04
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgFoot")
                }
            case 2:
                cell.tagNameLabel.text = "배드민턴"
                cell.tagNameView.backgroundColor = .sub03
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgBad")
                }
            case 3:
                cell.tagNameLabel.text = "배구"
                cell.tagNameView.backgroundColor = .sub01
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgVoll")
                }
            case 4:
                cell.tagNameLabel.text = "농구"
                cell.tagNameView.backgroundColor = .sub02
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgBasket")
                }
            case 5:
                cell.tagNameLabel.text = "등산"
                cell.tagNameView.backgroundColor = .sub06
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgHike")
                }
            case 6:
                cell.tagNameLabel.text = "런닝"
                cell.tagNameView.backgroundColor = .sub05
                if let crewImage = lookUpCrew[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgRun")
                }
            default:
                break
            }
            // 핀업 버튼이 true일 때
            if lookUpCrew[indexPath.row].isPinUp == true {
                cell.pinImageView.isHidden = false
            }
            else {
                cell.pinImageView.isHidden = true
            }
            // 크루 제목
            cell.titleLabel.text = lookUpCrew[indexPath.row].clubTitle
            // 크루 날짜
            cell.dayLabels[0].text = lookUpCrew[indexPath.row].schedules[0].day
            // 시작시간 옵셔널이라서 바인딩
            if let starTime = lookUpCrew[indexPath.row].schedules[0].startTime {
                cell.dayLabels[1].text = stringDate(doubleDate: starTime)
            } else {
                cell.dayLabels[1].text = nil
            }
            // 끝나는시간 옵셔널이라 바인딩
            if let endTime = lookUpCrew[indexPath.row].schedules[0].endTime {
                cell.dayLabels[3].text = stringDate(doubleDate: endTime)
            } else {
                cell.dayLabels[3].text = nil
            }
            cell.dayLabels[2].text = "-"
            // 크루 모이는 날이 많을 경우 '+' 붙여주기
            if lookUpCrew[indexPath.row].schedules.count > 1 {
                cell.dayLabels[4].isHidden = false
            } else {
                cell.dayLabels[4].isHidden = true
            }
            // 장소가 지정되어있지 않을 경우 "장소미정" 뜨게함
            cell.subLabel.text = lookUpCrew[indexPath.row].areaName ?? "장소미정"
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            cell.readyLabel.text = "크루가 없어요."
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if lookUpCrew.count > 0 {
            // 크루 아이디 저장
            UserDefaults.standard.set(lookUpCrew[indexPath.row].clubID, forKey: "clubID")
            // cell 누르면 해당 디테일 페이지로 이동
            let storyboard = UIStoryboard.init(name: "CrewDetail", bundle: nil)
            guard let dvc = storyboard.instantiateViewController(identifier: "CrewDetailVC") as? CrewDetailVC else {return}
            dvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(dvc, animated: true)
            
        } else {
            print("크루 값이 없습니다.")
        }
    }
    // collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if lookUpCrew.count > 0 {
            let width = self.view.frame.width
            return CGSize(width: width-40, height: 133)
        }
        else {
            let width = self.view.frame.width
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if lookUpCrew.count > 0 {
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - Modal Delegate Extension
extension CrewVC: ModalDelegate {
    // 모달에서 확인 버튼 눌렀을 때 다음 버튼에 생기는 색 변화
    func selectBtnToNextBtn() {
    }
    // 모달이 dismiss되면서 모달백그라운드 색도 없어짐
    func modalDismiss() {
        modalView.alpha = 0.0
        crewCV.reloadData()
    }
    // textField에 모달에서 선택했던 피커 값 넣어주기
    func textFieldData(data: String) {
        selectRegionBtn.setTitle(data, for: .normal)
        for i in 0...25 {
            if data == SignUpUserInfo.shared.areaName?[i] {
                dict["crewPickAreaID"] = [i+1]
            }
        }
//        print("크루지역", UserDefaults.standard.dictionary(forKey: "filterParams"))
//        UserDefaults.standard.set(dict, forKey: "filterParams")
        UserDefaults.standard.set(dict, forKey: "areaParams")
      print("지역 필터 파라미터 값 유저디폴트", UserDefaults.standard.dictionary(forKey: "areaParams"))
      crewDataManager.getLookUpCrew(params: UserDefaults.standard.dictionary(forKey: "areaParams") as? [String:[Any]], delegate: self)
    }
}

// MARK: - API Extension
extension CrewVC {
    // 지역 api
    func didSuccessArea(result: [AreaResult]) {
        print("데이터가 성공적으로 들어왔습니다.")
        // 초기화
        SignUpUserInfo.shared.areas = []
        SignUpUserInfo.shared.areaName = []
        // 유저디폴트에 지역 값 넣어주기
        for i in 0...25 {
            UserDefaults.standard.set(result[i].areaID, forKey: "areaId")
            UserDefaults.standard.set(result[i].name, forKey: "areaName")
            // 싱글톤에 넣어주기
            SignUpUserInfo.shared.areas?.append(result[i].areaID)
            SignUpUserInfo.shared.areaName?.append(result[i].name)
            SignUpUserInfo.shared.bungaeAreaName?.append(result[i].name)
        }
    }
    // 크루 조회 api
    func didSuccessLookUpCrew(result: LookUpCrewDataResult) {
        print("조회데이터가 성공적으로 들어왔습니다.")
        lookUpCrew = result.content
        crewCV.reloadData()
    }
    // 크루 지역 필터 조회 api
    func didSuccessLookUpCrewAreaFilter(result: LookUpCrewFilterResult) {
        print("지역 필터 조회 데이터가 성공적으로 들어왔습니다.")
        // 눌렸던 지역이 있다면
        if let areaId = result.crewPickAreaName {
            selectRegionBtn.setTitle(areaId, for: .normal)
        }
    }
    // 디바이스 토큰 수정 api
    func didSuccessPatchFCM(result: PatchFCMData) {
        print("디바이스 토큰 수정 데이터가 성공적으로 들어왔습니다.")
        print("디바이스 토큰", UserDefaults.standard.string(forKey: "deviceToken"))
    }
    // 에프씨엠테스트에이피아이
    //    func didSuccessFCMTest(result: FCMTestData) {
    //        print("fcm test 데이터가 성공적으로 들어왔습니다.")
    //    }
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}


