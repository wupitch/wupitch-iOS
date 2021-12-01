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
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    lazy var memberAreaDataManager = MemberAreaService()
    lazy var areaInformationDataManager = AreaInformationService()
    
    var areaName : MemberAreaResult?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        textFieldToAddTarget()
        memberAreaDataManager.getMemberArea(delegate: self)
        
        
    }
    
    // MARK: - Function
    // Style
    private func setStyle() {
        // 모달뷰 처음에는 안보이게
        modalBgView.alpha = 0.0
        
        // textField Style
        selectTextField.tintColor = .clear
        selectTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        selectTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        selectTextField.layer.borderColor = UIColor.gray02.cgColor
        selectTextField.layer.borderWidth = 1.adjusted
        selectTextField.layer.cornerRadius = 8.adjusted
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
    }

    // 텍스트 필드 눌렀을 때 addTarget주기
    private func textFieldToAddTarget() {
        selectTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
    }
    
    // textFieldToAddTarget()의 addTarget
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        // 텍스트필드 눌렀을 때 모달 화면 띄워주기
        let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)

        SignUpUserInfo.shared.bottomSheetMethod = .signUp

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
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        // 버튼 색이 .main일 때만 동작
        if nextBtn.backgroundColor == .main {
            
            for i in 0...25 {
                if selectTextField.text == SignUpUserInfo.shared.areaName?[i] {
                    SignUpUserInfo.shared.selectAreaPicker = i+1
                }
            }
            areaInformationDataManager.patchInformation(AreaInformationRequest(areaId: SignUpUserInfo.shared.selectAreaPicker ?? -1), delegate: self)
            navigationController?.popViewController(animated: true)
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
        //SignUpUserInfo.shared.region = data
    }
}

// 팝업창
extension SignUpCityVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
                SignUpUserInfo.shared.dispose()
            }
        }
    }
}

extension SignUpCityVC {
    func didSuccessMemberArea(result: MemberAreaResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        areaName = result
        if result.areaID != nil {
            // 선택되면 textField 색상 변경
            selectTextField.textColor = .main
            selectTextField.attributedPlaceholder = NSAttributedString(string: result.areaName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.main])
            selectTextField.layer.borderColor = UIColor.main.cgColor
        }
        else {
            print("값이 없어요")
        }
        
    }
    
    // 회원 수정 에이피아이
    func didSuccessInformation(result: InformationData) {
        print("수정한 값이 성공적으로 적용되었습니다.")
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

