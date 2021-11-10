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
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewInfo", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewInfoVC") as? MakeCrewInfoVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
}
