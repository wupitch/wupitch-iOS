//
//  testCViewCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

import UIKit

class OnbordingCVCell: UICollectionViewCell {
    
    static let identifier = "OnbordingCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "OnbordingCVCell", bundle: nil)
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(imageName: String) {
        imgView.image = UIImage(named: imageName)
    }

}
