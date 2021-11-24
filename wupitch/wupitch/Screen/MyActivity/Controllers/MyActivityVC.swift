//
//  MyActivityVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class MyActivityVC: BaseVC {

    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var MyActivityCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setCVDelegate()
        
    }
    
    private func setStyle() {
        titleLabel.titleLabelFontSize()
    }
    
    private func setCVDelegate() {
        MyActivityCV.delegate = self
        MyActivityCV.dataSource = self
        
        MyActivityCV.register(ActivityCrewCVCell.nib(), forCellWithReuseIdentifier: ActivityCrewCVCell.identifier)
        MyActivityCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        
        // 아무것도 없을 때는 이거
        MyActivityCV.register(NoActivityCrewCVCell.nib(), forCellWithReuseIdentifier: NoActivityCrewCVCell.identifier)
        
        // Register Reusable View Cell
        MyActivityCV.register(ActivityCrewCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ActivityCrewCRV")
    }
}

extension MyActivityVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCrewCVCell.identifier, for: indexPath) as? ActivityCrewCVCell else{
                return UICollectionViewCell()
        }
        return cell
    }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                return UICollectionViewCell()
            }
            cell.pinImageView.image = UIImage(named: "leader")
            return cell
        }
    }
    
    // kind는 supplementary view의 종류를 의미
    // section header로 넣을지 footer로 넣을지 저 kind를 통해 결정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "ActivityCrewCRV",for: indexPath) as! ActivityCrewCRV
            
            switch indexPath.section {
            case 0:
                headerView.frame.size.height = 48.0
            case 1:
                headerView.frame.size.height = 48.0
                headerView.crewLabel.text = "예정된 번개"
            default:
                headerView.frame.size.height = 0.0
            }
            return headerView
        default:
            assert(false, "응 아니야")
        }
    }
    
    // 섹션헤더 높이 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 48)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 48)
        default:
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 누르면 해당 디테일 페이지로 이동
//        let storyboard = UIStoryboard.init(name: "CrewDetail", bundle: nil)
//
//        guard let dvc = storyboard.instantiateViewController(identifier: "CrewDetailVC") as? CrewDetailVC else {return}
//
//
//
//        self.tabBarController?.tabBar.isHidden = true
//        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        //let height =  collectionView.frame.height
        
        if indexPath.section == 0 {
            return CGSize(width: width-40, height: 176)
        }
        else {
            return CGSize(width: width-40, height: 144)
        }
    }
    
    // 위 아래 간격
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }

      // 옆 간격
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }
}
