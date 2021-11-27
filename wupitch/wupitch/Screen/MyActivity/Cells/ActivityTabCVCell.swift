//
//  ActivityTabCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ActivityTabCVCell: UICollectionViewCell {

    static let identifier = "ActivityTabCVCell"
    
    @IBOutlet weak var tabCV: UICollectionView!
    var tabBar : myActivityTab?
    
    static func nib() -> UINib {
        return UINib(nibName: "ActivityTabCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabCV.delegate = self
        tabCV.dataSource = self
        self.tabCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
        self.tabCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        self.tabCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
    }

}

extension ActivityTabCVCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabBar == myActivityTab.introduce {
            return 10
        }
        else if tabBar == myActivityTab.board {
            return 1
        }
        
        else if tabBar == myActivityTab.photo {
            return 1
        }
        
        else if tabBar == myActivityTab.crewone {
           return 1
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tabBar == myActivityTab.introduce {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("소개 눌렸음")
        }
        
        else if tabBar == myActivityTab.board {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("게시판 눌렸을")
        }
        
        else if tabBar == myActivityTab.photo {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("사진첩 눌렸을")
        }
        
        else if tabBar == myActivityTab.crewone {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            return cell
            print("크루원 눌렸을")
        }
        return UICollectionViewCell()
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tabBar == myActivityTab.introduce {
            return CGSize(width: self.frame.width-40, height: 133)
        }
        else if tabBar == myActivityTab.board {
            return CGSize(width: self.frame.width, height: self.frame.height)
        }
        
        else if tabBar == myActivityTab.photo {
            return CGSize(width: self.frame.width, height: self.frame.height)
        }
        
        else if tabBar == myActivityTab.crewone {
            return CGSize(width: self.frame.width, height: self.frame.height)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
    }
    
}

