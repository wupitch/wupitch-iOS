//
//  FeedVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class FeedVC: BaseVC {

    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var feedCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setCVDelegate()
    }
    
    private func setStyle() {
        titleLabel.titleLabelFontSize()
    }
    
    private func setCVDelegate() {
        feedCV.delegate = self
        feedCV.dataSource = self
        feedCV.register(FeedCVCell.nib(), forCellWithReuseIdentifier: FeedCVCell.identifier)
    }
}

extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 일단은 다섯개로
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCVCell.identifier, for: indexPath) as? FeedCVCell else{
            return UICollectionViewCell()
        }

        return cell
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
        
        let width = collectionView.frame.width / 3
        //let height =  collectionView.frame.height
        
        return CGSize(width: width-8, height: width)
    }
    
    // 위 아래 간격
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 6
      }

      // 옆 간격
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 6
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}
