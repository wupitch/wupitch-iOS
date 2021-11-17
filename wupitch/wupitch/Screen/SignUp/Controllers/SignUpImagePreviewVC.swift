//
//  SignUpImagePreviewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import UIKit

class SignUpImagePreviewVC: UIViewController {

    @IBOutlet weak var imagePrevieImageView: UIImageView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var usePhotoBtn: UIButton!
    @IBOutlet weak var cameraAgainBtn: UIButton!
    public var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraAgainBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        usePhotoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let img = self.image {
            self.imagePrevieImageView?.image = img
        }
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    

    @IBAction func touchUpCameraAgainBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpUsePhotoBtn(_ sender: Any) {
        
    }
    
}
