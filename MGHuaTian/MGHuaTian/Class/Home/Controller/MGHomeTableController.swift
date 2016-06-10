//
//  MGHomeTableController.swift
//  MGHuaTian
//
//  Created by ming on 16/6/10.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit


private let HomeArticleReuseIdentifier = "HomeArticleReuseIdentifier"

class MGHomeTableController: UITableViewController {

    // MARK: - 参数/变量
    // 文章数组
    var articles : [Article]?
    // 当前页
    var currentPage : Int = 0
    // 所有的主题分类
    var categories : [Category]?
    // 选中的分类
    var selectedCategry : Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpnavigationItem()
        
        setUpTableView()
    }
    
    // MARK: - 基本设置
    // 设置导航栏
    private func setUpnavigationItem() {
        // 设置左右item
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP", style: .Plain, target: self, action:Selector("toTop"))
    }
    
    // tableview相关
    private func setUpTableView(){
        // 设置tableview相关
        tableView.registerClass(MGHomeArticleCell.self, forCellReuseIdentifier: HomeArticleReuseIdentifier)
        tableView.rowHeight = 330;
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    // 按钮的点击
    @objc private func selectedCategory(btn: UIButton)
    {
        btn.selected = !btn.selected
        // 如果是需要显示菜单, 先设置transform, 然后再动画取消, 就有一上一下的动画
        if btn.selected {
            // 添加高斯视图
            tableView.addSubview(blurView)
            // 添加约束
            blurView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(tableView)
                // 这儿的约束必须是设置tableView.contentOffset.y, 而不是设置为和tableView的top相等或者0
                // 因为添加到tableview上面的控件, 一滚动就没了...
                // 为什么+64呢? 因为默认的tableView.contentOffset是(0, -64)
                make.top.equalTo(tableView.contentOffset.y+64)
                make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenHeight-49-64))
            })
            // 设置transform
            blurView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight)
        }
        
        UIView.animateWithDuration(0.5, animations: {
            if btn.selected { // 循转
                btn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.blurView.transform = CGAffineTransformIdentity
                self.tableView.bringSubviewToFront(self.blurView)
                self.tableView.scrollEnabled = false
            }else{ // 回去
                btn.transform = CGAffineTransformIdentity
                self.blurView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight)
                self.tableView.scrollEnabled = true
            }
            }) { (_) in
                if !btn.selected{ // 如果是向上走, 回去, 需要removeFromSuperview
                    self.blurView.removeFromSuperview()
                }
        }
        
    }

    
    // MARK: - 懒加载
    private lazy var menuBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "menu"), forState: .Normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.addTarget(self, action: Selector("selectedCategory:"), forControlEvents: .TouchUpInside)
        return btn
    }()

}
