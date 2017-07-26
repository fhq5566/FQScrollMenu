Pod::Spec.new do |s|  
  s.name     = 'FQScrollMenu'  
  s.version  = '1.0.2'  
  s.license  = 'MIT'  
  s.summary  = 'FQScrollMenu是一个头部和内容可控制和可自定义的滚动菜单，满足部分开发者使用的插件。'  
  s.homepage = 'https://github.com/fhq5566/FQScrollMenu'  
  s.author   = { 'FQ' => 'fhq5566@126.com' }  
  s.source   = { :git => 'https://github.com/fhq5566/FQScrollMenu.git', :tag => '#{s.version}' }  
  s.platform = :ios, "8.0"
  s.source_files = 'FQScrollMenu', 'FQScrollMenu/classes/FQScrollMenu/*.{h,m}'    
  s.framework = 'UIKit'  
  
  s.requires_arc = true    
  s.public_header_files = 'FQScrollMenu/classes/FQScrollMenu/Other/HeaderFiles.h'
  s.source_files = 'FQScrollMenu/classes/FQScrollMenu/Other/HeaderFiles.h' 

  s.dependency "Masonry"
end  
