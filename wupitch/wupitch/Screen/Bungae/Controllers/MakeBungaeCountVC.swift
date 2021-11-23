//
//  MakeBungaeCountVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaeCountVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // textField Style
        //countTextField.attributedPlaceholder = NSAttributedString(string: "00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        
        
        
        countTextField.backgroundColor = .gray05
        countTextField.borderStyle = .none
        countTextField.makeRounded(cornerRadius: 8.adjusted)
        countTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        countTextField.textColor = .gray03
        countTextField.addLeftPadding()
        
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
    }
}
