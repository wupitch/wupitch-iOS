//
//  FCMTestService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/06.
//

//import Foundation
//import Alamofire
//
//struct FCMTestService {
//    static let shared = FCMTestService()
//
//    let url = "https://prod.wupitch.site/app/fcm/test"
//
//    func postFCM(_ parameters: FCMTestRequest, delegate: CrewVC) {
//
//        var header : HTTPHeaders = []
//
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
//        }
//        else {
//            header = ["Content-Type":"application/json"]
//        }
//
//        AF.request(url, method: .post, parameters: parameters,
//                   encoder: JSONParameterEncoder(), headers: header)
//            .responseDecodable(of: FCMTestData.self, emptyResponseCodes: [200, 204, 205]) { response in
//                print("fcm 알림 response",response)
//                switch response.result {
//                case .success(let response):
//                    delegate.didSuccessFCMTest(result: response)
//                case .failure(let error):
//                    print("fcm 알림에서 오류가 났습니다",error.localizedDescription)
//                    delegate.failedToRequest(message: "오류가났습니다.")
//                }
//            }
//    }
//}
