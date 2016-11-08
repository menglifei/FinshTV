//
//  MFTabBarController.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//

import UIKit

class MFTabBarController: UITabBarController {

    //类方法 initiative()
    override class func initialize() {
    
        //设置TabBar颜色
        UITabBar.appearance().tintColor = UIColor.orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加TabBarController子控件
        self.addChildVC(HomeViewController(), image: #imageLiteral(resourceName: "tabHome_24x24_"), selectedImage: #imageLiteral(resourceName: "tabHomeHL_24x24_"), title: "首页")
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.randomColor()
        self.addChildVC(vc2, image: #imageLiteral(resourceName: "tabLiving_24x24_"), selectedImage: #imageLiteral(resourceName: "tabLivingHL_24x24_"), title: "直播")
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.randomColor()
        self.addChildVC(vc3, image: #imageLiteral(resourceName: "tabFocus_24x24_"), selectedImage: #imageLiteral(resourceName: "tabFocusHL_24x24_"), title: "关注")
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.randomColor()
        self.addChildVC(vc4, image: #imageLiteral(resourceName: "tabMine_24x24_"), selectedImage: #imageLiteral(resourceName: "tabMineHL_24x24_"), title: "我的")
    }
    
    //添加子控件
    fileprivate func addChildVC(_ childVC : UIViewController, image : UIImage, selectedImage : UIImage, title : String?) {
        
        //设置TabBarItem
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = image
        childVC.tabBarItem.selectedImage = selectedImage
        
        //包装导航栏
        let nav = MFNavigationController(rootViewController : childVC)
        
        self.addChildViewController(nav)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
