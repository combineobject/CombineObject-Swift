# CombineObject

`CombineObject` 响应式框架 `Swift` 版本, `Value` 和 `View` 相互绑定。

![image-20190806101237397](images/image-20190806101237397.png)

## 安装

### CocoaPods

```ruby
pod 'CombineObject'
```

### Carthage

```ruby
github "combineobject/CombineObject-Swift"
```

### Package

```ruby
https://github.com/combineobject/CombineObject-Swift
```

## 怎么使用

### Example1

> 假如我们界面一个`UIView`和`UILabel`，我们想让`UIView`的背景颜色和`UILabel`的文本颜色一直保持统一。做法很多种，我们看看这个库可以做什么。

- 声明一个变量做控制

  ```swift
  @CombineObjectBind var color = UIColor.gray
  ```
  
- 绑定到试图

  ```swift
  self.displayLabel.bind(identifier: UILabelIdentifier.textColor, combineObject: self._color)
  self.displayView.bind(combineObject: self._color)
  ```
  
- 更新属性更新试图

  ```swift
  self.color = UIColor.red
  ```
  
- 直接更新一个试图的值

``` swift
self.displayView.updateBindValue(value: UIColor.blue)
```

![2019-08-06 10-22-35.2019-08-06 10_24_52](images/UIView.gif)

### Example2

> 比如我们的属性没有我们试图绑定属性 我们想接受到属性变化时候更改值

```swift
self._color.bind.combineValueChangedBlock {[weak self] (value) in
    if let boardColor = value as? UIColor {
        self?.displayLabel.layer.borderWidth = 1
        self?.displayLabel.layer.borderColor = boardColor.cgColor
    }
}
```

![2019-08-06 10-39-10.2019-08-06 10_39_44](images/UIView1.gif)

### Example3

> 属性控制`UIProgressView`属性

![2019-08-06 11-18-14.2019-08-06 11_18_55](images/UIProgress.gif)

### Example4

> 监听输入框的内容

![2019-08-06 11-34-01.2019-08-06 11_34_27](images/UITextFiled.gif)

### Example5

> 监听`UISlider`值

![2019-08-06 11-45-34.2019-08-06 11_45_56](images/UISlider.gif)

### Example6

> 监听`UISwitch`的状态

![2019-08-06 11-55-15.2019-08-06 11_55_32](images/UISwitch.gif)

### Example6

> 监听`UItextView`值变化

![2019-08-06 12-07-29.2019-08-06 12_07_49](images/UItextView.gif)

## 接口文档

### 目前支持的属性

#### UIView

- backgroundColor
- userInteractionEnabled
- frame
- alpha
- hidden

#### UILabel

- text
- font
- textColor
- attributedText

#### UISwitch

- on

#### UITextField

- text
- placeholder

#### UISlider

- value

#### UIProgressView

- progress

#### UITextView

- text

### 扩展`UIView`的赋值支持属性方法

```swift
public func setUIViewCombineValue(_ identifier: CombineIdentifier, _ value: CombineValue?)
```

### 让其他的对象支持属性绑定

> 实现`CombineView`协议

```swift
func setCombineValue(_ identifier:CombineIdentifier, _ value:CombineValue?)
```

### 自定义赋值

> 实现属性`bine`值的代理方法``

```swift
self.color.bine.setCombineValueBlock = { content in
}
```
