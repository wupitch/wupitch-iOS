//
//  ImpromptuVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit
import SDWebImage

class BungaeVC: BaseVC {

    @IBOutlet weak var bungaeCV: UICollectionView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var selectRegionBtn: UIButton!
    
    lazy var bungaeAreaFilterDataManager = LookUpBungaeAreaFiletrService()
    lazy var bungaeDataManager = LookUpBungeService()
    var lookUpBungaeResult : [LookUpBungaeContent] = []
//    var schedule : LookUpBungaeContent?
    var bungaeAreaDict = [String:[Any]]()
    var bungaeAreaName : LookUpBungaeFilterResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCVDelegate()
        tapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 번개 지역 필터 조회
        bungaeAreaFilterDataManager.getLookUpBungaeAreaFilter(delegate: self)
        print("번개 필터 파라미터 값 유저디폴트", UserDefaults.standard.dictionary(forKey: "bungaeFilterParams"))
        bungaeDataManager.getLookUpBunge(params: UserDefaults.standard.dictionary(forKey: "bungaeFilterParams") as? [String:[Any]], delegate: self)
    }
    
    private func setStyle() {
        modalView.alpha = 0.0
        selectRegionBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22.adjusted)
        floatingView.makeRounded(cornerRadius: nil)
    }
    
    private func setCVDelegate() {
        bungaeCV.delegate = self
        bungaeCV.dataSource = self
        bungaeCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        bungaeCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
    }
    
    // MARK: FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.floatingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaeRegion", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaeRegionVC") as? MakeBungaeRegionVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpSearchBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewSearch", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewSearchVC") as? CrewSearchVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpFilterBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "BungaeFilter", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "BungaeFilterVC") as? BungaeFilterVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewAlertVC") as? CrewAlertVC {
            dvc.hidesBottomBarWhenPushed = true
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
        let doubleToString = String(format: "%.2f", doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
}

extension BungaeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if lookUpBungaeResult.count > 1 {
            return lookUpBungaeResult.count
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if lookUpBungaeResult.count > 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                return UICollectionViewCell()
            }
            
            // 디데이 숫자가 1일때만 백그라운드 색 진하게
            if  lookUpBungaeResult[indexPath.row].dday == 1 {
                cell.tagNameView.backgroundColor = .bk
                cell.tagNameLabel.textColor = .wht
            }
            else {
                cell.tagNameView.backgroundColor = .gray03
                cell.tagNameLabel.textColor = .wht
            }
            
            // 셀이미지
            if lookUpBungaeResult[indexPath.row].impromptuImage == nil {
                cell.imageView.image = UIImage(named: "imgBungae")
            }
            else {
                cell.imageView.sd_setImage(with: URL(string: lookUpBungaeResult[indexPath.row].impromptuImage ?? ""))
            }
            
            cell.tagNameLabel.text = String("D-") + String(lookUpBungaeResult[indexPath.row].dday)
            
            cell.titleLabel.text = lookUpBungaeResult[indexPath.row].title
            cell.dayLabel.text = String(lookUpBungaeResult[indexPath.row].date) + " " + String(lookUpBungaeResult[indexPath.row].day) + " " + stringDate(doubleDate: Double(lookUpBungaeResult[indexPath.row].startTime ?? 0))
            cell.subLabel.text = lookUpBungaeResult[indexPath.row].location
            cell.bungaeCountLabel.text = String(lookUpBungaeResult[indexPath.row].nowMemberCount ) + "/" + String(lookUpBungaeResult[indexPath.row].recruitmentCount)
            
            // 핀업버튼이 true일 때
            if lookUpBungaeResult[indexPath.row].isPinUp == true {
                cell.pinImageView.isHidden = false
            }
            else {
                cell.pinImageView.isHidden = true
            }
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            cell.readyLabel.text = "번개가 없어요."
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if lookUpBungaeResult.count > 1 {
            // 유저디폴트에 번개 아이디 저장
            UserDefaults.standard.set(lookUpBungaeResult[indexPath.row].impromptuID, forKey: "impromptuID")
            
            // cell 누르면 해당 디테일 페이지로 이동
            let storyboard = UIStoryboard.init(name: "BungaeDetail", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "BungaeDetailVC") as? BungaeDetailVC else {return}
            
            dvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            print("값이 없어요.")
        }
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if lookUpBungaeResult.count > 1 {
            let width = self.view.frame.width
            return CGSize(width: width-40, height: 150)
        }
        else {
            let width = self.view.frame.width
            let height =  collectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if lookUpBungaeResult.count > 1 {
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - Extension (Modal Delegate)
extension BungaeVC: ModalDelegate {
    // 모달에서 확인 버튼 눌렀을 때 다음 버튼에 생기는 색 변화
    func selectBtnToNextBtn() {
    }
    // 모달이 dismiss되면서 모달백그라운드 색도 없어짐
    func modalDismiss() {
        modalView.alpha = 0.0
        bungaeCV.reloadData()
    }
    // textField에 모달에서 선택했던 피커 값 넣어주기
    func textFieldData(data: String) {
        selectRegionBtn.setTitle(data, for: .normal)
        
        for i in 0...25 {
            if data == SignUpUserInfo.shared.bungaeAreaName?[i] {
                bungaeAreaDict["areaId"] = [i+1]
            }
        }
        // 번개 지역 필터 조회
        UserDefaults.standard.set(bungaeAreaDict, forKey: "areaBungaeParams")
        print("지역 번개 필터 적용하기", UserDefaults.standard.dictionary(forKey: "areaBungaeParams"))
        print("지역 번개 필터 파라미터 값 유저디폴트", UserDefaults.standard.dictionary(forKey: "areaBungaeParams"))
        bungaeDataManager.getLookUpBunge(params: UserDefaults.standard.dictionary(forKey: "areaBungaeParams") as? [String:[Any]], delegate: self)
    }
}

extension BungaeVC {
    // 번개 조회 api
    func didSuccessLookUpBungae(result: LookUpBungaeResult) {
        print("번개조회데이터가 성공적으로 들어왔습니다.")
        lookUpBungaeResult = result.content
        bungaeCV.reloadData()
    }
    // 번개 지역 필터 조회 api
    func didSuccessLookUpBungaeAreaFilter(result: LookUpBungaeFilterResult) {
        bungaeAreaName = result
        print("번개 지역 필터 조회 데이터가 성공적으로 들어왔습니다.")
        // 눌린 지역이 있다면
        if let name = result.impromptuPickAreaName {
            selectRegionBtn.setTitle(name, for: .normal)
        }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}
