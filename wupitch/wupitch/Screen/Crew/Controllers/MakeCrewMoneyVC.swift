//
//  MakeCrewMoneyVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewMoneyVC: UIViewController {

    @IBOutlet weak var titleLabel: LabelFontSize!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }

    private func setStyle() {
        titleLabel.makeCrewTitleLabel()
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func touchUpCancelBtn(_ sender: Any) {
            
        }
        
        @IBAction func touchUpNextBtn(_ sender: Any) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewGuest", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewGuestVC") as? MakeCrewGuestVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }

}
