//
//  CombineBind.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import Foundation
/// 绑定的对象
public class CombineBind<Value> {
    /// 值更新的回掉
    public typealias MonitorValueChangedHandle<V> = (V) -> Void
    /// 设置和获取值
    public var content:Value {
        get {
            return _value
        }
        set {
            updateValue(value: newValue, isNoUpdate: false)
        }
    }
    /// 真正设置和访问的值
    private var _value:Value
    /// 唯一的标识符
    let uuidString:String
    /// 关联的全局值的`CombineGlobalKey`
    let globaleKey:CombineGlobalKey?
    /// 监听值改变闭包的集合
    private var monitorValueChangedHandles:[MonitorValueChangedHandle<Value>] = []
    
    /// 初始化一个绑定对象
    /// - Parameters:
    ///   - content: 绑定的值
    ///   - globaleKey: 关联的全局值的`CombineGlobalKey`
    public init(content:Value, globaleKey:CombineGlobalKey?) {
        self.uuidString = "\(UUID().uuidString)_\(Date().timeIntervalSince1970)"
        self.globaleKey = globaleKey
        if let globaleKey = globaleKey {
            self._value = CombineObject.share.value(globale: globaleKey) as? Value ?? content
        } else {
            self._value = content
        }
        self.addMonitor(globaleKey: globaleKey)
    }
    
    /// 添加一个监听值更新的回掉
    /// - Parameter globaleKey: 关联的全局值的`CombineGlobalKey`
    private func addMonitor(globaleKey:CombineGlobalKey?) {
        guard  let globaleKey = globaleKey else {
            return
        }
        CombineObject.share.monitor(globale: globaleKey, uuidString: self.uuidString) {[weak self] value, uuidString in
            guard let `self` = self else {
                return
            }
            if let uuidString = uuidString, self.uuidString == uuidString {
                return
            }
            guard let value = value as? Value else {
                return
            }
            self.updateValue(value: value, isNoUpdate: true)
        }
    }
    
    /// 更新真正的值
    /// - Parameters:
    ///   - value: 更新的值
    ///   - isNoUpdate: 是否需要通知更新全局值
    private func updateValue(value:Value, isNoUpdate:Bool) {
        _value = value
        self.monitorValueChangedHandles.forEach { handle in
            handle(value)
        }
        if let globaleKey = self.globaleKey , !isNoUpdate {
            CombineObject.share.update(global: globaleKey, value: value, from: self.uuidString)
        }
    }
    
    /// 添加一个值更新回掉
    /// - Parameter block: 值更新回掉
    public func monitorValueChanged(_ block:@escaping MonitorValueChangedHandle<Value>) {
        self.monitorValueChangedHandles.append(block)
    }
    
    /// 绑定一个值用来做逻辑处理 当值发生改变时候
    /// - Parameters:
    ///   - v: 绑定的到的视图
    ///   - handle: 值更新的回掉
    public func bind<View>(_ v:View, _ handle:@escaping (View, Value) -> Void) {
        self.monitorValueChanged { value in
            handle(v,value)
        }
        handle(v,self.content)
    }
    
    
    /// 绑定值做逻辑处理 绑定初始化或者更新都会回掉
    /// - Parameter handle: 值更新回掉
    public func bind(_ handle:@escaping ((Value) -> Void)) {
        self.monitorValueChanged { value in
            handle(self.content)
        }
        handle(self.content)
    }
    
    /// 需要通知更新 真正值不会更新
    public func needUpdate() {
        updateValue(value: self.content,  isNoUpdate: false)
    }
}
