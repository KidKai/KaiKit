Pod::Spec.new do |s|
  s.name     = 'KaiKit'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'KaiKit'
  s.homepage = 'https://github.com/KidKai/KaiKit'
  s.author   = { 'KidKai' => 'wadekaivan@icloud.com' }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.2'
  s.tvos.deployment_target = '9.0'
  s.source   = { :git => 'https://github.com/KidKai/KaiKit.git', :tag => s.version }
  s.source_files = 'KaiKit/*.{h,m,swift}',
                   'KaiKit/YYModel/*.{h,m,swift}'
  s.ios.source_files = 'KaiKit/KaiIp/**/*.{h,m,swift}',
                       'KaiKit/!KaiWatch/**/*.{h,m,swift}'
  s.osx.source_files = 'KaiKit/KaiMac/**/*.{h,m,swift}',
                       'KaiKit/!KaiWatch/**/*.{h,m,swift}'
  s.watchos.source_files = 'KaiKit/KaiIp/KaiWatch/**/*.{h,m,swift}'
  s.tvos.source_files = 'KaiKit/KaiIp/KaiTv/**/*.{h,m,swift}',
                        'KaiKit/!KaiWatch/**/*.{h,m,swift}'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
end
