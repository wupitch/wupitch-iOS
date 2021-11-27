//
//  ReadyCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import UIKit

class ReadyCVCell: UICollectionViewCell {

    @IBOutlet weak var readyLabel: UILabel!
    static let identifier = "ReadyCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ReadyCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readyLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
    }

}
