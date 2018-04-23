Pod::Spec.new do |s|
  s.name         = "KaiKit"
  s.version      = "0.0.1"
  s.summary      = "KaiKit"
  s.description  = <<-DESC
                    KaiKit
                   DESC
  s.homepage     = "https://github.com/KidKai/KaiKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "KidKai" => "wadekaivan@icloud.com" }
  # Or just: s.author    = "KidKai"
  # s.authors            = { "KidKai" => "wadekaivan@icloud.com" }
  # s.social_media_url   = "http://twitter.com/wadekaivan"
  # s.platform     = :ios
  # s.platform     = :ios, "5.0"
  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/KidKai/KaiKit.git", :tag => s.version }
  s.source_files  = "KaiKit", "KaiKit/**/*.{swift}"
  s.exclude_files = "KaiKit/Exclude"
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
  # s.dependency "Alamofire"
end
