//
//  CombineGlobalKey.swift
//  
//
//  Created by joser on 2021/6/5.
//

import Foundation

/// 设置全局绑定的Key
public struct CombineGlobalKey {
    /// 初始化一个全局绑定的`Key`
    /// - Parameter key: 必须是程序运行期间唯一的字符串
    public init(key: String) {
        self.key = key
    }
    
    /// 程序运行期间唯一的字符串
    let key:String
}
