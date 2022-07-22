Pod::Spec.new do |s|
    s.authors      = "FaceVer"
    s.name         = "FaceVer"
    s.version      = "1.0.0"
    s.summary      = "FaceVer iOS SDK"
    s.description  = "iOS library for FaceVer"
    s.homepage     = "http://bugly.qq.com/"
    s.license      = "MIT"
    s.author       = { "Tencent" => "bugly@tencent.com" }
    s.source       = { :git => '', :tag => "#{s.version}" }
    s.requires_arc = true  
    s.platform     = :ios
    s.ios.deployment_target = '9.0'
    s.vendored_frameworks = "*.framework"
    s.resource = "**/*.bundle"
    s.frameworks = "CoreGraphics",
      "CoreGraphics",
      "Accelerate",
      "SystemConfiguration",
      "AssetsLibrary",
      "CoreTelephony",
      "QuartzCore",
      "CoreFoundation",
      "CoreLocation",
      "ImageIO",
      "CoreMedia",
      "CoreMotion",
      "AVFoundation",
      "WebKit",
      "AudioToolbox",
      "CFNetwork",
      "MobileCoreServices",
      "AdSupport"
    s.library = 'z','c++', 'c++.1', 'c++abi', 'resolv', 'z.1.2.8'
end
#CoreGraphics.framework
#Accelerate.framework
#SystemConfiguration.framework
#AssetsLibrary.framework
#CoreTelephony.framework
#QuartzCore.framework
#CoreFoundation.framework
#CoreLocation.framework
#ImageIO.framework
#CoreMedia.framework
#CoreMotion.framework
#AVFoundation.framework
#WebKit.framework
#libresolv.tbd
#libz.tbd
#libc++.tbd
#libc++.1.tbd
#libc++abi.tbd
#AudioToolbox.framework
#CFNetwork.framework
#MobileCoreServices.framework
#libz.1.2.8.tbd
#AdSupport.framework
