Pod::Spec.new do |s|
  s.name     = 'LDStreaming'
  s.version  = '1.0.0'
  s.license  = "MIT"
  s.summary  = 'LDStreaming'
  s.homepage = 'https://LDStreaming'
  s.author = "QY"

  s.source   = { :git => "https://LDStreaming.git",
                 :tag => "#{s.version}" }

  s.description = 'LDStreaming DESC'

  s.source_files = 'Core/**/*.{h,m}'

  s.requires_arc = true
  
  s.dependency "Protobuf"
  s.dependency "LDMessage"
  s.dependency "CocoaAsyncSocket"
  s.dependency "CocoaLumberjack"

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.8'

end
