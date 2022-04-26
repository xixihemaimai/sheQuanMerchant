Pod::Spec.new do |s|
  s.name     = 'LDDatabase'
  s.version  = '1.0.7'
  s.license  = "MIT"
  s.summary  = 'LDDatabase'
  s.homepage = 'https://LDDatabase'
  s.author = "QY"

  s.source   = { :git => "",
                 :tag => "#{s.version}" }

  s.description = 'LDDatabase DESC'

  s.source_files = '**/*.{h,m,mm}'

  s.vendored_frameworks = 'wcdb/WCDB.framework', 'wcdb/sqlcipher.framework'

  s.requires_arc = true
  
  s.libraries = "z", "c++"
  
  s.public_header_files = 'LLDB.h'
#
#  s.pod_target_xcconfig = {
#      "GCC_PREPROCESSOR_DEFINITIONS" => "WCDB_BUILTIN_COLUMN_CODING SQLITE_HAS_CODEC",
#      "CLANG_CXX_LANGUAGE_STANDARD" => "gnu++0x",
#      "CLANG_CXX_LIBRARY" => "libc++",
#      "OTHER_CFLAGS" => "-fvisibility-inlines-hidden",
#      "OTHER_CPLUSPLUSFLAGS" => "-fvisibility-inlines-hidden",
#    }


  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.8'
  
#  s.private_header_files =

end
