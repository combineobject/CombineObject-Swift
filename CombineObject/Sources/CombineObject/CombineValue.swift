//
//  CombineValue.swift
//  
//
//  Created by zhang hang on 2019/8/2.
//

import UIKit

public protocol CombineValue {}

extension String : CombineValue {}
extension Int : CombineValue {}
extension Int8 : CombineValue {}
extension Int16 : CombineValue {}
extension Int32 : CombineValue {}
extension Int64 : CombineValue {}
extension Float : CombineValue {}
extension Double : CombineValue {}
extension CGFloat : CombineValue {}
extension CGRect : CombineValue {}
extension UIColor : CombineValue {}
extension UIFont : CombineValue {}
extension NSAttributedString : CombineValue {}
