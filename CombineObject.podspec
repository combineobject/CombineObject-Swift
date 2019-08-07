Pod::Spec.new do |spec|
spec.name         = "CombineObject"
  spec.version      = "1.0.0"
  spec.summary      = "CombineObject 响应式框架的 Swift 版本"
  spec.homepage     = "https://github.com/combineobject/CombineObject-Swift"
  spec.license      = "MIT"
  spec.author             = { "张行" => "zhanghang@globalegrow.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/combineobject/CombineObject-Swift", :tag => "#{spec.version}" }
  spec.source_files  = "CombineObject/Sources/CombineObject", "CombineObject/Sources/CombineObject/**/*.{swift}"
end
