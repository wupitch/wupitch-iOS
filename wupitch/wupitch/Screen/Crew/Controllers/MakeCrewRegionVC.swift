//
//  MakeCrewRegionVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewRegionVC: UIViewController {

    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var dongTextField: tapTextField!
    @IBOutlet weak var regionTextField: tapTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        
    }

    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
        // textField Style
        regionTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        dongTextField.attributedPlaceholder = NSAttributedString(string: "동 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        regionTextField.regionTextFieldStyle()
        dongTextField.regionTextFieldStyle()
    }
}
