//
//  MyActivityVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class MyActivityVC: BaseVC {

    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var MyActivityCV: UICollectionView!
    
    // 현재 가입한 크루 조회 API
    lazy var nowRegisterCrewDataManager = NowRegisterCrewService()
    var nowRegisterData : [NowRegisterCrewResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 현재 가입한 크루 조회 API
        nowRegisterCrewDataManager.getNowRegisterCrew(delegate: self)
    }
    
    private func setStyle() {
        titleLabel.titleLabelFontSize()
    }
    
    private func setCVDelegate() {
        MyActivityCV.delegate = self
        MyActivityCV.dataSource = self
        
        MyActivityCV.register(ActivityCrewCVCell.nib(), forCellWithReuseIdentifier: ActivityCrewCVCell.identifier)
        MyActivityCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        MyActivityCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
        
        // 아무것도 없을 때는 이거
        MyActivityCV.register(NoActivityCrewCVCell.nib(), forCellWithReuseIdentifier: NoActivityCrewCVCell.identifier)
        
        // Register Reusable View Cell
        MyActivityCV.register(ActivityCrewCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ActivityCrewCRV")
    }
    
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewAlertVC") as? CrewAlertVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension MyActivityVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if nowRegisterData.count < 1 {
                return 1
            }
            else {
                return nowRegisterData.count
            }
        }
        else {
            return 5
        }
//        return 1
    }
    // 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
//            return UICollectionViewCell()
//        }
//        return cell
//    }
        if indexPath.section == 0 {
            if nowRegisterData.count < 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoActivityCrewCVCell.identifier, for: indexPath) as? NoActivityCrewCVCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCrewCVCell.identifier, for: indexPath) as? ActivityCrewCVCell else {
                    return UICollectionViewCell()
                }
                // 값이 있을 때 추가해주기
                return cell
            }
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                return UICollectionViewCell()
            }
            cell.pinImageView.image = UIImage(named: "leader")
            return cell
        }
        return UICollectionViewCell()
    }
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
        return UICollectionReusableView()
    }
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
        if indexPath.section == 0 {
            // cell 누르면 해당 디테일 페이지로 이동
            let storyboard = UIStoryboard.init(name: "MyActivityDetail", bundle: nil)
            guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityDetailVC") as? MyActivityDetailVC else {return}
            dvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            // cell 누르면 해당 디테일 페이지로 이동
            let storyboard = UIStoryboard.init(name: "BungaeDetail", bundle: nil)
            guard let dvc = storyboard.instantiateViewController(identifier: "BungaeDetailVC") as? BungaeDetailVC else {return}
            dvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
//        let height =  collectionView.frame.height
//        return CGSize(width: width, height: height)
        
        if indexPath.section == 0 {
            return CGSize(width: width-40, height: 170)
        }
        else {
            return CGSize(width: width-40, height: 144)
        }
    }
    
    // 위 아래 간격
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 16
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

// MARK: - 현재 가입한 크루 조회 API
extension MyActivityVC {
    func didSuccessNowRegister(result: [NowRegisterCrewResult]) {
        print("현재 가입한 크루 정보를 성공적으로 조회하였습니다.")
        nowRegisterData = result
    }
    
    func failedToRequest(message: String) {
        print("현재 가입한 크루 정보 데이터가 들어오지 않습니다.")
    }
}
