Pod::Spec.new do |s|
  s.name         = "CircularTimer"
  s.version      = "0.1"
  s.summary      = "CircularTimer iOS"
  s.homepage     = "https://github.com/crowd-studio/circulartimer"
  s.author       = "Crowd-studio"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2013 Crowd Studio
      LICENSE
  }

  s.source       = { :git => "https://github.com/tkach/circulartimer.git" }
  s.source_files = 'CircularTimerDemo/Vendor/CircularTimer/*.{h,m}'

  s.platform     = :ios, '5.0'
  s.requires_arc = true

end