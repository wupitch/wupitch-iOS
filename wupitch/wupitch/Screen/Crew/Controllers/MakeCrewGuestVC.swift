//
//  MakceCrewGuestVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

protocol CrewDelegate {
    func makeCrewToPopPresentPage()
}

class MakeCrewGuestVC: UIViewController {

    var crewDelegate : CrewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func touchUpBackBtn(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func touchUpCancelBtn(_ sender: Any) {
            
        }
        
        @IBAction func touchUpNextBtn(_ sender: Any) {
            guard let viewControllerStack = self.navigationController?.viewControllers else { return }
            // 뷰 스택에서 crewVC를 찾아서 거기까지 pop 합니다. 후에 crewDetailVC를 찾아서 push 합니다.
            for viewController in viewControllerStack {
                if let crewVC = viewController as? CrewVC {
                    tabBarController?.tabBar.isHidden = false
                    self.navigationController?.popToViewController(crewVC, animated: true)
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "CrewDetail", bundle: nil)
                    if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewDetailVC") as? CrewDetailVC {
                        navigationController?.pushViewController(dvc, animated: true)
                    }
                }
            }
        }
}
