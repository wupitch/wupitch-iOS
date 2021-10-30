//
//  KakaoLoginService.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import Foundation
import Alamofire

struct KakaoLoginService {
    static let shared = KakaoLoginService()
    
    let url = "https://prod.wupitch.site/app/account/kakao"
    
    func postKakaoLogin(_ parameters: KakaoLoginRequest, delegate: OnbordingVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
//                    .responseString(completionHandler: { response in
//                        print("response",response.result)
//                                        }
            .responseDecodable(of: KakaoLoginData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    print("이거나오면 여기까진온거야")
                    print("여기에도 값을 보여줘",response.result)
                    delegate.didSuccessKakaoLogin(result: response.result)
                    print("성공햇니",response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
       // )
    }
}
