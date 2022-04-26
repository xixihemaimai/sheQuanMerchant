Pod::Spec.new do |s|
  s.name     = 'CocoaLumberjack'
  s.version  = '1.0.0'
  s.license  = "MIT"
  s.summary  = 'CocoaLumberjack'
  s.homepage = 'https://CocoaLumberjack'
  s.author = "QY"

  s.source   = { :git => "",
                 :tag => "#{s.version}" }

  s.description = 'CocoaLumberjack DESC'

  s.source_files = '**/*.{h,m}'

  s.requires_arc = true

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.8'

end
