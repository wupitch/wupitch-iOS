//
//  getSportsService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import Alamofire

struct MemberSportsService {
    static let shared = MemberSportsService()
    
    let url = "https://prod.wupitch.site/app/accounts/auth/sports"
    
    func getMemberSports(delegate: SignUpSportsVC) {
        
        var header : HTTPHeaders = []
                
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
//        }
//        else {
//            header = ["Content-Type":"application/json"]
//        }
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2aXZpZHN3YW5AbmF2ZXIuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTYzNzk1MzE0MiwiZXhwIjoxNjM4Mzg1MTQyfQ.UA6CiyhNauZ6Nektt-gjiIdyYWKf9GMZLtBNppT0d04"
        header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: MemberSportsData.self) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMemberSports(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}