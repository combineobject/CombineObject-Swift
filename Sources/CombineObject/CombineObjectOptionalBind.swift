@propertyWrapper
public struct CombineObjectOptionalBind<V> {
    
    public var bind:CombineBind<V>
    
    private let globaleKey:CombineGlobalKey?
    
    public init(_ wrappedValue:V?, _ globaleKey:CombineGlobalKey? = nil) {
        self.globaleKey = globaleKey
        self.bind = CombineBind(content: wrappedValue, globaleKey:globaleKey)
    }
    public var wrappedValue:V? {
        get { self.bind.content }
        set { self.bind.content = newValue }
    }
    
    public var projectedValue:CombineBind<V> { self.bind }
}

@propertyWrapper
public struct CombineObjectBind<V> {
    public var bind:CombineBind<V>
    
    private let globaleKey:CombineGlobalKey?
    
    private let defaultVlaue:V
    
    public init(_ wrappedValue:V, _ globaleKey:CombineGlobalKey? = nil) {
        self.globaleKey = globaleKey
        self.defaultVlaue = wrappedValue
        self.bind = CombineBind(content: wrappedValue, globaleKey:globaleKey)
    }
    public var wrappedValue:V {
        get { self.bind.content ?? self.defaultVlaue }
        set { self.bind.content = newValue }
    }
    
    public var projectedValue:CombineBind<V> { self.bind }
}


