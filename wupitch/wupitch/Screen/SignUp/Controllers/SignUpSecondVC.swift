//
//  SignUpSecondVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpSecondVC: UIViewController, SignUpPickerDelegate {
    
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalBgView.alpha = 0.0
        selectTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        
    }
    
    // 뷰가 나타날 것이다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("뷰윌어피어 >> \(#function) ")
        
        
    }
    
    // 뷰가 나타났다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DEBUG VC1 >> \(#function) ")
        
    }
    
    // 뷰가 사라질 것이다.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG VC1 >> \(#function) ")
        
        
    }
    
    // 뷰가 사라졌다.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("DEBUG VC1 >> \(#function) ")
        
    }
    
    func modalViewDismiss() {
        modalBgView.alpha = 0.0
        
    }
    
    func textFieldData() {
        selectTextField.text = locationPickerData[0].locationName
        selectTextField.text = locationPickerData[1].locationName
        selectTextField.text = locationPickerData[2].locationName
        selectTextField.text = locationPickerData[3].locationName
        
    }
    
        @objc func textFieldDidChange(_ textField:UITextField) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
                dvc.modalPresentationStyle = .overFullScreen
    
                modalBgView.alpha = 1
    
                self.present(dvc, animated: true, completion: nil)
            }
    
        }
    
    
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "SignUpThird", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpThirdVC") as? SignUpThirdVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}


