//
//  OnboardingVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/14.
//

import UIKit

class OnboardingVC: UIViewController {

    // MARK: - IBOulets
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingCV: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setStyle()
       setDelegate()
    }
    
    // MARK: - Function
    private func setStyle() {
        // skipBtn font & color 설정
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        skipBtn.tintColor = UIColor.main
        
        // 페이지 컨트롤 색상 조정
        onboardingPageControl.pageIndicatorTintColor = .gray04
        onboardingPageControl.currentPageIndicatorTintColor = .main
        
        // 컬렉션 뷰 페이징 효과 부드럽게
        onboardingCV.isPagingEnabled = true
        
        // 백그라운드 컬러 설정
        // onboardingCV.backgroundColor = .gray05
        // view.backgroundColor = .gray05
    }

    // dataSource & Delegate & Register
    private func setDelegate() {
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        onboardingCV.register(OnboardingCVCell.nib(), forCellWithReuseIdentifier: OnboardingCVCell.identifier)
    }
    
    // 스크롤 페이지 설정
    private func definePage(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        self.onboardingPageControl.currentPage = page
    }
    
    // MARK: - IBActions
    // 건너뛰기 버튼
    @IBAction func touchUpSkipBtn(_ sender: Any) {
        // 건너뛰기 버튼 누르면 로그인 페이지로 이동
        let storyboard = UIStoryboard.init(name: "SignIn", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignInVC") as? SignInVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - DataSource & Delegate & FlowLayout
extension OnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.identifier, for: indexPath) as? OnboardingCVCell else{
            return UICollectionViewCell()
        }
        
        cell.setCell(title: onboardingData[indexPath.row].titleLabelName, description: onboardingData[indexPath.row].descriptionLabelName, imageName: onboardingData[indexPath.row].onboardingImageName)
        
        onboardingPageControl.numberOfPages = onboardingData.count
        
        return cell
    }
    
    // collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height =  collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // pageControl
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        definePage(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        definePage(scrollView)
    }
}
