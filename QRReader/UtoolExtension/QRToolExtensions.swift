//
//  QRToolExtensions.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/25.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationBar {
    
    func showLine(_ show: Bool) {
        if show {
            shadowImage = UIImage.image(color: .gray)
        } else {
            shadowImage = UIImage()
        }
    }
}
