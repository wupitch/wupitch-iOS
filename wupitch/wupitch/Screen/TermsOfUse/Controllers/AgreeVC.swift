//
//  AgreeVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/23.
//

import UIKit

class AgreeVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setStyle()
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 20.adjusted)
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
