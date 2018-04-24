Pod::Spec.new do |s|
  s.name         = "KaiKit"
  s.version      = "0.0.1"
  s.summary      = "KaiKit"
  s.description  = <<-DESC
                    KaiKit
                   DESC
  s.homepage     = "https://github.com/KidKai/KaiKit"
  s.license      = "MIT"
  s.author             = { "KidKai" => "wadekaivan@icloud.com" }
  s.source       = { :git => "https://github.com/KidKai/KaiKit.git", :tag => s.version }
  s.source_files  = "KaiKit", "KaiKit/**/*.{swift}"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
end
