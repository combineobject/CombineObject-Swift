//
//  CombineView.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import UIKit

public struct CombineWeakView {
    var identifier:CombineIdentifier
    var view:CombineView
}

public protocol CombineView {
    var combineObjects:[String:CombineBind] { get set }
    func setCombineValue(_ identifier:CombineIdentifier, _ value:CombineValue?)
    func bind<Value:CombineValue>(identifier:CombineIdentifier, combineObject:CombineObjectBind<Value>)
    func updateBindValue<Value:CombineValue>(identifier:CombineIdentifier, value:Value)
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
    
    public func bind<Value:CombineValue>(identifier:CombineIdentifier = CombineIdentifierEmpty.empty, combineObject:CombineObjectBind<Value>) {
        let key = identifier.identifier
        var view = self
        view.combineObjects[key] = combineObject.bind
        let weakView = CombineWeakView(identifier: identifier, view: view)
        combineObject.bind.appendCombineView(view: weakView)
        view.setCombineValue(identifier, combineObject.wrappedValue)
    }
    public func updateBindValue<Value:CombineValue>(identifier:CombineIdentifier = CombineIdentifierEmpty.empty, value:Value) {
        guard let bind = self.combineObjects[identifier.identifier] else {
            return
        }
        bind.setCombineValue(identifier: identifier, value: value)
    }
}

public struct UIViewIdentifier : CombineIdentifier {
    public var content: String
    public static let isUserInteractionEnabled = UIViewIdentifier(content:"isUserInteractionEnabled")
    public static let frame = UIViewIdentifier(content:"frame")
    public static let alpha = UIViewIdentifier(content:"alpha")
    public static let isHidden = UIViewIdentifier(content:"isHidden")
    public static let backgroundColor = UIViewIdentifier(content:"backgroundColor")
}

extension UIView : CombineView {
    public func setCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let view = self as? UILabel {
            view.setUILabeCombineValue(identifier, value)
        } else if let view = self as? UISwitch {
            view.setUISwitchCombineValue(identifier, value)
        } else if let view = self as? UITextField {
            view.setUITextFieldCombineValue(identifier, value)
        } else if let view = self as? UISlider {
            view.setUISliderCombineValue(identifier, value)
        } else if let view = self as? UIProgressView {
            view.setUIProgressViewCombineValue(identifier, value)
        } else if let _value = value as? Bool, identifier.identifier == UIViewIdentifier.isUserInteractionEnabled.identifier {
            self.isUserInteractionEnabled = _value
        } else if let _value = value as? CGRect, identifier.identifier == UIViewIdentifier.frame.identifier {
            self.frame = _value
        } else if let _value = value as? CGFloat, identifier.identifier == UIViewIdentifier.alpha.identifier {
            self.alpha = _value
        } else if let _value = value as? Bool, identifier.identifier == UIViewIdentifier.isHidden.identifier {
            self.isHidden = _value
        } else if let _value = value as? UIColor, (identifier.identifier == UIViewIdentifier.backgroundColor.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.backgroundColor = _value
        } else {
            self.setUIViewCombineValue(identifier, value)
        }
        
    }
    public func setUIViewCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {}
}

public struct UILabelIdentifier : CombineIdentifier {
    public var content: String
    public static let text = UILabelIdentifier(content:"text")
    public static let font = UILabelIdentifier(content:"font")
    public static let textColor = UILabelIdentifier(content:"textColor")
    public static let attributedText = UILabelIdentifier(content:"attributedText")
}

extension UILabel {
    public func setUILabeCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? String, (identifier.identifier == UILabelIdentifier.text.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.attributedText = nil
            self.text = _value
        } else if let _value = value as? UIFont, identifier.identifier == UILabelIdentifier.font.identifier {
            self.font = _value
        } else if let _value = value as? UIColor, identifier.identifier == UILabelIdentifier.textColor.identifier {
            self.textColor = _value
        } else if let _value = value as? NSAttributedString, identifier.identifier == UILabelIdentifier.attributedText.identifier {
            self.text = nil
            self.attributedText = _value
        }
    }
}

public struct UISwitchIdentidier : CombineIdentifier {
    public var content: String
    public static let isOn = UISwitchIdentidier(content:"isOn")
}

extension UISwitch {
    public func setUISwitchCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? Bool, (identifier.identifier == UISwitchIdentidier.isOn.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.isOn = _value
        }
    }
}

public struct UITextFieldIdentifier : CombineIdentifier {
    public var content: String
    public static let text = UITextFieldIdentifier(content:"text")
    public static let placeholder = UITextFieldIdentifier(content:"placeholder")
}

extension UITextField {
    public func setUITextFieldCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? String, (identifier.identifier == UITextFieldIdentifier.text.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.text = _value
        } else if let _value = value as? String, identifier.identifier == UITextFieldIdentifier.placeholder.identifier {
            self.placeholder = _value
        }
    }
}

public struct UISliderIdentifier : CombineIdentifier {
    public var content: String
    public static let value = UISliderIdentifier(content:"value")
}

extension UISlider {
    public func setUISliderCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? Float, (identifier.identifier == UISliderIdentifier.value.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.value = _value
        }
    }
}

public struct UIprogressViewIdentifier : CombineIdentifier {
    public var content: String
    public static let progress = UIprogressViewIdentifier(content: "progress")
}

extension UIProgressView {
    public func setUIProgressViewCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? Float, (identifier.identifier == UIprogressViewIdentifier.progress.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.progress = _value
        }
    }
}

public struct UITextViewIdentifier : CombineIdentifier {
    public var content: String
    public static let text = UITextViewIdentifier(content: "text")
}

extension UITextView {
    public func setUITextViewCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?) {
        if let _value = value as? String, (identifier.identifier == UITextViewIdentifier.text.identifier || identifier.identifier == CombineIdentifierEmpty.empty.identifier) {
            self.text = _value
        }
    }
}

