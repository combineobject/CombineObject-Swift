//
//  CombineBind.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import Foundation

public class CombineBind<Value> {
    public typealias MonitorValueChangedHandle<V> = (Value?) -> Void
    
    public var content:Value? {
        get {
            return _value
        }
        set {
            updateValue(value: newValue, isNoUpdate: false)
        }
    }
    
    private var _value:Value?
    
    let uuidString:String
    
    let globaleKey:CombineGlobalKey?
    
    private var monitorValueChangedHandles:[MonitorValueChangedHandle<Value>] = []
        
    public init(content:Value?, globaleKey:CombineGlobalKey?) {
        self.uuidString = "\(UUID().uuidString)_\(Date().timeIntervalSince1970)"
        self.globaleKey = globaleKey
        if let globaleKey = globaleKey {
            self._value = CombineObject.share.value(globale: globaleKey) as? Value ?? content
        } else {
            self._value = content
        }
        self.addMonitor(globaleKey: globaleKey)
    }
    
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
    
    private func updateValue(value:Value?, isNoUpdate:Bool) {
        _value = value
        self.monitorValueChangedHandles.forEach { handle in
            handle(value)
        }
        if let globaleKey = self.globaleKey , !isNoUpdate {
            CombineObject.share.update(global: globaleKey, value: value, from: self.uuidString)
        }
    }

    public func monitorValueChanged(_ block:@escaping MonitorValueChangedHandle<Value>) {
        self.monitorValueChangedHandles.append(block)
    }
    
    public func bind<View>(_ v:View, _ handle:@escaping (View, Value?) -> Void) {
        self.monitorValueChanged { value in
            handle(v,value)
        }
        handle(v,self.content)
    }
    
    public func needUpdate() {
        updateValue(value: self.content,  isNoUpdate: false)
    }
}
