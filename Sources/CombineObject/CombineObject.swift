//
//  CombineObject.swift
//  
//
//  Created by joser on 2021/6/5.
//

import Foundation

/// 用来管理全局数据源
public class CombineObject {
    
    /// 全局数据更新的回掉
    /// - Parameter value: 全局更新的值
    /// - Parameter uuidString: 全局更新对应的唯一字符串 可能不存在
    public typealias GlobalUpdateHandle = (_ value:Any?, _ uuidString:String?) -> Void
    
    /// 获取运行的单利对象
    public static let share = CombineObject()
    
    /// 存放监听全局值更新的闭包字典 `CombineGlobalKey`的值作为最外层字典
    private var globalUpdateHandles:[String:[String:GlobalUpdateHandle]] = [:]
    /// 存放全局数据
    private var globaleValueMap:[String:Any] = [:]
    
    /// 更新一个全局的值
    /// - Parameters:
    ///   - key: 更新的值的`CombineGlobalKey`
    ///   - value: 需要更新的值
    public func update(global key:CombineGlobalKey, value:Any?) {
        update(global: key, value: value, from: nil)
    }
    
    /// 更新一个全局的值
    /// - Parameters:
    ///   - key: 更新值的`CombineGlobalKey`
    ///   - value: 需要更新的值
    ///   - uuidString: 来源的`uuidString`字符串 用于框架内部逻辑
    func update(global key:CombineGlobalKey, value:Any?, from uuidString:String?) {
        self.globalUpdateHandles.forEach { _key,handles in
            guard _key == key.key else {
                return
            }
            handles.forEach { element in
                if let _uuidString = uuidString, _uuidString == element.key {
                    return
                }
                element.value(value,uuidString)
            }
        }
        self.globaleValueMap[key.key] = value
    }
    
    /// 监听一个全局值的更新
    /// - Parameters:
    ///   - key: 全局值对应的`CombineGlobalKey`
    ///   - handle: 值更新的回掉
    public func monitor(globale key:CombineGlobalKey, _ handle:@escaping GlobalUpdateHandle) {
        monitor(globale: key, uuidString: "\(UUID().uuidString)_\(Date().timeIntervalSince1970)", handle)
    }
    
    /// 监听一个全局值的更新
    /// - Parameters:
    ///   - key: 全局值对应的`CombineGlobalKey`
    ///   - uuidString: 监听来源对象的`uuidString`，用于内部逻辑使用
    ///   - handle: 值更新的回掉
    func monitor(globale key:CombineGlobalKey, uuidString:String, _ handle:@escaping GlobalUpdateHandle) {
        var handleds:[String:GlobalUpdateHandle] = self.globalUpdateHandles[key.key] ?? [:]
        handleds[uuidString] = handle
        self.globalUpdateHandles[key.key] = handleds
    }
    
    /// 获取一个全局值
    /// - Parameter key: 全局值对应的`CombineGlobalKey`
    /// - Returns: 获取的全局值
    public func value(globale key:CombineGlobalKey) -> Any? {
        return globaleValueMap[key.key]
    }
}
