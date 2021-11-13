//
//  MakeCrewDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewDateVC: UIViewController {

    @IBOutlet weak var secondBgView: UIView!
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet var addBtn: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        addBtn[0].makeRounded(cornerRadius: nil)
        addBtn[1].makeRounded(cornerRadius: nil)
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewPhoto", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewPhotoVC") as? MakeCrewPhotoVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpAddBtn(_ sender: UIButton) {
        if firstBgView.isHidden == false {
            addBtn[0].setImage(UIImage(named: "subtract"), for: .normal)
            firstBgView.isHidden = true
            print("이프눌린다")
        }
        else {
            addBtn[0].setImage(UIImage(named: "add"), for: .normal)
            firstBgView.isHidden = false
            print("엘즈눌린다")
        }
    }
    
    @IBAction func touchUpAddSecondBtn(_ sender: Any) {
        if secondBgView.isHidden == false {
            addBtn[1].setImage(UIImage(named: "subtract"), for: .normal)
            secondBgView.isHidden = true
            print("이프눌린다")
        }
        else {
            addBtn[1].setImage(UIImage(named: "add"), for: .normal)
            secondBgView.isHidden = false
            print("엘즈눌린다")
        }
    }
    
}
