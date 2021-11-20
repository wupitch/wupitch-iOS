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
    
    var tabPage = [tabEnum.crew, tabEnum.bungae]
    var passwordEyeBtn = UIButton(type: .system)
    var clickBungae : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordEyeSecure()
        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        
        self.crewSearchCV.register(CrewSearchCVCell.nib(), forCellWithReuseIdentifier: CrewSearchCVCell.identifier)

        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        crewBtn.isUserInteractionEnabled = false
        bungaeBtn.isUserInteractionEnabled = false
        
        tabLineView.backgroundColor = .clear

        searchTextField.backgroundColor = .gray05
        searchTextField.borderStyle = .none
        searchTextField.makeRounded(cornerRadius: 8.adjusted)
        searchTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        searchTextField.textColor = .gray03
        searchTextField.addPadding()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        bungaeBtn.sendActions(for: .touchUpInside)
//    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           bungaeBtn.sendActions(for: .touchUpInside)
           crewBtn.isUserInteractionEnabled = true
           bungaeBtn.isUserInteractionEnabled = true
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
        print("번개터치")
        crewSearchCV.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        // 번개탭바 보이게
        tabLinBungaeView.backgroundColor = .bk
        // 탭바 안보이게
        tabLineView.backgroundColor = .clear
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
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


    

