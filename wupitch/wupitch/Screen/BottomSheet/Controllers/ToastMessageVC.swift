//
//  ToastMessageVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/15.
//

import UIKit



class ToastMessageVC: UIViewController {

    @IBOutlet weak var toastLabel: UILabel!
    @IBOutlet weak var toastMessageBgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    func setStyle() {
        toastLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        toastMessageBgView.makeRounded(cornerRadius: 16.adjusted)
    }

   

}
