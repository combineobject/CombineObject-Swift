@propertyWrapper
public struct CombineObjectBind<Value:CombineValue> {
    public var bind:CombineBind
    private let defaultValue:Value
    public init(_ defaultValue:Value) {
        self.defaultValue = defaultValue
        self.bind = CombineBind(content: defaultValue)
    }
    public var wrappedValue:Value? {
        get { self.bind.content as? Value}
        set {
            print("set")
            self.bind.setCombineValue(value: newValue ?? self.defaultValue)
        }
    }
    public func wrappedValue(_ identifier:String, _ wrappedValue:Value) {
        self.bind.setCombineValue(identifier: identifier, value: wrappedValue)
    }
}

