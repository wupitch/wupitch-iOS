//
//  MyActivityDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

enum myActivityTab {
    case introduce, board, photo, crewone
}

class MyActivityDetailVC: UIViewController {

    @IBOutlet weak var plusVIew: UIView!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var fourthLineView: UIView!
    @IBOutlet weak var thirdLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var MyActivityCV: UICollectionView!
    
    var myActivityTabPage = [myActivityTab.introduce, myActivityTab.board,myActivityTab.photo,myActivityTab.crewone]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        MyActivityCV.delegate = self
        MyActivityCV.dataSource = self
        self.MyActivityCV.register(ActivityTabCVCell.nib(), forCellWithReuseIdentifier: ActivityTabCVCell.identifier)
        
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondLineView.backgroundColor = .clear
        thirdLineView.backgroundColor = .clear
        fourthLineView.backgroundColor = .clear
        plusVIew.makeRounded(cornerRadius: nil)
        plusVIew.isHidden = true
        tapGesture()
    }
    
    // MARK: FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.plusVIew.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "AddBoard", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "AddBoardVC") as? AddBoardVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        MyActivityCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        thirdBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        fourthBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        plusVIew.isHidden = true
        // 탭바 보이게
        firstLineView.backgroundColor = .bk
        // 번개탭바 안보이게
        secondLineView.backgroundColor = .clear
        thirdLineView.backgroundColor = .clear
        fourthLineView.backgroundColor = .clear
        
    }
    
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        MyActivityCV.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        thirdBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        fourthBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        // 플러스 버튼 보이게
        plusVIew.isHidden = false
        
        // 탭바 보이게
        secondLineView.backgroundColor = .bk
        // 번개탭바 안보이게
        firstLineView.backgroundColor = .clear
        thirdLineView.backgroundColor = .clear
        fourthLineView.backgroundColor = .clear
    }
    
    @IBAction func touchUpThirdBtn(_ sender: Any) {
        MyActivityCV.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        thirdBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        fourthBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        plusVIew.isHidden = false
        // 번개탭바 안보이게
        secondLineView.backgroundColor = .clear
        firstLineView.backgroundColor = .clear
        fourthLineView.backgroundColor = .clear
        // 탭바 보이게
        thirdLineView.backgroundColor = .bk
    }
    
    @IBAction func touchUpFourthBtn(_ sender: Any) {
        plusVIew.isHidden = true
        MyActivityCV.scrollToItem(at: IndexPath(row: 3, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        thirdBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        fourthBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        // 번개탭바 안보이게
        secondLineView.backgroundColor = .clear
        thirdLineView.backgroundColor = .clear
        firstLineView.backgroundColor = .clear
        // 탭바 보이게
        fourthLineView.backgroundColor = .bk
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MyActivityAlert", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityAlertVC") as? MyActivityAlertVC else {return}
        dvc.modalPresentationStyle = .overFullScreen
        dvc.modalTransitionStyle = .crossDissolve
        present(dvc, animated: true, completion: nil)
    }
}
extension MyActivityDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myActivityTabPage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityTabCVCell.identifier, for: indexPath) as? ActivityTabCVCell else{
            return UICollectionViewCell()
        }
        cell.tabBar = myActivityTabPage[indexPath.row]
        return cell
    }
    //MARK: - Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: MyActivityCV.frame.width, height: MyActivityCV.frame.height)
        
    }
    
    //MARK: - Cell간의 좌우간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    //MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

