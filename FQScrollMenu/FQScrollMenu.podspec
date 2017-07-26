Pod::Spec.new do |s|  
  s.name     = 'FQScrollMenu'  
  s.version  = '1.0.1'  
  s.license  = 'MIT'  
  s.summary  = 'FQScrollMenu是一个头部和内容可控制和可自定义的滚动菜单，满足部分开发者使用的插件。'  
  s.homepage = 'https://github.com/fhq5566/FQScrollMenu'  
  s.author   = { 'FQ' => 'FQ' }  
  s.source   = { :git => 'https://github.com/fhq5566/FQScrollMenu.git', :tag => '1.0.1' }  
  s.platform = :ios    
  s.source_files = 'FQScrollMenu/classes/FQScrollMenu/*.{h,m}'    
  s.framework = 'UIKit'  
  
  s.requires_arc = true    
end  
