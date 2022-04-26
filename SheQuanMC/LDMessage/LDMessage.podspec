Pod::Spec.new do |s|
  s.name     = 'LDMessage'
  s.version  = '1.0.8'
  s.license  = "MIT"
  s.summary  = 'LDMessage'
  s.homepage = 'https://LDStreaming'
  s.author = "QY"

  s.source   = { :git => "",
                 :tag => "#{s.version}" }

  s.description = 'LDMessage DESC'

  s.source_files = 'gen/**/*.{h,m}',
                   '*.{h,m}'

  s.requires_arc = false
  
  s.dependency "Protobuf"

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.8'

end
