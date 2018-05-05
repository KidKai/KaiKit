Pod::Spec.new do |s|
  s.name     = 'KaiKit'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'KaiKit'
  s.homepage = 'https://github.com/KidKai/KaiKit'
  s.author   = { 'KidKai' => 'wadekaivan@icloud.com' }
  s.source   = { :git => 'https://github.com/KidKai/KaiKit.git', :tag => s.version }
  s.source_files = 'KaiKit/**/*.{h,m,swift}'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
end
