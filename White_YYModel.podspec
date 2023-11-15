Pod::Spec.new do |s|
  s.name         = 'White_YYModel'
  s.summary      = 'Fork from ibireme/YYModel.'
  s.version      = '1.0.5'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'ibireme' => 'ibireme@gmail.com' }
  s.social_media_url = 'http://blog.ibireme.com'
  s.homepage     = 'https://github.com/ibireme/YYModel'

  s.ios.deployment_target = '10.0'

  s.source       = { :git => 'https://github.com/netless-io/White_YYModel.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'White_YYModel/*.{h,m}'
  s.public_header_files = 'White_YYModel/*.{h}'
  
  s.frameworks = 'Foundation', 'CoreFoundation'

end
