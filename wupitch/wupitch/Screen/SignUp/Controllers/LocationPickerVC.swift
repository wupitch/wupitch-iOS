//
//  LocationPickerVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/19.
//

import UIKit

protocol sendUpdateDelegate {
    func sendUpdate(data:String)
}

class LocationPickerVC: UIViewController {
    
    
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerBgView: UIView!
    
    let loc = ["1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func touchUpSelectBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension LocationPickerVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loc.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return loc[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //dogBreedTextField.text = loc[row]
        
    }
    
    //    func createPickerView() {
    //        //let pickerView = UIPickerView()
    //        pickerView.delegate = self
    //        dogBreedTextField.inputView = pickerView
    //    }
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
