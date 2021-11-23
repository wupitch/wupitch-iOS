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
        self.crewSearchCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
    }

}

extension CrewSearchCVCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tabBar == tabEnum.crew {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("크루 눌렸음")
        }
        
        else if tabBar == tabEnum.bungae {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("번개 눌렸을")
        }
        
        return UICollectionViewCell()
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tabBar == tabEnum.crew {
            return CGSize(width: self.frame.width-40, height: 133)
        }
        else {
            return CGSize(width: self.frame.width-40, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
    }
    
}
