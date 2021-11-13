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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        
        self.crewSearchCV.register(CrewSearchCVCell.nib(), forCellWithReuseIdentifier: CrewSearchCVCell.identifier)

        crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        tabLinBungaeView.backgroundColor = .clear
        
        searchTextField.backgroundColor = .gray05
        searchTextField.borderStyle = .none
        searchTextField.makeRounded(cornerRadius: 8.adjusted)
        searchTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        searchTextField.textColor = .gray03
        searchTextField.addLeftPadding()
    }
    
    @IBAction func touchUpCrewBtn(_ sender: Any) {
        crewSearchCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
       
        if crewBtn.isSelected == true && bungaeBtn.isSelected == false{
            crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
            bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
            // 번개탭바 보이게
            tabLinBungaeView.backgroundColor = .bk
            // 탭바 안보이게
            tabLineView.backgroundColor = .clear
        }
        else {
            crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
            bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
            // 번개탭바 안보이게
            tabLinBungaeView.backgroundColor = .clear
            // 탭바 보이게
            tabLineView.backgroundColor = .bk
        }
    }
    
    @IBAction func touchUpBungaeBtn(_ sender: Any) {
        crewSearchCV.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
       
        if crewBtn.isSelected == false && bungaeBtn.isSelected == true{
            crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
            bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
            // 번개탭바 안보이게
            tabLinBungaeView.backgroundColor = .clear
            // 탭바 보이게
            tabLineView.backgroundColor = .bk
        }
        else {
            crewBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
            bungaeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
            // 번개탭바 보이게
            tabLinBungaeView.backgroundColor = .bk
            // 탭바 안보이게
            tabLineView.backgroundColor = .clear
        }
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


    

