//
//  LocationPickerVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/19.
//

import UIKit

// 1. 프로토콜을 만든다.
protocol SignUpPickerDelegate: AnyObject {
    
    // 2. 메소드를 만든다.
    func modalViewDismiss()
    func textFieldData()
}

class LocationPickerVC: UIViewController {
    
    // 3. 델리게이트
    weak var signUpDelegate: SignUpPickerDelegate?
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerBgView: UIView!
    
    //let loc = ["1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //signUpDelegate?.modalViewDismiss()
        
    }
    
    // 뷰가 나타날 것이다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG VC3 >> \(#function) ")
        
        //signUpDelegate?.modalViewDismiss()
    }
    
    // 뷰가 나타났다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DEBUG VC3 >> \(#function) ")
        
        //signUpDelegate?.modalViewDismiss()
    }
    
    // 뷰가 사라질 것이다.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG VC3 >> \(#function) ")
        
        
    }
    
    // 뷰가 사라졌다.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("DEBUG VC3 >> \(#function) ")
        //signUpDelegate?.modalViewDismiss()
    }
    
    
    @IBAction func touchUpSelectBtn(_ sender: Any) {
        
        self.signUpDelegate?.modalViewDismiss()
        self.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LocationPickerVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationPickerData[row].locationName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        signUpDelegate?.textFieldData()
        
    }
    
    
    
        func createPickerView() {
            pickerView = UIPickerView()
            pickerView.delegate = self
            //dogBreedTextField.inputView = pickerView
            signUpDelegate?.textFieldData()
        }
    //
    //    func dismissPickerView() {
    //        let toolBar = UIToolbar()
    //        toolBar.sizeToFit()
    //        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
    //        toolBar.setItems([button], animated: true)
    //        toolBar.isUserInteractionEnabled = true
    //        dogBreedTextField.inputAccessoryView = toolBar
    //    }
    //    @objc func action() {
    //        dogBreedTextField.resignFirstResponder()
    //    }
    
    
}
