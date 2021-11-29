//
//  AreaService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/14.
//

import Foundation
import Alamofire

struct AreaService {
    static let shared = AreaService()

    let url = "https://prod.wupitch.site/app/areas"

    func getArea(delegate: CrewVC) {

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [ "Content-Type":"application/json"])
            .responseDecodable(of: AreaData.self) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessArea(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
