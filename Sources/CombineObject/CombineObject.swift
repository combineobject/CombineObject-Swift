//
//  CombineObject.swift
//  
//
//  Created by joser on 2021/6/5.
//

import Foundation


public class CombineObject {
    
    public typealias GlobalUpdateHandle = (_ value:Any, _ uuidString:String?) -> Void
    
    public static let share = CombineObject()
    
    private var globalUpdateHandles:[String:[String:GlobalUpdateHandle]] = [:]
    
    private var globaleValueMap:[String:Any] = [:]
    
    public func update(global key:CombineGlobalKey, value:Any) {
        update(global: key, value: value, from: nil)
    }
    
    func update(global key:CombineGlobalKey, value:Any, from uuidString:String?) {
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
    
    public func monitor(globale key:CombineGlobalKey, _ handle:@escaping GlobalUpdateHandle) {
        monitor(globale: key, uuidString: "\(UUID().uuidString)_\(Date().timeIntervalSince1970)", handle)
    }
    
    func monitor(globale key:CombineGlobalKey, uuidString:String, _ handle:@escaping GlobalUpdateHandle) {
        var handleds:[String:GlobalUpdateHandle] = self.globalUpdateHandles[key.key] ?? [:]
        handleds[uuidString] = handle
        self.globalUpdateHandles[key.key] = handleds
    }
    
    public func value(globale key:CombineGlobalKey) -> Any? {
        return globaleValueMap[key.key]
    }
}
