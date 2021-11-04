//
//  BaseVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/04.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바 없애기
        self.navigationController?.navigationBar.isHidden = true
    }
}
