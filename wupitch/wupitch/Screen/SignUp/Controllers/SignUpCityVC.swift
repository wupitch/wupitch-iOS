//
//  SignUpSecondVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpCityVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    // MARK: - Propertise
    // 카카오 &. 애플 로그인 시 버튼 라벨을 바꿔줘야 해서 변수 선언
    var nextBtnLabel : String?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setBtnNameToDVC()
        textFieldToAddTarget()
    }
    
    // MARK: - Function
    // Style
    func setStyle() {
        // 모달뷰 처음에는 안보이게
        modalBgView.alpha = 0.0
        
        // textField Style
        selectTextField.tintColor = .clear
        selectTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        selectTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        selectTextField.layer.borderColor = UIColor.gray02.cgColor
        selectTextField.layer.borderWidth = 1
        selectTextField.layer.cornerRadius = 8
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        // 다음 버튼 Style
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
    }
    
    // 카카오 & 애플 로그인 시 버튼 라벨을 바꿔줘야 하기 때문에!
    func setBtnNameToDVC() {
        nextBtn.titleLabel?.text = nextBtnLabel
    }
    
    // 텍스트 필드 눌렀을 때 addTarget주기
    func textFieldToAddTarget() {
        selectTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
    }
    
    // textFieldToAddTarget()의 addTarget
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        // 텍스트필드 눌렀을 때 모달 화면 띄워주기
        let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
            dvc.modalPresentationStyle = .overFullScreen
            
            // 모달 백그라운드 색 보이게
            modalBgView.alpha = 1
            
            // 모달 딜리게이트 할당
            dvc.modalDelegate = self
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    // MARK: - IBActions
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 취소 버튼
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
        if nextBtn.backgroundColor == .main {
            // 다음 버튼 클릭 시, 다음 스토리보드로 이동
            let storyboard = UIStoryboard.init(name: "SignUpSports", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpSportsVC") as? SignUpSportsVC else {return}
            
            // 여기서 카카오 & 애플 로그인인지 확인하고 라벨 값 다르게 넘겨줘야함
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

// MARK: - Extension (Modal Delegate)
extension SignUpCityVC: ModalDelegate {
    
    // 모달에서 확인 버튼 눌렀을 때 다음 버튼에 생기는 색 변화
    func selectBtnToNextBtn() {
        // 선택되면 textField 색상 변경
        selectTextField.textColor = .main
        selectTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.main])
        selectTextField.layer.borderColor = UIColor.main.cgColor
        // 선택버튼도 변경
        nextBtn.backgroundColor = .main
    }
    
    // 모달이 dismiss되면서 모달백그라운드 색도 없어짐
    func modalDismiss() {
        modalBgView.alpha = 0.0
    }
    
    // textField에 모달에서 선택했던 피커 값 넣어주기
    func textFieldData(data: String) {
        selectTextField.text = data
    }
}
