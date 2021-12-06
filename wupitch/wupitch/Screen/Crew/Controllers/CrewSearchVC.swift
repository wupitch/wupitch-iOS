//
//  CrewSearchVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

enum tabEnum {
    case crew, bungae
}

class CrewSearchVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tabLinBungaeView: UIView!
    @IBOutlet weak var crewSearchCV: UICollectionView!
    @IBOutlet weak var tabLineView: UIView!
    @IBOutlet weak var bungaeBtn: UIButton!
    @IBOutlet weak var crewBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    
    lazy var crewSearchDataManager = CrewSearchService()
    var tabPage = [tabEnum.crew, tabEnum.bungae]
    var passwordEyeBtn = UIButton(type: .system)
    var clickBungae : Bool?
    //var searchText: CrewSearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordEyeSecure()
        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        searchTextField.delegate = self
        
        searchTextField.addTarget(self, action: #selector(searchData), for: .editingChanged)
        
        self.crewSearchCV.register(CrewSearchCVCell.nib(), forCellWithReuseIdentifier: CrewSearchCVCell.identifier)

        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
//        crewBtn.isUserInteractionEnabled = false
//        bungaeBtn.isUserInteractionEnabled = false
        
        tabLinBungaeView.backgroundColor = .clear

        searchTextField.backgroundColor = .gray05
        searchTextField.borderStyle = .none
        searchTextField.makeRounded(cornerRadius: 8.adjusted)
        searchTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        searchTextField.textColor = .gray03
        searchTextField.addPadding()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        bungaeBtn.sendActions(for: .touchUpInside)
//    }
//    override func viewDidAppear(_ animated: Bool) {
//           super.viewDidAppear(animated)
//           bungaeBtn.sendActions(for: .touchUpInside)
//           crewBtn.isUserInteractionEnabled = true
//           bungaeBtn.isUserInteractionEnabled = true
//       }
   
    @objc private func searchData() {
        crewSearchDataManager.getCrewSearch(keyword: searchTextField.text ?? "값없똥", delegate: self)
    }
    
    // cancel btn
    func passwordEyeSecure() {
        passwordEyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: searchTextField.frame.height))
        passwordEyeBtn.setImage(UIImage(named: "searchClose"), for: UIControl.State())
        let container = UIView(frame: passwordEyeBtn.frame)
        container.addSubview(passwordEyeBtn)
        searchTextField.rightView = container
        searchTextField.rightViewMode = .whileEditing

        passwordEyeBtn.addTarget(self, action: #selector(passwordEyeButtonClick), for: .touchUpInside)
    }

    // cancel btn addTarget
    @objc func passwordEyeButtonClick(_ sender: UIButton) {
        searchTextField.text = nil
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func touchUpCrewBtn(_ sender: Any) {
        crewSearchCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        // 번개탭바 안보이게
        tabLinBungaeView.backgroundColor = .clear
        // 탭바 보이게
        tabLineView.backgroundColor = .bk
        
    }
    
    @IBAction func touchUpBungaeBtn(_ sender: Any) {
        crewSearchCV.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        // 번개탭바 보이게
        tabLinBungaeView.backgroundColor = .bk
        // 탭바 안보이게
        tabLineView.backgroundColor = .clear
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CrewSearchVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
}

extension CrewSearchVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabPage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewSearchCVCell.identifier, for: indexPath) as? CrewSearchCVCell else{
                   return UICollectionViewCell()
               }
        cell.tabBar = tabPage[indexPath.row]
        
        if cell.tabBar == tabPage[0] {
            
        }
//        cell.searchDelegate = self
        return cell
    }
    
    //MARK: - Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: crewSearchCV.frame.width, height: crewSearchCV.frame.height)
        
    }
    
    //MARK: - Cell간의 좌우간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    //MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


extension CrewSearchVC {
    // 크루 검색 api
    func didSuccessCrewSearch(result: CrewSearchResult) {
        print("크루 검색 데이터가 성공적으로 들어왔습니다.")
        SignUpUserInfo.shared.crewSearchContent = result.content
        print("싱글턴", SignUpUserInfo.shared.crewSearchContent)
        //print("싱글턴갯수", SignUpUserInfo.shared.crewSearchContent.count)
        NotificationCenter.default.post(name: Notification.Name("reloadSection"), object: nil)
    }
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}



