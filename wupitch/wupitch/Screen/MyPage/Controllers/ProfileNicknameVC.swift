//
//  ProfileNicknameVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ProfileNicknameVC: UIViewController {
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var startBtn: NextBtn!
    @IBOutlet weak var textCountLabel: UILabel!
    
    lazy var memberInfoProfileDataManager = MemberInfoProfileService()
    lazy var profileNicknameValidationDataManager = ProfileNicknameValidationService()
    lazy var introductionInformationDataManager = IntroductionInformationService()
    
    var textViewState : Bool?
    let maxLength = 6
    var resultIsSuccess : NicknameValidationData?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
        setDelegate()
        dismissKeyboardWhenTappedAround()
        memberInfoProfileDataManager.getMemberInfo(delegate: self)
    }
    
    // MARK: - Funtion
    func setDelegate() {
        nickNameTextField.delegate = self
    }

    func placeholderSetting() {
        infoTextView.delegate = self
        infoTextView.text = "자기소개를 입력해주세요."
        infoTextView.textColor = .gray03
    }

    func setStyle() {
        // 확인 라벨 처음엔 안보이게
        correctLabel.alpha = 0.0

        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)

        // nicknameTextField Style
        nickNameTextField.backgroundColor = .gray05
        nickNameTextField.borderStyle = .none
        nickNameTextField.layer.cornerRadius = 8
        nickNameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        nickNameTextField.textColor = .gray02
        nickNameTextField.addLeftPadding()

        // textView Style
        infoTextView.backgroundColor = .gray05
        infoTextView.makeRounded(cornerRadius: 8.adjusted)
        infoTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        infoTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)

        // textcountLabel Style
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textCountLabel.textColor = .gray03
    }
    
     //MARK: - IBActions
     //backBtn
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // 다음버튼
    @IBAction func touchUpStartBtn(_ sender: Any) {
        if startBtn.backgroundColor == .main {
            // 싱글톤에 닉네임, 자기소개 넣어주기
            SignUpUserInfo.shared.nickname = nickNameTextField.text
            SignUpUserInfo.shared.introduce = infoTextView.text
            print("닉네임 >>>>>>>>>>", SignUpUserInfo.shared.nickname ?? "값이 없어요!")
            print("자기소개 >>>>>>>>>>", SignUpUserInfo.shared.introduce ?? "값이 없어요!")
            
            introductionInformationDataManager.patchInformation(IntroductionInformationRequest(nickname: nickNameTextField.text ?? "", introduce: infoTextView.text ?? ""), delegate: self)

            navigationController?.popViewController(animated: true)
        }
        else {
            startBtn.backgroundColor = .gray03
        }
    }
}

// MARK: - Extension
extension ProfileNicknameVC: UITextViewDelegate, UITextFieldDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textView.text = nil
            textView.textColor = .bk

            print("여기나오나확인", resultIsSuccess?.isSuccess)
            if resultIsSuccess?.isSuccess == true {
                startBtn.backgroundColor = .main
                print("여기들어오나확인")
            }
            else {
                startBtn.backgroundColor = .gray03
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textViewState = false
            textView.text = "내용을 입력해주세요."
            textView.textColor = .gray03
            startBtn.backgroundColor = .gray03
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 최대 100자
        guard infoTextView.text!.count <= 100 else { return false }

        textCountLabel.text = "\(infoTextView.text?.count ?? 0)" + "/100"
        textCountLabel.textColor = .gray03
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)

        // 엔터버튼 키보드 내려가기
        if text == "\n" {
            textView.resignFirstResponder()
            textViewState = true
        }

        return true
    }

    // UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length

        return newLength <= 6
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        nickNameTextField.textColor = .bk
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        profileNicknameValidationDataManager.postNicknameValidation(ProfileNicknameRequest(nickname: nickNameTextField.text ?? ""), delegate: self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nickNameTextField.resignFirstResponder()
        return true
    }
}

// 닉네임 중복 api 연결, 현재 정보
extension ProfileNicknameVC {
    func didSuccessMemberInfo(result: MemberInfoResult) {
        print("회원 정보 요청에 성공하셨습니다.")

        if result.nickname != nil {
            nickNameTextField.text = result.nickname
            nickNameTextField.textColor = .bk
        } else {
            print("닉네임이 없어요!")
        }
        
        if result.introduce != nil {
            infoTextView.text = result.introduce
            infoTextView.textColor = .bk
        } else {
            print("닉네임이 없어요!")
        }
    }
    
    func didSuccessNicknameValidation(result: NicknameValidationData) {
        print("닉네임 중복 데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)

        resultIsSuccess = result

        if result.isSuccess == false {
            correctLabel.alpha = 1
            correctLabel.text = "사용 불가능한 닉네임입니다."
            correctLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            correctLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
            startBtn.backgroundColor = .gray03
        }
        else {
            correctLabel.alpha = 1
            correctLabel.text = "사용 가능한 닉네임입니다."
            correctLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            correctLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
            if textViewState == true {
                startBtn.backgroundColor = .main
            }
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





