//
//  KakaoLoginService.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import Foundation
import Alamofire

class KakaoLoginService {
    
    func getKakaoLogin(delegate: OnbordingVC) {
        
        let url = "https://kauth.kakao.com/oauth/authorize?client_id=9adf7b0734541aa03e830d55e6ac785b&redirect_uri=https://prod.wupitch.site/app/account/kakao/callback&response_type=code"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [ "Content-Type":"application/json"])
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
    }
}
