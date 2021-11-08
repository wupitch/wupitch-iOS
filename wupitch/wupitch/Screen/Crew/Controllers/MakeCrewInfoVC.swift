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


}
