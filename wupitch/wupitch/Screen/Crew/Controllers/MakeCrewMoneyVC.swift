//
//  MakeCrewMoneyVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewMoneyVC: UIViewController {

    @IBOutlet weak var titleLabel: LabelFontSize!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }

    private func setStyle() {
        titleLabel.makeCrewTitleLabel()
    }

}
