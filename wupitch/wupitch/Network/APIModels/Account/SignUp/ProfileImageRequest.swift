//
//  ProfileImageRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/22.
//

import UIKit

public struct ProfileImageRequest: Codable {

    public let images : Data
    
    public init(images: UIImage) {
        self.images = images.pngData()!
    }
}
