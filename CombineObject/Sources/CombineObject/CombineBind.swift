//
//  CombineBind.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import Foundation

public class CombineBind {
    public typealias CustomSetCombineValueBlock = (CombineBlockContent) -> Void
    public typealias CustomCombineValueChangedBlock = (CombineValue) -> Void
    private var content:CombineValue
    private var views:[CombineWeakView] = []
    private var customSetCombineValueBlock:CustomSetCombineValueBlock?
    private var customCombineValueChangedBlock:CustomCombineValueChangedBlock?
    public init<Value:CombineValue>(content:Value) {
        self.content = content
    }
    public func appendCombineView(view:CombineWeakView) {
        self.views.append(view)
    }
    
    public func setCombineValue<Value:CombineValue>(identifier:CombineIdentifier = CombineIdentifierEmpty.empty, value:Value) {
        self.content = value
        self.customCombineValueChangedBlock?(value)
        for view in views {
            if let block = self.customSetCombineValueBlock {
                let blockContent = CombineBlockContent(identifier: view.identifier, view: view.view, value: self.content)
                block(blockContent)
            } else {
                view.view.setCombineValue(view.identifier,self.content)
            }
        }
    }
    public func setCombineValueBlock(_ block:@escaping CustomSetCombineValueBlock) {
        self.customSetCombineValueBlock = block
    }
    public func combineValueChangedBlock(_ block:@escaping CustomCombineValueChangedBlock) {
        self.customCombineValueChangedBlock = block
    }
    public func contentValue() -> CombineValue {
        return self.content
    }
}
