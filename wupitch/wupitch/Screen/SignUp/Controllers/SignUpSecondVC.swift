//
//  SignUpSecondVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpSecondVC: UIViewController {
    
    var delegate : sendUpdateDelegate?
    
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    let loc = ["1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalBgView.alpha = 0.0
        
        
        selectTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        
    }
    
   
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
            dvc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            self.present(dvc, animated: true, completion: nil)
        }
        
    }
    
    
    
}
