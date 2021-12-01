//
//  ExtraService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/22.
//

import Foundation
import Alamofire

struct ExtraService {
    static let shared = ExtraService()
    
    let url = "https://prod.wupitch.site/app/extras"
    
    func getExtra(delegate: MakeCrewInfoVC) {
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [ "Content-Type":"application/json"])
            .responseDecodable(of: ExtraData.self) { response in
                print("엑스트라 버튼들 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessExtra(result: response.result)
                case .failure(let error):
                    print("엑스트라 버튼들에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
