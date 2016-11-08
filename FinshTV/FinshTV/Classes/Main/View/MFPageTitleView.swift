//
//  MFPageTitleView.swift
//  FinshTV
//
//  Created by 管梦飞 on 2016/11/8.
//  Copyright © 2016年 管梦飞. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2.0
private let kScrollLineMargin : CGFloat = 5.0
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK:- 定义协议
protocol MFPageTitleViewDelegate : class {
    
    func MFPageTitleView(_ titleView : MFPageTitleView, selectedIndex index : Int)
}

// MARK:- 定义MFPageTitleView类
class MFPageTitleView: UIView {
    
    // MARK:- 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String] = []
    weak var delegate : MFPageTitleViewDelegate?
    
    // MARK:- 懒加载属性
    //标题数组
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    //滚动视图
    fileprivate lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //滚动条
    fileprivate lazy var scrollLine : UIView = {
        
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension MFPageTitleView {
    
    fileprivate func setupSubViews() {
        
        //添加scrollView
        addSubview(scrollView)
        
        //添加title对应的Label
        setupTitleLabels()
        
        //添加底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    
    //添加title对应的Label
    fileprivate func setupTitleLabels() {
        
        //确定frame
        let labelW :CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        //遍历创建label
        for (index, title) in titles.enumerated() {
            
            //创建Label
            let label = UILabel()
            
            //设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //设置属性
            label.tag = index
            
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = UIColor.init(red: kNormalColor.0 / 255.0, green: kNormalColor.1 / 255.0, blue: kNormalColor.2 / 255.0, alpha: 1.0)
            
            //添加到scrollview
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    //添加底线和滚动滑块
    fileprivate func setupBottomLineAndScrollLine() {
        
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.init(red: kSelectColor.0 / 255.0, green: kSelectColor.1 / 255.0, blue: kSelectColor.2 / 255.0, alpha: 1.0)
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x + kScrollLineMargin, y: frame.height - kScrollLineH, width: firstLabel.frame.width - 2 * kScrollLineMargin, height: kScrollLineH)
    }
}


// MARK:- 监听Label的点击
extension MFPageTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        //获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        // 1.如果重复点击同一个label,刷新操作
        
        if currentLabel.tag == currentIndex {
            
            // 6.通知代理
            delegate?.MFPageTitleView(self, selectedIndex: currentIndex)
            return
        }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.init(red: kSelectColor.0 / 255.0, green: kSelectColor.1 / 255.0, blue: kSelectColor.2 / 255.0, alpha: 1.0)
        oldLabel.textColor = UIColor.init(red: kNormalColor.0 / 255.0, green: kNormalColor.1 / 255.0, blue: kNormalColor.2 / 255.0, alpha: 1.0)
        
        //4.保存最新的label下标
        currentIndex = currentLabel.tag
        
        //5.滚动条发生变化
        UIView.animate(withDuration: 0.15, animations: {
            
            self.scrollLine.center.x = currentLabel.center.x
        })
        
        // 6.通知代理
        delegate?.MFPageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension MFPageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.center.x = sourceLabel.center.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor.init(red: (kSelectColor.0 - colorDelta.0 * progress) / 255.0, green: (kSelectColor.1 - colorDelta.1 * progress) / 255.0, blue: (kSelectColor.2 - colorDelta.2 * progress) / 255.0, alpha: 1.0)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor.init(red: (kNormalColor.0 + colorDelta.0 * progress) / 255.0, green: (kNormalColor.1 + colorDelta.1 * progress) / 255.0, blue: (kNormalColor.2 + colorDelta.2 * progress) / 255.0, alpha: 1.0)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
