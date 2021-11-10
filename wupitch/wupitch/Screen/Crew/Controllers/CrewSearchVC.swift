//
//  CrewSearchVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewSearchVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = [ "안녕", "하세요", "Zedd", "입니다" ]
        searchController.searchBar.showsScopeBar = true
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self

    }
    
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
