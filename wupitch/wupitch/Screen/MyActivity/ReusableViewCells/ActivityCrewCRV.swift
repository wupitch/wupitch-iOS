//
//  ActivityCrewCRV.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class ActivityCrewCRV: UICollectionReusableView {

    @IBOutlet weak var crewLabel: UILabel!
    static let identifier = "ActivityCrewCRV"
    
    static func nib() -> UINib {
        return UINib(nibName: "ActivityCrewCRV", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        crewLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        crewLabel.textColor = .bk
    }
    
}
