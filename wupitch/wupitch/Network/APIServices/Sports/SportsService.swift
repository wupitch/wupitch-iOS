//
//  SportsService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/19.
//

import Foundation
import Alamofire

struct SportsService {
    static let shared = SportsService()
    
    let url = "https://prod.wupitch.site/app/sports"
    
    func getSports(delegate: MakeCrewSportsVC) {
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [ "Content-Type":"application/json"])
            .responseDecodable(of: SportsData.self) { response in
                print("스포츠 버튼 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessSports(result: response.result)
                case .failure(let error):
                    print("스포츠 버튼 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
