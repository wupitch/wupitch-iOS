//
//  CrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class CrewVC: UIViewController {

    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var crewCV: UICollectionView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var selectRegionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
    }
    
    private func setStyle() {
        selectRegionBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22.adjusted)
        floatingView.makeRounded(cornerRadius: nil)
    }
    
    private func setCVDelegate() {
        crewCV.delegate = self
        crewCV.dataSource = self
        crewCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
    }
}

extension CrewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 일단은 다섯개로
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
            return UICollectionViewCell()
        }
        
        cell.tagNameLabel.text = "배드민턴"
        cell.regionLabel.text = "법정동"
        cell.titleLabel.text = "가나다라마바이ㅏ러니아러니ㅏㅇ러사아자차카타파하"
        cell.dayLabel.text = "월요일 24:00 - 24:00"
        cell.subLabel.text = "가나다라마바사아자차카타파하"
        
        return cell
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        //let height =  collectionView.frame.height
        
        return CGSize(width: width-40, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
