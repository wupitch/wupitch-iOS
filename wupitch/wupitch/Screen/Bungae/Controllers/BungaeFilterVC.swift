//
//  BungaeFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/20.
//

import UIKit

class BungaeFilterVC: UIViewController {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtn: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet var countLabel: LabelFontSize!
    @IBOutlet var countBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    
    }
    
    private func setStyle() {
        // applyBtn default
        applyBtn.colorNextBtnStyle()
        
        // resetBtn
        resetBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        resetBtn.tintColor = .gray02
    }

}
