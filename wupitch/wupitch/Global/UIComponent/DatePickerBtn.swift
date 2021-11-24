//
//  datePickerBtn.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import Foundation
import UIKit

class DatePickerBtn : UIButton {
    
    var datePickerDelegate : DatePickerDelegate?
    var status : Bool = false {
        didSet {
            status ? colorDatePickerBtn() : grayDatePickerBtn()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultDatePickerBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultDatePickerBtn()
    }
    
    init() {
        super.init(frame: .zero)
        defaultDatePickerBtn()
    }
}

extension DatePickerBtn {
    private func defaultDatePickerBtn() {
        self.setTitleColor(UIColor.gray02, for: .normal)
        self.setTitle("00:00", for: .normal)
        self.makeRounded(cornerRadius: 8.adjusted)
        self.layer.borderWidth = 1.adjusted
        self.layer.borderColor = UIColor.gray02.cgColor
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }
    
    @objc func touchUp() {
        datePickerDelegate?.clickDatePicker(btn: self)
        
    }
    
    private func colorDatePickerBtn() {
        self.setTitleColor(UIColor.main, for: .normal)
        self.layer.borderColor = UIColor.main.cgColor
    }
    
    private func grayDatePickerBtn() {
        self.setTitleColor(UIColor.gray02, for: .normal)
        self.setTitle("00:00", for: .normal)
        self.layer.borderColor = UIColor.gray02.cgColor
    }
    
    func doubleDatePicker(secondDate: String?, location: Bool) -> Bool {
        guard let firstDate = self.titleLabel?.text else { return false }
        guard let secondDate = secondDate else { return false }

        let firstDateArray = firstDate.split(separator: ":")
        let secondDateArray = secondDate.split(separator: ":")
        
        let doubleFirstDate = Double(firstDateArray.first!)! + (Double(firstDateArray.last!)! * 0.01)
        let doubleSecondDate = Double(secondDateArray.first!)! + (Double(secondDateArray.last!)! * 0.01)
        
        print("first double형",doubleFirstDate)
        print("second double형",doubleSecondDate)
        
//        if location == true {
//
//        }
        
        if location ? doubleFirstDate > doubleSecondDate : doubleFirstDate < doubleSecondDate {
            return false
        }
        return true
    }
}

protocol DatePickerDelegate {
    func clickDatePicker(btn:DatePickerBtn)
}
