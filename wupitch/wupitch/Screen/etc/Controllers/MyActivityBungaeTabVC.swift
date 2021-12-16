//
//  MyActivityBungaeTabVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import UIKit
import XLPagerTabStrip

class MyActivityBungaeTabVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .bk
        settings.style.buttonBarItemFont = .init(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)!
        settings.style.selectedBarHeight = 0.5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .bk
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .bk
            oldCell?.label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            newCell?.label.textColor = .bk
            newCell?.label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        }
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "MyActivityBungaeIntroduction", bundle: nil).instantiateViewController(withIdentifier: "MyActivityBungaeIntroductionVC")
        let child_2 = UIStoryboard(name: "MyActivityBungaeMember", bundle: nil).instantiateViewController(withIdentifier: "MyActivityBungaeMemberVC")
        
        return [child_1, child_2]
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
