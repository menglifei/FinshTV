//
//  HomeViewController.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/10/27.
//  Copyright © 2016年 管梦飞. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kTitleViewH : CGFloat = 40.0

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : MFPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView : MFPageTitleView = MFPageTitleView(frame:titleFrame, titles : titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : MFPageContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.randomColor()
        childVcs.append(vc1)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.randomColor()
        childVcs.append(vc2)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.randomColor()
        childVcs.append(vc3)
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.randomColor()
        childVcs.append(vc4)
        
//        childVcs.append(RecommendViewController())
//        childVcs.append(GameViewController())
//        childVcs.append(AmuseViewController())
//        childVcs.append(FunnyViewController())
        
        let contentView = MFPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.导航栏属性
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- 导航栏
extension HomeViewController {
    
    // MARK:- 导航栏设置
    fileprivate func setupNavigationBar() {
        
        //左边
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "homeLogoIcon_62x26_"), target: self, action: #selector(self.logoAction))
        
        //右边
        //搜索
        let searchItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "searchBtnIcon_20x20_"), highlightedImage: #imageLiteral(resourceName: "searchBtnIconHL_20x20_"), target: self, action: #selector(self.searchAction))
        
        //扫描
        let scanItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "scanIcon_20x20_"), highlightedImage: #imageLiteral(resourceName: "scanIconHL_20x20_"), target: self, action: #selector(self.scanAction))
        
        //历史
        let historyItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "viewHistoryIcon_20x20_"), highlightedImage: #imageLiteral(resourceName: "viewHistoryIconHL_20x20_"), target: self, action: #selector(self.historyAction))
        
        navigationItem.rightBarButtonItems = [searchItem, scanItem, historyItem]
    }
}

// MARK:- 点击事件
extension HomeViewController {

    @objc fileprivate func logoAction() {
    
        print("logo--")
    }
    
    @objc fileprivate func searchAction() {
        
        print("搜索--")
    }
    
    @objc fileprivate func scanAction() {
        
        print("扫描--")
    }
    
    @objc fileprivate func historyAction() {
        
        print("历史--")
    }
}

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : MFPageTitleViewDelegate {
    
    func MFPageTitleView(_ titleView: MFPageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : MFPageContentViewDelegate {
    
    func MFPageContentView(_ contentView: MFPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
