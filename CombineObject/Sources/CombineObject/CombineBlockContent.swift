//
//  CombineBlockContent.swift
//  
//
//  Created by zhang hang on 2019/8/4.
//

import Foundation
public struct CombineBlockContent {
    private var identifier:String
    private var value:CombineValue
    private var view:CombineView
    public init(identifier:String, view:CombineView, value:CombineValue) {
        self.identifier = identifier
        self.view = view
        self.value = value
    }
    public func register<Value:CombineValue,View:CombineView>(identifier iden:String = "", valueType et:Value.Type, viewType wt:View.Type, _ block:(Value,View) -> Void) {
        guard self.identifier == iden, let value = self.value as? Value, let view = self.view as? View else {
            return
        }
        block(value,view)
    }
}
