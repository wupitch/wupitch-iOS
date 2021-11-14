//
//  MakeCrewDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewDateVC: UIViewController {

    @IBOutlet var dateBtns: [SportsBtn]!
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
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        if dateBtns[0].status == false {
            dateBtns[0].colorSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[0].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        if dateBtns[1].status == false {
            dateBtns[1].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[1].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpThirdBtn(_ sender: Any) {
        if dateBtns[2].status == false {
            dateBtns[2].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[2].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFourthBtn(_ sender: Any) {
        if dateBtns[3].status == false {
            dateBtns[3].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[3].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFiftnBtn(_ sender: Any) {
        if dateBtns[4].status == false {
            dateBtns[4].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[4].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSixthBtn(_ sender: Any) {
        if dateBtns[5].status == false {
            dateBtns[5].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[5].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSevenxthBtn(_ sender: Any) {
        if dateBtns[6].status == false {
            dateBtns[6].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
        }
        else {
            dateBtns[6].defaultSportsBtn()
        }
    }
}
