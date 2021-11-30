//
//  TagCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class TagCVCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagBgView: UIView!
    
    static let identifier = "TagCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TagCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
        //fittingSize(availableHeight: 500, name: tagLabel.text)
    }
    
    func setStyle() {
        tagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        tagLabel.textColor = .gray01
        
        tagBgView.makeRounded(cornerRadius: 16.adjusted)
        tagBgView.backgroundColor = .gray04
    }
    
//    func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
//        let cell = TagCVCell()
//        cell.configure(name: name)
//
//        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
//        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
//    }
//
//    func configure(name: String?) {
//        tagLabel.text = name
//    }

}
