//
//  MyActivityBungaeDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/08.
//

import UIKit

// 탭 바
enum myActivityBungaeTab {
    case bungaeIntroduce, bungaeMember
}
// 내 활동 번개 디테일 VC
class MyActivityBungaeDetailVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var secondLineView: UIView!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var MyActivityCV: UICollectionView!
    
    // MARK: - Variable
    // 탭 바 연결
    var myActivityTabPage = [myActivityBungaeTab.bungaeIntroduce, myActivityBungaeTab.bungaeMember]
    
    // MARK: - LifeCycle
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    
    // MARK: - Function
    // 스타일
    private func setStyle() {
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondLineView.backgroundColor = .clear
    }
    // CV Delegate & DataSource & Register
    private func setDelegate() {
        MyActivityCV.delegate = self
        MyActivityCV.dataSource = self
        MyActivityCV.register(BungaeActivityCVCell.nib(), forCellWithReuseIdentifier: BungaeActivityCVCell.identifier)
    }
    
    // MARK: - IBAction
    // 소개 버튼
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        MyActivityCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        // 탭바 보이게
        firstLineView.backgroundColor = .bk
        // 번개탭바 안보이게
        secondLineView.backgroundColor = .clear
    }
    // 번개멤버 버튼
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        MyActivityCV.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        // 탭바 보이게
        secondLineView.backgroundColor = .bk
        // 번개탭바 안보이게
        firstLineView.backgroundColor = .clear
    }
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // 알람 버튼
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MyActivityAlert", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityAlertVC") as? MyActivityAlertVC else {return}
        dvc.modalPresentationStyle = .overFullScreen
        dvc.modalTransitionStyle = .crossDissolve
        present(dvc, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Extension
extension MyActivityBungaeDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myActivityTabPage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeActivityCVCell.identifier, for: indexPath) as? BungaeActivityCVCell else{
            return UICollectionViewCell()
        }
        cell.tabBar = myActivityTabPage[indexPath.row]
        cell.delegate = self
        return cell
    }
    // Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: MyActivityCV.frame.width, height: MyActivityCV.frame.height)
    }
    // Cell간의 좌우간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    // 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Cell Extension
extension MyActivityBungaeDetailVC : YourCellDelegate {
    func didPressCell(sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "BungaeMemberDetail", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "BungaeMemberDetailVC") as? BungaeMemberDetailVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
