//
//  NowRegisterBungaeService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/08.
//

import Foundation
import Alamofire

// 가입한 번개 조회 API -> 내 활동 뷰에서 사용
struct NowRegisterBungaeService {
    static let shared = NowRegisterBungaeService()

    func getNowRegisterBungae(delegate: MyActivityVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString = "https://dev.yogiyo-backend.shop/app/impromptus/accounts/auth"
        //let urlString = "https://prod.wupitch.site/app/impromptus/accounts/auth"
        
        AF.request(urlString, method: .get, encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets), headers: header)
            .responseDecodable(of: NowRegisterBungaeData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("현재 가입한 번개 정보 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessNowRegisterBungae(result: response.result)
                case .failure(let error):
                    print("현재 가입한 번개 정보에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

