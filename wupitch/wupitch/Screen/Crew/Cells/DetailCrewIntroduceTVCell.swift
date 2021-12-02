//
//  DetailCrewIntroduceCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/02.
//

import UIKit

class DetailCrewIntroduceTVCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tagSelectCV: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    static let identifier = "DetailCrewIntroduceTVCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewIntroduceTVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagSelectCV.delegate = self
        tagSelectCV.dataSource = self
        tagSelectCV.register(TagCVCell.nib(), forCellWithReuseIdentifier: TagCVCell.identifier)
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        peopleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        peopleLabel.textColor = .bk
        
        ageLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        ageLabel.textColor = .bk
        
        contentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        contentLabel.textColor = .bk
        
    }
}

extension DetailCrewIntroduceTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCVCell.identifier, for: indexPath) as? TagCVCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = "코치님과 훈련"
        return cell
    }
    
    //MARK: - Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - Cell간의 좌우간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
}
