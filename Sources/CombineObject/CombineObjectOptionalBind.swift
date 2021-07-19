/// 绑定一个可选的值
@propertyWrapper
public struct CombineObjectOptionalBind<V> {
    /// 存放绑定值的结构体
    public var bind:CombineBind<V?>
    /// 是否是全局值
    private let globaleKey:CombineGlobalKey?
    
    /// 初始化一个绑定可选值
    /// - Parameters:
    ///   - wrappedValue: 默认的值
    ///   - globaleKey: 绑定全局的`CombineGlobalKey` 设置则为全局的值
    public init(_ wrappedValue:V?, _ globaleKey:CombineGlobalKey? = nil) {
        self.globaleKey = globaleKey
        self.bind = CombineBind(content: wrappedValue, globaleKey:globaleKey)
    }
    /// 设置或者获取对应的值
    public var wrappedValue:V? {
        get { self.bind.content }
        set { self.bind.content = newValue }
    }
    /// 为了方便$进行访问
    public var projectedValue:CombineBind<V?> { self.bind }
}

/// 绑定一个不可选的值
@propertyWrapper
public struct CombineObjectBind<V> {
    /// 存放绑定值的结构体
    public var bind:CombineBind<V>
    /// 是否是全局值
    private let globaleKey:CombineGlobalKey?
    /// 默认的值
//    private let defaultVlaue:V
    
    /// 初始化
    /// - Parameters:
    ///   - wrappedValue: 默认值
    ///   - globaleKey: 绑定全局的`CombineGlobalKey` 设置则为全局的值
    public init(_ wrappedValue:V, _ globaleKey:CombineGlobalKey? = nil) {
        self.globaleKey = globaleKey
//        self.defaultVlaue = wrappedValue
        self.bind = CombineBind(content: wrappedValue, globaleKey:globaleKey)
    }
    /// 设置或者获取对应的值
    public var wrappedValue:V {
        get { self.bind.content }
        set { self.bind.content = newValue }
    }
    /// 为了方便$进行访问
    public var projectedValue:CombineBind<V> { self.bind }
}


