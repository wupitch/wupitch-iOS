//
//  MakeCrewInfoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewInfoVC: UIViewController {

    @IBOutlet weak var addSubTitleLabel: LabelFontSize!
    @IBOutlet weak var subTitleLabel: LabelFontSize!
    @IBOutlet weak var addInfoLabel: LabelFontSize!
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet weak var crewNameLabel: LabelFontSize!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var makeCrewLabel: LabelFontSize!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
        // subTitleStyle
        subTitleLabel.makeCrewSubTitleLabel()
        addSubTitleLabel.makeCrewSubTitleLabel()
    }

    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewDate", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewDateVC") as? MakeCrewDateVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
