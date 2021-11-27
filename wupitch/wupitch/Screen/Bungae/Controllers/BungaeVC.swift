//
//  ImpromptuVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class BungaeVC: BaseVC {

    @IBOutlet weak var bungaeCV: UICollectionView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var selectRegionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCVDelegate()
        tapGesture()
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
    }
    
    // MARK: FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.floatingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaeRegion", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaeRegionVC") as? MakeBungaeRegionVC {
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "BungaeFilter", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "BungaeFilterVC") as? BungaeFilterVC {
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
}

extension BungaeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 일단은 다섯개로
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
            return UICollectionViewCell()
        }
        
        cell.tagNameLabel.text = "D-1"
        cell.titleLabel.text = "가나다라마바이ㅏ러니아러니ㅏㅇ러사아자차카타파하"
        cell.dayLabel.text = "월요일 24:00 - 24:00"
        cell.subLabel.text = "가나다라마바사아자차카타파하"
        cell.bungaeCountLabel.text = "2/3"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 누르면 해당 디테일 페이지로 이동
        let storyboard = UIStoryboard.init(name: "BungaeDetail", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "BungaeDetailVC") as? BungaeDetailVC else {return}
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        //let height =  collectionView.frame.height
        
        
        return CGSize(width: width-40, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
}


// MARK: - Extension (Modal Delegate)
extension BungaeVC: ModalDelegate {
    
    
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

