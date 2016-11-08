//
//  MFConst.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

// MARK:- 自定义打印
func printLog<T>(_ message:T,
                    file:String = #file,
                    method:String = #function,
                    line:Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}
