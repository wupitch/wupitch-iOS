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
        setTabbarColor()
    }
   
    private func setTabbar() {
        let firstTab = UIStoryboard.init(name: "Crew", bundle: nil)
        guard let firstTabVC = firstTab.instantiateViewController(identifier: "CrewVC") as? CrewVC  else { return }
        let firstTabNC = UINavigationController(rootViewController: firstTabVC)
        firstTabNC.tabBarItem.image = UIImage(named: "home")
        firstTabNC.tabBarItem.title = "크루"
        
        let secondTab = UIStoryboard.init(name: "Bungae", bundle: nil)
        guard let secondTabVC = secondTab.instantiateViewController(identifier: "BungaeVC") as? BungaeVC  else { return }
        let secondTabNC = UINavigationController(rootViewController: secondTabVC)
        secondTabNC.tabBarItem.image = UIImage(named: "bungae")
        secondTabNC.tabBarItem.title = "번개"
        
        let thirdTab = UIStoryboard.init(name: "MyActivity", bundle: nil)
        guard let thirdTabVC = thirdTab.instantiateViewController(identifier: "MyActivityVC") as? MyActivityVC  else { return }
        let thirdTabNC = UINavigationController(rootViewController: thirdTabVC)
        thirdTabNC.tabBarItem.image = UIImage(named: "activity")
        thirdTabNC.tabBarItem.title = "내 활동"
        
        let fourthTab = UIStoryboard.init(name: "Feed", bundle: nil)
        guard let fourthTabVC = fourthTab.instantiateViewController(identifier: "FeedVC") as? FeedVC  else { return }
        let fourthTabNC = UINavigationController(rootViewController: fourthTabVC)
        fourthTabNC.tabBarItem.image = UIImage(named: "feed")
        fourthTabNC.tabBarItem.title = "피드"
        
        let fifthTab = UIStoryboard.init(name: "Profile", bundle: nil)
        guard let fifthTabVC = fifthTab.instantiateViewController(identifier: "ProfileVC") as? ProfileVC  else { return }
        let fifthTabNC = UINavigationController(rootViewController: fifthTabVC)
        fifthTabNC.tabBarItem.image = UIImage(named: "profile")
        fifthTabNC.tabBarItem.title = "마이페이지"
        
        let tabs = [firstTabNC, secondTabNC, thirdTabNC, fourthTabNC, fifthTabNC]
        self.setViewControllers(tabs, animated: true)
    }
    
    private func setTabbarColor() {
        self.tabBar.unselectedItemTintColor = .gray03
        self.tabBar.tintColor = .bk
    }
}
