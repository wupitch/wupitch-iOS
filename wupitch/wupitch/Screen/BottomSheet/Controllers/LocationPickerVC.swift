//
//  LocationPickerVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/19.
//

// 해야할 것
// 1. uipicker의 특정 글자만 굵게 안된다.

import UIKit

// MARK: - ModalDelegate
protocol ModalDelegate {
    func modalDismiss()
    func textFieldData(data: String)
    func selectBtnToNextBtn()
}

class LocationPickerVC: UIViewController {
    
    // MARK: - Variable
    var modalDelegate : ModalDelegate?
    
    // MARK: - IBOulets
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerBgView: UIView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    
    // MARK: - Function
    // set Style
    func setStyle() {
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        titleLabel.tintColor = .bk
        
        // select Btn Style
        selectBtn.layer.cornerRadius = 8
        selectBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        // pickerView Style
        pickerBgView.makeRounded(cornerRadius: 16)
    }
    
    // set Delegate & dataSource
    func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // MARK: - IBActions
    // '선택' 버튼
    @IBAction func touchUpSelectBtn(_ sender: UIButton) {
        // 선택 버튼 누를 시, delegate
        modalDelegate?.modalDismiss()
        modalDelegate?.selectBtnToNextBtn()
        
        // 선택 버튼 누를 시, textField의 데이터가 변경되도록
        let i = self.pickerView.selectedRow(inComponent: 0)
        modalDelegate?.textFieldData(data: SignUpUserInfo.shared.areaName?[i] ?? "값없음")
        self.dismiss(animated: true, completion: nil)
    }
    
    // '최소' 버튼
    @IBAction func cancelBtn(_ sender: Any) {
        // 취소 버튼 선택 시, 모달 효과 dismiss
        modalDelegate?.modalDismiss()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension
extension LocationPickerVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SignUpUserInfo.shared.areaName?.count ?? 0
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
        numberLabel.text = SignUpUserInfo.shared.areaName?[row]
        numberLabel.textAlignment = .center

        return numberLabel
    }
}






