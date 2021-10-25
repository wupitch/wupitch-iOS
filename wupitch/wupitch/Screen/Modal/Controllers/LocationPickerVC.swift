//
//  LocationPickerVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/19.
//

import UIKit
import Alamofire

protocol ModalDelegate {
    func modalDismiss()
    func textFieldData(data: String)
    func selectBtnToNextBtn()
}

class LocationPickerVC: UIViewController {
    
    var modalDelegate : ModalDelegate?
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setDelegate()
        
    }
    
    func setStyle() {
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        titleLabel.tintColor = .bk
        selectBtn.layer.cornerRadius = 8
        pickerBgView.makeRounded(cornerRadius: 20)
    }
    
    func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func touchUpSelectBtn(_ sender: Any) {
        modalDelegate?.modalDismiss()
        modalDelegate?.selectBtnToNextBtn()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        modalDelegate?.modalDismiss()
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
        modalDelegate?.textFieldData(data: locationPickerData[row].locationName)
    }
    
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        var color: UIColor!
//        if pickerView.selectedRow(inComponent: component) == row {
//            color = UIColor.blue
//        } else {
//            color = UIColor.black
//        }
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color as Any,
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 15)
//        ]
//
//        return NSAttributedString(string: locationPickerData[row].locationName, attributes: attributes)
//    }
//
    

    // 특정 선택된 글자만 굵게가 안돼
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }

        let numberLabel = UILabel()
        numberLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22.adjusted)
        numberLabel.tintColor = .bk
        numberLabel.text = locationPickerData[row].locationName
        numberLabel.textAlignment = .center

        return numberLabel
    }
}






