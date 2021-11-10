//
//  MakeCrewPhotoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewPhotoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func touchUpCancelBtn(_ sender: Any) {
            
        }
        
        @IBAction func touchUpNextBtn(_ sender: Any) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewMoney", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewMoneyVC") as? MakeCrewMoneyVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
    
  
}
