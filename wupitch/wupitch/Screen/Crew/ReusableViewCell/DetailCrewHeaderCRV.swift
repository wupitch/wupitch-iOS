//
//  DetailCrewHeaderCRV.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/03.
//

import UIKit

class DetailCrewHeaderCRV: UICollectionReusableView {

    @IBOutlet weak var headerLine: UIView!
    static let identifier = "DetailCrewHeaderCRV"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailCrewHeaderCRV", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    private func setStyle() {
        headerLine.backgroundColor = .gray05
    }
    
}
