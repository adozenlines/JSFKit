Pod::Spec.new do |s|
  s.name             = "JSFKit"
  s.version          = "1.0.6"
  s.summary          = "JSFKit is a swift JSON parser implementation of the RSS data reader"
  s.homepage         = "https://github.com/adozenlines/JSFKit"
  s.license          = 'MIT'
  s.author           = { "Sean Batson" => "seanbatson@msn.com" }
  s.source           = { :git => "https://github.com/adozenlines/JSFKit.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'
  s.default_subspec = "Core"
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'  

  s.subspec "Core" do |ss|
    ss.source_files  = "JSFKit/JSFKit", "JSFKit/JSFKit/Extensions", "JSFKit/JSFKit/IO", "JSFKit/JSFKit/Models", "JSFKit/JSFKit/Types"
    ss.framework  = "Foundation"
  end

end
