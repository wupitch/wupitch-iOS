//
//  DetailCrewFooterCRV.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/03.
//

import UIKit

class DetailCrewFooterCRV: UICollectionReusableView {

    @IBOutlet weak var backgroundView: UIView!
    static let identifier = "DetailCrewFooterCRV"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewFooterCRV", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
