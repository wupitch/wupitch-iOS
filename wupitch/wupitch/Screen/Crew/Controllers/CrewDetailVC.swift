//
//  CrewDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/01.
//

import UIKit
import Alamofire

class CrewDetailVC: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var detailCV: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setCVDelegate()
    }
    
    private func setStyle() {
        titleLabel.text = "크루"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        lineView.backgroundColor = .gray04
        lineView.alpha = 0.0
        bottomLineView.backgroundColor = .gray04
        guestBtn.setTitle("손님으로 참여", for: .normal)
        guestBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        guestBtn.tintColor = .main
        guestBtn.layer.borderWidth = 1.adjusted
        guestBtn.layer.borderColor = UIColor.main.cgColor
        
        registerBtn.setTitle("가입하기", for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        registerBtn.tintColor = .wht
        registerBtn.backgroundColor = .main
        
        registerBtn.makeRounded(cornerRadius: 8.adjusted)
        guestBtn.makeRounded(cornerRadius: 8.adjusted)
    }
    
    private func setCVDelegate() {
        detailCV.delegate = self
        detailCV.dataSource = self
        detailCV.register(DetailCrewImgCVCell.nib(), forCellWithReuseIdentifier: DetailCrewImgCVCell.identifier)
        
        detailCV.register(DetailCrewHeaderCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailCrewHeaderCRV")
        
        detailCV.register(DetailCrewFooterCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "DetailCrewFooterCRV")
        
        detailCV.register(DetailCrewTitleCVCell.nib(), forCellWithReuseIdentifier: DetailCrewTitleCVCell.identifier)
        detailCV.register(DetailCrewIntroduceCVCell.nib(), forCellWithReuseIdentifier: DetailCrewIntroduceCVCell.identifier)
        detailCV.register(DtailCrewContentCVCell.nib(), forCellWithReuseIdentifier: DtailCrewContentCVCell.identifier)
    }
}

extension CrewDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewImgCVCell.identifier, for: indexPath) as? DetailCrewImgCVCell else{
                return UICollectionViewCell()
            }
            //cell.mainImgView.image = UIImage(named: "test")
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewTitleCVCell.identifier, for: indexPath) as? DetailCrewTitleCVCell else{
                return UICollectionViewCell()
            }
            cell.titleLabel.text = "가나다라마바사아자차카타파하"
            cell.regionLabel.text = "법정동"
            cell.circleView.backgroundColor = .red
            cell.tagView.backgroundColor = .red
            cell.tagLabel.text = "농구"
            cell.tagLabel.textColor = .wht
            cell.topDateLabel.text = "수요일 20:00 - 22:00"
            cell.bottomDateLabel.text = "일요일 11:30 - 13:30"
            cell.locationLabel.text = "가나다라마바사아자차카타파하"
            cell.moneyLabel.text = "정기회비 15,000원"
            
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCrewIntroduceCVCell.identifier, for: indexPath) as? DetailCrewIntroduceCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
        else if indexPath.section == 4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DtailCrewContentCVCell.identifier, for: indexPath) as? DtailCrewContentCVCell else{
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "DetailCrewHeaderCRV",for: indexPath) as! DetailCrewHeaderCRV
            
            switch indexPath.section {
            case 2:
                headerView.frame.size.height = 8.0
            case 3:
                headerView.frame.size.height = 8.0
            case 5:
                headerView.frame.size.height = 8.0
            default:
                headerView.frame.size.height = 0.0
            }
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "DetailCrewFooterCRV",for: indexPath) as! DetailCrewFooterCRV

            switch indexPath.section {
            case 3:
                footerView.frame.size.height = 171.0
            default:
                footerView.frame.size.height = 0.0
            }
            return footerView
            
        default:
            assert(false, "응 아니야")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        switch section {
        case 2:
          return CGSize(width: collectionView.bounds.width, height: 8)
        case 3:
          return CGSize(width: collectionView.bounds.width, height: 8)
        case 5:
          return CGSize(width: collectionView.bounds.width, height: 8)
        default:
          return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        switch section {
        case 3:
          return CGSize(width: collectionView.bounds.width, height: 171)
        default:
          return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        //let height =  collectionView.frame.height
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 211)
        }
        else if indexPath.section == 1 {
            return CGSize(width: width, height: 228)
        }
        else if indexPath.section == 2 {
            return CGSize(width: width, height: 724)
        }
        else if indexPath.section == 3 {
            return CGSize(width: width, height: 200)
        }
        else if indexPath.section == 4 {
            return CGSize(width: width, height: 200)
        }
        else {
            return CGSize(width: width, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
