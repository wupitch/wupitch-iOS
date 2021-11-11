//
//  AreaPickerVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/11.
//

import UIKit

protocol DongDelegate {
    func dismissModal()
    func dataTextField(data: String)
    func btnToNextBtn()
}

class DongPickerVC: UIViewController {
    
    var dongDelegate : DongDelegate?
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var dongPickerView: UIPickerView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var dongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setDelegate()
    }
    
    func setStyle() {
        // titleLabel Style
        dongLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        dongLabel.tintColor = .bk
        
        // select Btn Style
        selectBtn.backgroundColor = .bk
        selectBtn.layer.cornerRadius = 8
        selectBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        // pickerView Style
        backgroundView.makeRounded(cornerRadius: 16.adjusted)
    }
    
    // set Delegate & dataSource
    func setDelegate() {
        dongPickerView.delegate = self
        dongPickerView.dataSource = self
    }
    
    @IBAction func touchUpSelectBtn(_ sender: UIButton) {
        // 선택 버튼 누를 시, delegate
        dongDelegate?.dismissModal()
        dongDelegate?.btnToNextBtn()
        
        // 선택 버튼 누를 시, textField의 데이터가 변경되도록
        let i = self.dongPickerView.selectedRow(inComponent: 0)
        
        dongDelegate?.dataTextField(data: locationPickerData[i].locationName)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // '최소' 버튼
    @IBAction func cancelBtn(_ sender: Any) {
        // 취소 버튼 선택 시, 모달 효과 dismiss
        dongDelegate?.dismissModal()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension
extension DongPickerVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // modalDelegate?.textFieldData(data: locationPickerData[row].locationName)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    // 피커뷰 색 없애고 다시 그리기
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        pickerView.subviews.forEach {
            $0.backgroundColor = .none
        }
        
        let numberLabel = UILabel()
        numberLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22.adjusted)
        numberLabel.tintColor = .bk
        numberLabel.text = locationPickerData[row].locationName
        numberLabel.textAlignment = .center
        
        return numberLabel
    }
}




