//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewFilterVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtns: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet weak var timeLabel: LabelFontSize!
    @IBOutlet weak var startTimeTextField: tapTextField!
    @IBOutlet weak var betweenLabel: UILabel!
    @IBOutlet weak var endTImeTextField: tapTextField!
    
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet var crewCountBtns: [SportsBtn]!
    
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()

    }
    
    private func setStyle() {
        // textfield placeholder default color
        startTimeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        endTImeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        betweenLabel.textColor = .gray02
        
        // applyBtn default
        applyBtn.colorNextBtnStyle()
        
        // resetBtn
        resetBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        resetBtn.tintColor = .gray02
        
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpResetBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpApplyBtn(_ sender: Any) {
        
    }
}
