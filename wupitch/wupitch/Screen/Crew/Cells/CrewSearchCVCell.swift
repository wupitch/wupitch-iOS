//
//  CrewSearchCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

class CrewSearchCVCell: UICollectionViewCell {

    static let identifier = "CrewSearchCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewSearchCVCell", bundle: nil)
    }
    
    @IBOutlet weak var crewSearchCV: UICollectionView!
    var tabBar : tabEnum?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        self.crewSearchCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
    }

}

extension CrewSearchCVCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
            return UICollectionViewCell()
        }
        
        // 산책내역
        if tabBar == tabEnum.crew {
            print("크루 눌렸음")
        }
        // 식사내역
        else if tabBar == tabEnum.bungae {
            print("번개 눌렸을")
        }
        
        return cell
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width-40, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 21, left: 0, bottom: 16, right: 0)
    }
    
}
