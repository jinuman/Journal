//
//  UIKit+Journal.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 9. 18..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

extension UIImage {
    static func gradientImage(with colors: [UIColor], size:CGSize) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIColor {
    static var gradientStart: UIColor {
        return .init(red: 0.909, green: 0.510, blue: 0.488, alpha: 1.0)
    }
  
    static var gradientEnd: UIColor {
        return .init(red: 0.903, green: 0.640, blue: 0.774, alpha: 1.0)
    }
}
