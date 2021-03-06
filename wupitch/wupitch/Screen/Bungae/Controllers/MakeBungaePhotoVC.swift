//
//  MakeBungaePhotoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaePhotoVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var plusImageVIew: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var questionTextCountLabel: UILabel!
    @IBOutlet weak var questionLabel: LabelFontSize!
    @IBOutlet weak var materialsTextCountLabel: UILabel!
    @IBOutlet weak var materialsLabel: LabelFontSize!
    @IBOutlet weak var crewInfoTextCountLabel: UILabel!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var crewInfoTextView: UITextView!
    @IBOutlet weak var materialsTextView: UITextView!
    @IBOutlet weak var questionTextView: UITextView!
    
    var keyHeight: CGFloat?
    let picker = UIImagePickerController()
    let placeholder = ("어떤 번개인지 소개해주세요",
                       "활동에 꼭 필요한 준비물을 입력해주세요",
                       "문의할 수 있는 연락수단을 입력해주세요. (예: 카카오톡 아이디, 인스타그램 아이디, 휴대폰번호 등)")
    var basicImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
        tapGesture()
        setBasicImage()
        //setKeyboard()
    }
   
    private func setBasicImage() {
        basicImage = UIImage(named: "imgBungaeThumb")
    }
    
   
    
    private func setStyle() {
        titleTextField.delegate = self
        picker.delegate = self
        
        photoView.makeRounded(cornerRadius: 8.adjusted)
        imageLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
        
        crewInfoTextView.makeRounded(cornerRadius: 8.adjusted)
        crewInfoTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        crewInfoTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        materialsTextView.makeRounded(cornerRadius: 8.adjusted)
        materialsTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        materialsTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        questionTextView.makeRounded(cornerRadius: 8.adjusted)
        questionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        questionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        crewInfoTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        crewInfoTextCountLabel.textColor = .gray03
        
        materialsTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        materialsTextCountLabel.textColor = .gray03
        
        questionTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        questionTextCountLabel.textColor = .gray03
    }
    
    func placeholderSetting() {
        crewInfoTextView.delegate = self
        crewInfoTextView.text = "어떤 번개인지 소개해주세요"
        crewInfoTextView.textColor = .gray03
        
        materialsTextView.delegate = self
        materialsTextView.text = "활동에 꼭 필요한 준비물을 입력해주세요."
        materialsTextView.textColor = .gray03
        
        questionTextView.delegate = self
        questionTextView.text = "문의할 수 있는 연락수단을 입력해주세요. (예: 카카오톡 아이디, 인스타그램 아이디, 휴대폰번호 등)"
        questionTextView.textColor = .gray03
    }
    
    func checkInfoIsFilled() {
        if SignUpUserInfo.shared.bungaeIntroduction != nil &&
           SignUpUserInfo.shared.bungaeInquiries != nil &&
           SignUpUserInfo.shared.bungaeTitle != nil &&
           photoImageView.image != nil {
            nextBtn.backgroundColor = .main
        } else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    // tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) {(action) in
            self.openLibrary()
        }
        let defaultImage = UIAlertAction(title: "기본 이미지 사용", style: .default) { [weak self] _ in
            self?.photoImageView.image = self?.basicImage
            SignUpUserInfo.shared.bungaeBasicPhoto = self?.photoImageView.image
            SignUpUserInfo.shared.bungaePhoto = nil
            self?.imageLabel.isHidden = true
            self?.plusImageVIew.isHidden = true
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(defaultImage)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // UIImagePicker
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
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
            dvc.titleLabel = "작성한 모든 기입정보가 삭제됩니다. \n 번개만들기를 그만두시겠습니까?"
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            
            // 번개제목
            SignUpUserInfo.shared.bungaeTitle = titleTextField.text ?? ""
            // 번개소개
            SignUpUserInfo.shared.bungaeIntroduction = crewInfoTextView.text ?? ""
            // 문의처
            SignUpUserInfo.shared.bungaeInquiries = questionTextView.text ?? ""
            
            // 번개준비물 (선택)
            if materialsTextView.textColor != .bk {
                SignUpUserInfo.shared.bungaeMaterials = nil
            }
            else {
                SignUpUserInfo.shared.bungaeMaterials = materialsTextView.text
            }
            
            print("번개이름, 번개소개, 번개준비물, 문의처 >>>>>>>>>>",SignUpUserInfo.shared.bungaeTitle ?? "이름이 없어요",SignUpUserInfo.shared.bungaeIntroduction ?? "소개가 없어요", SignUpUserInfo.shared.bungaeMaterials ?? "준비물이 없어요", SignUpUserInfo.shared.bungaeInquiries ?? "문의처가 없어요")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaeCount", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaeCountVC") as? MakeBungaeCountVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeBungaePhotoVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = titleTextField.text {
            SignUpUserInfo.shared.bungaeTitle = title.isEmpty ? nil : title
        }
        else {
            print("엘스문")
        }
        checkInfoIsFilled()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textView.text = nil
            textView.textColor = .bk
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if crewInfoTextView.text.isEmpty {
            crewInfoTextView.text = placeholder.0
            crewInfoTextView.textColor = .gray03
        } else {
            if crewInfoTextView.text != placeholder.0 {
                SignUpUserInfo.shared.bungaeIntroduction = crewInfoTextView.text
            }
        }
    
        if materialsTextView.text.isEmpty {
            materialsTextView.text = placeholder.1
            materialsTextView.textColor = .gray03
            SignUpUserInfo.shared.bungaeMaterials = nil
        }
        
        if questionTextView.text.isEmpty {
            questionTextView.text = placeholder.2
            questionTextView.textColor = .gray03
        } else {
            if questionTextView.text != placeholder.2 {
                SignUpUserInfo.shared.bungaeInquiries = questionTextView.text
            }
        }
        checkInfoIsFilled()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if crewInfoTextView.isEditable == true {
            guard textView.text!.count <= 500 else { return false }
            
            crewInfoTextCountLabel.text = "\(textView.text?.count ?? 0)" + "/500"
            crewInfoTextCountLabel.textColor = .gray03
            crewInfoTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        }
        
        if materialsTextView.isEditable == true {
            guard textView.text!.count <= 100 else { return false }
            
            materialsTextCountLabel.text = "\(textView.text?.count ?? 0)" + "/100"
            materialsTextCountLabel.textColor = .gray03
            materialsTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        }
        
        if questionTextView.isEditable == true {
            guard textView.text!.count <= 100 else { return false }
            
            questionTextCountLabel.text = "\(textView.text?.count ?? 0)" + "/100"
            questionTextCountLabel.textColor = .gray03
            questionTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        }
       
        // 엔터버튼 키보드 내려가기
        if text == "\n" {
            textView.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - UIImagePicker
extension MakeBungaePhotoVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            photoImageView.image = image
            SignUpUserInfo.shared.bungaePhoto = photoImageView.image
            SignUpUserInfo.shared.bungaeBasicPhoto = nil
            print(info)
            imageLabel.isHidden = true
            plusImageVIew.isHidden = true
            
            checkInfoIsFilled()
        }
        else {
            SignUpUserInfo.shared.bungaePhoto = nil
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeBungaePhotoVC : AlertDelegate {
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
