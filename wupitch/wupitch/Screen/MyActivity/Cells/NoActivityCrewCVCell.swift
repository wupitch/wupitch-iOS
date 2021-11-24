//
//  NoActivityCrewCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class NoActivityCrewCVCell: UICollectionViewCell {

    @IBOutlet weak var lookBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    static let identifier = "NoActivityCrewCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NoActivityCrewCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        bgView.addLineDashedStroke(pattern: [5,5], radius: 16, color: UIColor.main.cgColor)
        lookBtn.setTitleColor(.main, for: .normal)
        lookBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }
    
//    func setDashedLine() {
//        let yourViewBorder = CAShapeLayer()
//        yourViewBorder.strokeColor = UIColor.black.cgColor
//        yourViewBorder.lineDashPattern = [5, 5]
//        yourViewBorder.frame = bgView.bounds
//        yourViewBorder.fillColor = nil
//        yourViewBorder.path = UIBezierPath(rect: bgView.bounds).cgPath
//        bgView.layer.addSublayer(yourViewBorder)
//    }

}



extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 1
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}
