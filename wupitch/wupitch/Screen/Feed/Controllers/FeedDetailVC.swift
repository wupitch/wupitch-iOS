//
//  FeedDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class FeedDetailVC: UIViewController {

    @IBOutlet weak var feedImageVIew: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    var status : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    func setStyle() {
        // 글씨체
        profileNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        likeLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        // 프로필사진 동그랗게
        profileImageVIew.makeRounded(cornerRadius: nil)
        // 그라디언트 효과
        gradientView.setGradient(color1: UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5), color2: UIColor.clear)
    }
    
    func colorHeartBtn() {
        status = true
        heartBtn.setImage(UIImage(named: "redLike"), for: .normal)
    }
    
    func clearHeartBtn() {
        status = false
        heartBtn.setImage(UIImage(named: "like"), for: .normal)
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // 하트버튼
    @IBAction func touchUPHeartBtn(_ sender: Any) {
        status = !status
        if status == true {
            colorHeartBtn()
        }
        else {
            clearHeartBtn()
        }
        print(status)
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
