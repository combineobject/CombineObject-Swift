//
//  CombineIdentifier.swift
//  
//
//  Created by 张行 on 2019/8/5.
//

import Foundation

public protocol CombineIdentifier {
    var content:String { get set }
    var identifier:String { get }
}

struct CombineIdentifierKey {
    static var content = "content"
}

extension CombineIdentifier {
    public var identifier:String {
        "\(type(of: self)).\(self.content)"
    }
}

public struct CombineIdentifierEmpty : CombineIdentifier {
    public var content: String
    public static let empty:CombineIdentifierEmpty = CombineIdentifierEmpty(content:"")
}
