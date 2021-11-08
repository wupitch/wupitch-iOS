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


}
