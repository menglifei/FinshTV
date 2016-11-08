//
//  UIColor+Extension.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//  UIColor类扩展

import UIKit

extension UIColor {

    //自定义构造方法
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red : r / 255.0, green : g / 255.0, blue : b / 255.0, alpha : 1.0)
    }
    
    //添加类方法
    class func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
}
