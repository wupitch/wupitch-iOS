//
//  CrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit
import Foundation
import SDWebImage

// 스포츠 아이디로 사진이랑 색이랑 이름 엮어야해

class CrewVC: BaseVC {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var crewCV: UICollectionView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var selectRegionBtn: UIButton!
    
    lazy var dataManager = AreaService()
    lazy var crewDataManager = LookUpCrewService()
    var lookUpCrewResult : LookUpCrewDataResult?
    var schedule : LookUpContent?
    var basicImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
        tapGesture()
        dataManager.getArea(delegate: self)
        crewDataManager.getLookUpCrew(request: LookUpCrewRequest(ageList: SignUpUserInfo.shared.ageListBtn ?? [-1], areaId: SignUpUserInfo.shared.areaIdBtn ?? -1, days: SignUpUserInfo.shared.daysBtn ?? [-1], isAsc: SignUpUserInfo.shared.isAsc ?? true, memberCountValue: SignUpUserInfo.shared.memberCountValueBtn ?? -1, page: SignUpUserInfo.shared.page ?? -1, size: SignUpUserInfo.shared.size ?? 10, sortBy: SignUpUserInfo.shared.sortBy ?? "updatedAt", sportsList:SignUpUserInfo.shared.sportsListBtn ?? [-1]), delegate: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setStyle() {
        modalView.alpha = 0.0
        selectRegionBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22.adjusted)
        floatingView.makeRounded(cornerRadius: nil)
    }
    
    private func setCVDelegate() {
        crewCV.delegate = self
        crewCV.dataSource = self
        crewCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
    }
    
    //    func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat {
    //          let width = view.frame.width - 10
    //          let estimatedHeight: CGFloat = 800.0
    //          let dummyCell = ChatCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
    //          dummyCell.layoutIfNeeded()
    //          let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
    //          return estimateSize.height
    //    }
    
    
    
    
    // MARK: FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.floatingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewSports", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewSportsVC") as? MakeCrewSportsVC {
            self.tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpSearchBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewSearch", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewSearchVC") as? CrewSearchVC {
            self.tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpFilterBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewFilter", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewFilterVC") as? CrewFilterVC {
            self.tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewAlertVC") as? CrewAlertVC {
            self.tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    
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
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        
        let stringChange = doubleToString.split(separator: ".")
        
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        
        return stringDate
    }
    
    
}

extension CrewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookUpCrewResult?.content.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
            return UICollectionViewCell()
        }
        
        switch lookUpCrewResult?.content[indexPath.row].sportsID {
        case 1:
            cell.tagNameLabel.text = "축구/풋살"
            cell.tagNameView.backgroundColor = .sub04
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgFoot")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        case 2:
            cell.tagNameLabel.text = "농구"
            cell.tagNameView.backgroundColor = .sub02
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgBasket")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        case 3:
            cell.tagNameLabel.text = "배드민턴"
            cell.tagNameView.backgroundColor = .sub03
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgBad")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        case 4:
            cell.tagNameLabel.text = "배구"
            cell.tagNameView.backgroundColor = .sub01
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgVoll")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        case 5:
            cell.tagNameLabel.text = "런닝"
            cell.tagNameView.backgroundColor = .sub05
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgRun")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        case 6:
            cell.tagNameLabel.text = "등산"
            cell.tagNameView.backgroundColor = .sub06
            if lookUpCrewResult?.content[indexPath.row].crewImage == nil {
                cell.imageView.image = UIImage(named: "imgHike")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpCrewResult?.content[indexPath.row].crewImage ?? ""))
            }
        default:
            break
        }
        
        // 핀업버튼이 true일 때
        if lookUpCrewResult?.content[indexPath.row].isPinUp == true {
            cell.pinImageView.isHidden = false
        }
        else {
            cell.pinImageView.isHidden = true
        }
        
        // 나머지 값들
        //cell.tagNameLabel.text = lookUpCrewResult?.content[indexPath.row].sportsName
        cell.titleLabel.text = lookUpCrewResult?.content[indexPath.row].clubTitle
        
        cell.dayLabels[0].text = lookUpCrewResult?.content[indexPath.row].schedules[0].day
        cell.dayLabels[1].text = stringDate(doubleDate: lookUpCrewResult?.content[indexPath.row].schedules[0].startTime ?? -1.0)
        cell.dayLabels[3].text = stringDate(doubleDate: lookUpCrewResult?.content[indexPath.row].schedules[0].endTime ?? -1.0)
        cell.dayLabels[4].isHidden = true
        
        // 장소가 지정되어있지 않을 경우 "장소미정" 뜨게함
        cell.subLabel.text = lookUpCrewResult?.content[indexPath.row].areaName ?? "장소미정"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 누르면 해당 디테일 페이지로 이동
        let storyboard = UIStoryboard.init(name: "CrewDetail", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "CrewDetailVC") as? CrewDetailVC else {return}
        
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        //let height =  collectionView.frame.height
        
        return CGSize(width: width-40, height: 133)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
}


// MARK: - Extension (Modal Delegate)
extension CrewVC: ModalDelegate {
    
    
    // 모달에서 확인 버튼 눌렀을 때 다음 버튼에 생기는 색 변화
    func selectBtnToNextBtn() {
        //
    }
    
    // 모달이 dismiss되면서 모달백그라운드 색도 없어짐
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    
    // textField에 모달에서 선택했던 피커 값 넣어주기
    func textFieldData(data: String) {
        selectRegionBtn.setTitle(data, for: .normal)
        //SignUpUserInfo.shared.region = data
    }
}


// 지역 api 연결
extension CrewVC {
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
        }
    }
    
    // 크루 조회 api
    func didSuccessLookUpCrew(result: LookUpCrewDataResult) {
        print("조회데이터가 성공적으로 들어왔습니다.")
        lookUpCrewResult = result
        
        crewCV.reloadData()
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}
