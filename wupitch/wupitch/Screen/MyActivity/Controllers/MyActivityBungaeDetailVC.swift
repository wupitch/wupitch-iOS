////
////  MyActivityBungaeDetailVC.swift
////  wupitch
////
////  Created by 김수정 on 2021/12/08.
////
//
//import UIKit
//
//enum myActivityBungaeTab {
//    case bungaeIntroduce, bungaeCrewone
//}
//
//class MyActivityBungaeDetailVC: UIViewController {
//
//    @IBOutlet weak var alertBtn: UIButton!
//    @IBOutlet weak var backBtn: UIButton!
//    @IBOutlet weak var secondLineView: UIView!
//    @IBOutlet weak var firstLineView: UIView!
//    @IBOutlet weak var secondBtn: UIButton!
//    @IBOutlet weak var firstBtn: UIButton!
//    @IBOutlet weak var MyActivityCV: UICollectionView!
//    
//    var myActivityTabPage = [myActivityBungaeTab.bungaeIntroduce, myActivityBungaeTab.bungaeCrewone]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        MyActivityCV.delegate = self
//        MyActivityCV.dataSource = self
//        MyActivityCV.register(BungaeActivityTVCell.nib(), forCellWithReuseIdentifier: BungaeActivityTVCell.identifier)
//
//        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//        secondLineView.backgroundColor = .clear
//    }
//
//
//    @IBAction func touchUpFirstBtn(_ sender: Any) {
//        MyActivityCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//
//        // 탭바 보이게
//        firstLineView.backgroundColor = .bk
//        // 번개탭바 안보이게
//        secondLineView.backgroundColor = .clear
//
//    }
//
//    @IBAction func touchUpSecondBtn(_ sender: Any) {
//        MyActivityCV.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
//        firstBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//        secondBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        // 탭바 보이게
//        secondLineView.backgroundColor = .bk
//        // 번개탭바 안보이게
//        firstLineView.backgroundColor = .clear
//
//    }
//
//    @IBAction func touchUpBackBtn(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func touchUpAlertBtn(_ sender: Any) {
//        let storyboard = UIStoryboard.init(name: "MyActivityAlert", bundle: nil)
//        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityAlertVC") as? MyActivityAlertVC else {return}
//        dvc.modalPresentationStyle = .overFullScreen
//        dvc.modalTransitionStyle = .crossDissolve
//        present(dvc, animated: true, completion: nil)
//    }
//
//}
//
//extension MyActivityBungaeDetailVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myActivityTabPage.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeActivityTVCell.identifier) as? BungaeActivityTVCell else{
//            return UITableViewCell()
//        }
//        cell.tabBar = myActivityTabPage[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return MyActivityCV.frame.height
//    }
//}
