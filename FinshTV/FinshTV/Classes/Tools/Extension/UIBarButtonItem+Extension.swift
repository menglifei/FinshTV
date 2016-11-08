//
//  UIBarButtonItem+Extension.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//  导航栏左右按钮扩展

import UIKit

extension UIBarButtonItem {

    //重写构造方法
    convenience init(image : UIImage? = nil, highlightedImage : UIImage? = nil, title : String? = "", target : AnyObject? = nil, action : Selector? = nil) {
        
        //创建按钮
        let btn = UIButton(type : .custom)
        
        btn.setImage(image, for: .normal)
        
        if highlightedImage != nil {
            btn.setImage(highlightedImage, for: .highlighted)
        }
        
        if title != "" {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
            btn.setTitle(title, for: .normal)
        }
        
        if (image?.size.width)! > 44.0 {
            btn.sizeToFit()
        }
        else {
            btn.frame = CGRect.init(x: 0, y: 0, width: 44.0, height: 44.0)
        }
        
        btn.addTarget(target, action: action!, for: .touchUpInside)
        
        self.init(customView : btn)
    }
}
