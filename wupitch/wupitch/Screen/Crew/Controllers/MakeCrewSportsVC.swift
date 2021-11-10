//
//  CrewMakeCrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewSportsVC: UIViewController {
    
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet var sportsBtns: [SportsBtn]!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var makeCrewLabel: LabelFontSize!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewRegion", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewRegionVC") as? MakeCrewRegionVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
