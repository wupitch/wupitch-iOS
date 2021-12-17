//
//  MakeBungaeCountVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaeCountVC: UIViewController {

    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countTextField.backgroundColor = .gray05
        countTextField.borderStyle = .none
        countTextField.makeRounded(cornerRadius: 8.adjusted)
        countTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        countTextField.textColor = .gray03
        countTextField.addLeftPadding()
        countTextField.delegate = self
        titleLabel.makeCrewTitleLabel()
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        countTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            countTextField.resignFirstResponder()
        }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            dvc.titleLabel = "작성한 모든 기입정보가 삭제됩니다. \n 번개만들기를 그만두시겠습니까?"
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            SignUpUserInfo.shared.bungaeCount = Int(countTextField.text ?? "") ?? 0
            print("모집인원 >>>>>>>>>>>>>>>", SignUpUserInfo.shared.bungaeCount)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaeMoney", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaeMoneyVC") as? MakeBungaeMoneyVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeBungaeCountVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        countTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if countTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 2자리로 막아놓기
        if countTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 2
        }
        return true
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeBungaeCountVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let bungaeVC = viewController as? BungaeVC { self.navigationController?.popToViewController(bungaeVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                // SignUpUserInfo.shared.dispose()
            }
        }
    }
}
