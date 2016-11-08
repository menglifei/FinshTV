//
//  MFNavigationController.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//

import UIKit

class MFNavigationController: UINavigationController {

    override class func initialize() {
    
        UINavigationBar.appearance().barTintColor = UIColor.orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
