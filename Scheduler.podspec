Pod::Spec.new do |s|
  s.name                  = "Scheduler"
  s.version               = "2.0.0"
  s.summary               = "A collection of utility classes for scheduling."
  s.homepage              = "https://github.com/Coledunsby/Scheduler"
  s.authors               = { "Cole Dunsby" => "coledunsby@gmail.com" }
  s.license               = { :type => "MIT", :file => 'LICENSE' }

  s.platform              = :ios
  s.ios.deployment_target = "9.0"
  s.requires_arc          = true
  s.source                = { :git => "https://github.com/Coledunsby/scheduler.git", :tag => "v/#{s.version}" }
  s.source_files          = "Scheduler/**/*.{swift}"
  s.module_name           = s.name

  s.dependency 'SwiftDate'
end
