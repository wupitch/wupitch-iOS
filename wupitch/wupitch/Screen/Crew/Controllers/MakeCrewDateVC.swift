//
//  MakeCrewDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewDateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewPhoto", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewPhotoVC") as? MakeCrewPhotoVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
}
