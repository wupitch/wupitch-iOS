//
//  MakeCrewRegionVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewRegionVC: UIViewController {

    @IBOutlet weak var placeLabel: LabelFontSize!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var regionTextField: tapTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        regionTextFieldToAddTarget()
    }

    private func setStyle() {
        placeTextField.delegate = self
        // modalView
        modalView.alpha = 0.0
        placeLabel.CrewNoPlaceLabel()
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
        // textField Style
        regionTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        
        regionTextField.regionTextFieldStyle()
        
        placeTextField.backgroundColor = .gray05
        placeTextField.borderStyle = .none
        placeTextField.makeRounded(cornerRadius: 8.adjusted)
        placeTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        placeTextField.textColor = .gray03
        placeTextField.addLeftPadding()
    }
    
    private func textFieldTest() {
        if regionTextField.layer.borderColor == UIColor.main.cgColor {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    // 지역 텍스트 필드 눌렀을 때 addTarget주기
    private func regionTextFieldToAddTarget() {
        regionTextField.addTarget(self, action: #selector(regionTextFieldDidChange(_:)), for: .touchDown)
    }
    
    // regionTextFieldToAddTarget()의 addTarget
    @objc func regionTextFieldDidChange(_ textField:UITextField) {
        
        // 텍스트필드 눌렀을 때 모달 화면 띄워주기
        let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)

        if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
            dvc.modalPresentationStyle = .overFullScreen
            
            SignUpUserInfo.shared.bottomSheetMethod = .signUp

            // 모달 백그라운드 색 보이게
            modalView.alpha = 1

            // 모달 딜리게이트 할당
            dvc.modalDelegate = self

            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            dvc.titleLabel = "작성한 모든 기입정보가 삭제됩니다. \n 크루만들기를 그만두시겠습니까?"
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
        
    }
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            // 선택한 피커 값을 싱글톤에 넣어주기
            for i in 0...25 {
                if regionTextField.text ==  SignUpUserInfo.shared.areaName?[i] {
                     // 값을 싱글톤에 저장
                     SignUpUserInfo.shared.selectAreaPicker = SignUpUserInfo.shared.areas?[i]
                     print("지역id >>>>>>>>>>", SignUpUserInfo.shared.selectAreaPicker!)
                }
            }
            if placeTextField.textColor == .bk {
                SignUpUserInfo.shared.location = placeTextField.text
            }
            else {
                SignUpUserInfo.shared.location = nil
            }
            print("장소 >>>>>>>>>>",SignUpUserInfo.shared.location ?? "장소미정")
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewInfo", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewInfoVC") as? MakeCrewInfoVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewRegionVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeTextField.textColor = .bk
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        placeTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeCrewRegionVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let crewVC = viewController as? CrewVC { self.navigationController?.popToViewController(crewVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                // SignUpUserInfo.shared.dispose()
            }
        }
    }
}

extension MakeCrewRegionVC : ModalDelegate {
    func modalDismiss() {
        modalView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        regionTextField.text = data
    }
    
    func selectBtnToNextBtn() {
        // 선택되면 textField 색상 변경
        regionTextField.colorTapTextFiledStyle()
        regionTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.main])
        textFieldTest()
    }
}

