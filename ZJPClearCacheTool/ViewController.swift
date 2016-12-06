//
//  ViewController.swift
//  ZJPClearCacheTool
//
//  Created by 张俊平 on 16/11/1.
//  Copyright © 2016年 张俊平. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true).first!
    /*文件管理*/
    let fileManager = FileManager.default
    
    lazy var tb:UITableView = {
        let tb = UITableView (frame: self.view.bounds, style: UITableViewStyle.plain)
        self.view.addSubview(tb)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    lazy var dataArry: [String] = {
        //var array = [String]()
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tb.rowHeight = 20
        tb.sectionHeaderHeight = 50
        tb.tableHeaderView = UILabel()
        dataArry = ["d"]
        //self.view.addSubview(tb)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        if cell == nil {
            cell  = UITableViewCell(style: .default, reuseIdentifier: "id")
        }
        cell?.backgroundColor = UIColor.gray
        cell?.textLabel?.text = ZJPClearCache.getCacheSizeWithFilesPath(filesPath: cachePath)
        cell?.textLabel?.textAlignment = .right
        //cell?.textLabel?.text = "清除缓存"
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.clear()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func clear()->Void {
        
        let isOk = ZJPClearCache.removeCache()
        if isOk {
            print("清除缓存成功")
            self.present(, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }else{
            print("清除缓存失败")
        }
    }
    
    
}





















