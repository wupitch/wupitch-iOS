////
////  LookUpCrewService.swift
////  wupitch
////
////  Created by 김수정 on 2021/11/28.
////
//
//import Foundation
//import Alamofire
//
//struct LookUpCrewService {
//    static let shared = LookUpCrewService()
//    
//    func getLookUpCrew(delegate: CrewVC) {
//        
////        var header : HTTPHeaders = []
////
////        if let token = UserDefaults.standard.string(forKey: "userToken") {
////            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
////        }
////        else {
////            header = ["Content-Type":"application/json"]
////        }
//        
//        var header : HTTPHeaders = []
//        
//        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2aXZpZHN3YW5AbmF2ZXIuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTYzNzk1MzE0MiwiZXhwIjoxNjM4Mzg1MTQyfQ.UA6CiyhNauZ6Nektt-gjiIdyYWKf9GMZLtBNppT0d04"
//        
//        header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
//        
//        let url: String
//        
//        let ageList = 4
//        let areaId = 1
//        let days = [1,2]
//        let isAsc = true
//        let memberCountValue = 1
//        let page = 1
//        let size = 5
//        let sortBy = "updateAt"
//        let sportsList = [1,2]
//        
//        url = "https://prod.wupitch.site/app/clubs/\(ageList),\(areaId),\(days),\(isAsc),\(memberCountValue),\(page),\(size),\(sortBy),\(sportsList)"
//        
//        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
////                            .responseString(completionHandler: { response in
////                                print("response",response.result)
////                                                }
//            .responseDecodable(of: .self) { response in
//                print("response",response)
//                switch response.result {
//                case .success(let response):
//                    delegate.didSuccessLookUpCrew(result: response.result)
//                case .failure(let error):
//                    print("오류가 났습니다",error.localizedDescription)
//                    delegate.failedToRequest(message: "오류가났습니다.")
//                }
//            }
////        )
//    }
//}
