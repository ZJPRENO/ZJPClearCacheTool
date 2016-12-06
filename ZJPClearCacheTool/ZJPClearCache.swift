//
//  ZJPClearCache.swift
//  ZJPClearCacheTool
//
//  Created by 张俊平 on 16/11/2.
//  Copyright © 2016年 张俊平. All rights reserved.
//

import UIKit


class ZJPClearCache: NSObject {
    
    /* 文件管理 */
    static let fileManager = FileManager.default
    
    //MARK:清除缓存
    
    static func removeCache() -> Bool {
        /*文件管理*/
        //let fileManager = FileManager.default
        var flag = true
        var messageInfo = ""
        /* 获取缓存文件路径 */
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true).first!
        //print(cachePath)
        /* 文件数组 */
        let filesArry:[String] = fileManager.subpaths(atPath: cachePath)!
        //print("文件数:\(filesArry.count)")
        /* 遍历文件路径数组 */
        for subpaths in filesArry{
            /* 文件路径 */
            let filePath = cachePath + "/\(subpaths)"
            /* 如果文件存在就删除 */
            if fileManager.fileExists(atPath: filePath) {
                do {
                    try fileManager.removeItem(atPath: filePath)
                    messageInfo = "清除成功"
                    //print("清除成功")
                    flag = true
                }catch {
                    print("清除失败\(error)")
                    messageInfo = "清除失败"
                    flag = false
                }
                
            }else{
                messageInfo = "缓存已经清空"
                flag = false
            }
        }
        print(messageInfo)
        return flag
    }
    
    
    //MARK: - 获得缓存文件大小
    
    static func getCacheSizeWithFilesPath(filesPath:String) -> String {
        
        /*文件管理*/
        let fileManager = FileManager.default
        /* 获取filesPath文件下的所文件 */
        let subpathArray:[String] = fileManager.subpaths(atPath: filesPath)!
        /* 文件总的大小 */
        var totleSize = 0.0
        /* 遍历文件路径 */
        
        for subPath in subpathArray {
            
            /* 拼接每一个文件的全路径 */
            let filePath = filesPath + "/\(subPath)"
            //print("文件路径:\(filePath)")
            /* isExist，判断文件是否存在 */
            let isExist = fileManager.fileExists(atPath: filePath, isDirectory:nil)
            
            /* !filePath.contains(".DS") 过滤掉隐藏文件*/
            if isExist || !filePath.contains(".DS") {
                
                do {
                    
                    let dict = try fileManager.attributesOfItem(atPath: filePath)
                    
                    /* 用元组来取得 文件的的大小 */
                    for (key,value) in dict {
                        
                        if key == FileAttributeKey.size {
                            /* 每个文件的大小 */
                            let size = (value as! Double)
                            totleSize += size //总的大小
                        }
                        
                    }
                    
                } catch _ {
                }
                
            }
            
        }
        
        /* 返回文件大小 */
        /* 将文件夹大小转换为 M/KB/B */
        var sizeStr = ""
        
        if totleSize > 1024*1024{
            
            sizeStr = String(format:"%.1fMB", totleSize / 1024.0 / 1024.0)
            
        }else if totleSize > 1024 {
            
            sizeStr = String(format:"%.1fKB", totleSize / 1024.0)
            
        }else if totleSize > 0{
            
            sizeStr = String(format:"%.2fB", totleSize / 1.0)
            
        }else {
            
            sizeStr = String(format:"%.2fMB", totleSize / 1.0)//"0.00MB"
            
        }
        
        return sizeStr
        
    }
    
    
}
