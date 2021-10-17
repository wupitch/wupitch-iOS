//
//  UIFont.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/16.
//

import UIKit

enum FontWeight {
    case Regular, Bold
}

extension UIFont {
    
  class func SDGothicRegular(size: CGFloat) -> UIFont {
      return UIFont(name: "AppleSDGothicNeoR", size: size)!
  }
    
  class func SDGothicBold(size: CGFloat) -> UIFont {
    return UIFont(name: "AppleSDGothicNeoB", size: size)!
  }
    
}
 
