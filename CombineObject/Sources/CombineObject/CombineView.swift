//
//  CombineView.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import UIKit

public protocol CombineView {
    var combineObjects:[String:CombineBind] { get set }
    func setCombineValue(_ identifier:String, _ value:CombineValue?)
    func bind<Value:CombineValue>(_ identifier:String, _ combineObject:CombineObjectBind<Value>)
    func updateBindValue<Value:CombineValue>(_ identifier:String, value:Value)
}

public struct CombineViewKey {
    public static var combineObjects = "combineObjects"
}

extension CombineView {
    public var combineObjects:[String:CombineBind] {
        get {
            objc_getAssociatedObject(self, &CombineViewKey.combineObjects) as? [String:CombineBind] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &CombineViewKey.combineObjects, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func bind<Value:CombineValue>(_ identifier:String = "", _ combineObject:CombineObjectBind<Value>) {
        var view = self
        view.combineObjects[identifier] = combineObject.bind
        combineObject.bind.appendCombineView(view: view)
        view.setCombineValue(identifier, combineObject.wrappedValue)
    }
    public func updateBindValue<Value:CombineValue>(_ identifier:String = "", value:Value) {
        guard let bind = self.combineObjects[identifier] else {
            return
        }
        bind.setCombineValue(identifier: identifier, value: value)
    }
}

extension UILabel : CombineView {
    public func setCombineValue(_ identifier: String, _ value: CombineValue?) {
        self.text = value as? String
    }
}
