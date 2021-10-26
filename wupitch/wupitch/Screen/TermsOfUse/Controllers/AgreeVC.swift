//
//  AgreeVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/23.
//

import UIKit

class AgreeVC: UIViewController {
    
    @IBOutlet weak var contentCV: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setStyle()
    }
    
    func setDelegate() {
        contentCV.delegate = self
        contentCV.dataSource = self
        contentCV.register(AgreeCVCell.nib(), forCellWithReuseIdentifier: AgreeCVCell.identifier)
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 20.adjusted)
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AgreeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgreeCVCell.identifier, for: indexPath) as? AgreeCVCell else{
            return UICollectionViewCell()
        }
        return cell
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height =  collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
