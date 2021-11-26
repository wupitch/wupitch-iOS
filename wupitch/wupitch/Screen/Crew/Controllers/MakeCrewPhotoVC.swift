//
//  MakeCrewPhotoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewPhotoVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var plusImageVIew: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
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
    
    let picker = UIImagePickerController()
    let placeholder = ("어떤 크루인지 소개해주세요",
                       "활동에 꼭 필요한 준비물을 입력해주세요",
                       "문의할 수 있는 연락수단을 입력해주세요. (예: 카카오톡 아이디, 인스타그램 아이디, 휴대폰번호 등)")
    var basicImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
        tapGesture()
        setBasicImage()
    }
    
    private func setBasicImage() {
        switch SignUpUserInfo.shared.clickSportsBtn {
        case 1:
            basicImage = UIImage(named: "imgFootThumb")
        case 2:
            basicImage = UIImage(named: "imgBaskThumb")
        case 3:
            basicImage = UIImage(named: "imgBadThumb")
        case 4:
            basicImage = UIImage(named: "imgVollThumb")
        case 5:
            basicImage = UIImage(named: "imgRunThumb")
        case 6:
            basicImage = UIImage(named: "imgHikeThumb")
        default:
            break
        }
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
        crewInfoTextView.text = "어떤 크루인지 소개해주세요"
        crewInfoTextView.textColor = .gray03
        
        materialsTextView.delegate = self
        materialsTextView.text = "활동에 꼭 필요한 준비물을 입력해주세요."
        materialsTextView.textColor = .gray03
        
        questionTextView.delegate = self
        questionTextView.text = "문의할 수 있는 연락수단을 입력해주세요. (예: 카카오톡 아이디, 인스타그램 아이디, 휴대폰번호 등)"
        questionTextView.textColor = .gray03
    }
    
    func checkInfoIsFilled() {
        if let _ = SignUpUserInfo.shared.crewInfo,
           let _ = SignUpUserInfo.shared.question,
           let _ = SignUpUserInfo.shared.title,
           let _ = SignUpUserInfo.shared.photo {
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
            SignUpUserInfo.shared.photo = self?.photoImageView.image
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
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            // 크루이름
            SignUpUserInfo.shared.title = titleTextField.text
            // 크루소개
            SignUpUserInfo.shared.crewInfo = crewInfoTextView.text
            // 문의처
            SignUpUserInfo.shared.question = questionTextView.text
            
            if materialsTextView.textColor != .bk {
                SignUpUserInfo.shared.materials = nil
            }
            else {
                SignUpUserInfo.shared.materials = materialsTextView.text
            }
            
            print("크루이름, 크루소개, 크루준비물, 문의처 >>>>>>>>>>",SignUpUserInfo.shared.title ?? "크루이름이 없어요",SignUpUserInfo.shared.crewInfo ?? "크루소개가 없어요", SignUpUserInfo.shared.materials ?? "크루준비물이 없어요", SignUpUserInfo.shared.question ?? "크루문의처가 없어요")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewMoney", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewMoneyVC") as? MakeCrewMoneyVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewPhotoVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = titleTextField.text {
            SignUpUserInfo.shared.title = title.isEmpty ? nil : title
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
            SignUpUserInfo.shared.crewInfo = nil
        } else {
            if crewInfoTextView.text != placeholder.0 {
                SignUpUserInfo.shared.crewInfo = crewInfoTextView.text
            }
        }
        
        if materialsTextView.text.isEmpty {
            materialsTextView.text = placeholder.1
            materialsTextView.textColor = .gray03
            SignUpUserInfo.shared.materials = nil
        }
        
        if questionTextView.text.isEmpty {
            questionTextView.text = placeholder.2
            questionTextView.textColor = .gray03
            SignUpUserInfo.shared.question = nil
        } else {
            if questionTextView.text != placeholder.2 {
                SignUpUserInfo.shared.question = questionTextView.text
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
extension MakeCrewPhotoVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            photoImageView.image = image
            SignUpUserInfo.shared.photo = photoImageView.image
            print(info)
            imageLabel.isHidden = true
            plusImageVIew.isHidden = true
            
            checkInfoIsFilled()
        }
        else {
            SignUpUserInfo.shared.photo = nil
        }
        dismiss(animated: true, completion: nil)
    }
}
