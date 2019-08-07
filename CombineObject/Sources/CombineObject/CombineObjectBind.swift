@propertyWrapper
public struct CombineObjectBind<Value:CombineValue> {
    public var bind:CombineBind
    private let defaultValue:Value
    public init(initialValue value:Value) {
        self.defaultValue = value
        self.bind = CombineBind(content: value)
    }
    public var wrappedValue:Value {
        get { self.bind.contentValue() as? Value ?? self.defaultValue }
        set { self.bind.setCombineValue(value: newValue) }
    }
    public func wrappedValue(identifier:CombineIdentifier, wrappedValue:Value) {
        self.bind.setCombineValue(identifier: identifier, value: wrappedValue)
    }
}

