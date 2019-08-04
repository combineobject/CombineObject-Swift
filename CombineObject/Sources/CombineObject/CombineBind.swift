//
//  CombineBind.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import Foundation

public class CombineBind {
    public typealias CustomSetCombineValueBlock = (CombineBlockContent) -> Void
    public var content:CombineValue
    public var views:[CombineView] = []
    private var customSetCombineValueBlock:CustomSetCombineValueBlock?
    public init<Value:CombineValue>(content:Value) {
        self.content = content
    }
    public func appendCombineView<View:CombineView>(view:View) {
        self.views.append(view)
    }
    
    func setCombineValue<Value:CombineValue>(identifier:String = "", value:Value) {
        self.content = value
        for view in views {
            if let block = self.customSetCombineValueBlock {
                let blockContent = CombineBlockContent(identifier: identifier, view: view, value: self.content)
                block(blockContent)
            } else {
                view.setCombineValue(identifier,self.content)
            }
        }
    }
}
