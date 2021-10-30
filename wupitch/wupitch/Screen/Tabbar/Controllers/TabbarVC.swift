//
//  TabbarVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbar()
    }
   
    private func setTabbar() {
        let firstTab = UIStoryboard.init(name: "Crew", bundle: nil)
        guard let firstTabVC = firstTab.instantiateViewController(identifier: "CrewVC") as? CrewVC  else { return }
        let firstTabNC = UINavigationController(rootViewController: firstTabVC)
        firstTabNC.tabBarItem.image = UIImage(systemName: "circle.fill")
        
        let secondTab = UIStoryboard.init(name: "Impromptu", bundle: nil)
        guard let secondTabVC = secondTab.instantiateViewController(identifier: "ImpromptuVC") as? ImpromptuVC  else { return }
        let secondTabNC = UINavigationController(rootViewController: secondTabVC)
        secondTabVC.tabBarItem.image = UIImage(systemName: "circle.fill")
        
        let thirdTab = UIStoryboard.init(name: "MyActivity", bundle: nil)
        guard let thirdTabVC = thirdTab.instantiateViewController(identifier: "MyActivityVC") as? MyActivityVC  else { return }
        let thirdTabNC = UINavigationController(rootViewController: thirdTabVC)
        thirdTabNC.tabBarItem.image = UIImage(systemName: "circle.fill")
        
        let fourthTab = UIStoryboard.init(name: "Feed", bundle: nil)
        guard let fourthTabVC = fourthTab.instantiateViewController(identifier: "FeedVC") as? FeedVC  else { return }
        let fourthTabNC = UINavigationController(rootViewController: fourthTabVC)
        fourthTabNC.tabBarItem.image = UIImage(systemName: "circle.fill")
        
        let fifthTab = UIStoryboard.init(name: "Profile", bundle: nil)
        guard let fifthTabVC = fifthTab.instantiateViewController(identifier: "ProfileVC") as? ProfileVC  else { return }
        let fifthTabNC = UINavigationController(rootViewController: fifthTabVC)
        fifthTabNC.tabBarItem.image = UIImage(systemName: "circle.fill")
        
        let tabs = [firstTabNC, secondTabNC, thirdTabNC, fourthTabNC, fifthTabNC]
        self.setViewControllers(tabs, animated: true)
    }
}
