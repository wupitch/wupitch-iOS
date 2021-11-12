//
//  MakceCrewGuestVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

protocol CrewDelegate {
    func makeCrewToPopPresentPage()
}

class MakeCrewGuestVC: UIViewController {
    
    @IBOutlet weak var guestSubTitleLabel: UILabel!
    @IBOutlet weak var guestTitleLabel: UILabel!
    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var noMoneyLabelBtn: CheckBtn!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: LabelFontSize!
    var crewDelegate : CrewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    private func setStyle() {
        titleLabel.makeCrewTitleLabel()
        titleTextField.delegate = self
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
        
        noMoneyLabelBtn.setTitleColor(.gray02, for: .normal)
        noMoneyLabelBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        noMoneyLabelBtn.titleLabel?.setTextWithLineHeight(text: noMoneyLabelBtn.titleLabel?.text, lineHeight: 19.adjusted)
        
        noMoneyLabelBtn.grayCheck()
        
        guestView.makeRounded(cornerRadius: 16.adjusted)
        guestTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        guestTitleLabel.textColor = .main
        guestSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        guestSubTitleLabel.textColor = .main
        
    }
    
    @IBAction func touchUpGuestBtn(_ sender: Any) {
        if noMoneyLabelBtn.status == false {
            noMoneyLabelBtn.colorCheck()
            titleTextField.isEnabled = false
            titleTextField.text = nil
            nextBtn.backgroundColor = .main
        }
        else {
            noMoneyLabelBtn.grayCheck()
            titleTextField.isEnabled = true
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            guard let viewControllerStack = self.navigationController?.viewControllers else { return }
            // 뷰 스택에서 crewVC를 찾아서 거기까지 pop 합니다. 후에 crewDetailVC를 찾아서 push 합니다.
            for viewController in viewControllerStack {
                if let crewVC = viewController as? CrewVC {
                    tabBarController?.tabBar.isHidden = false
                    self.navigationController?.popToViewController(crewVC, animated: true)
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "CrewDetail", bundle: nil)
                    if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewDetailVC") as? CrewDetailVC {
                        navigationController?.pushViewController(dvc, animated: true)
                    }
                }
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewGuestVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
}
