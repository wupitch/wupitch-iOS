//
//  FeedDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class FeedDetailVC: UIViewController {

    
    @IBOutlet weak var gradientView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientView.setGradient(color1: UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5), color2: UIColor.clear)
    }
    


}

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
