#
# Be sure to run `pod lib lint Snap2me.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Snap2me'
  s.version          = '0.1.0'
  s.summary          = 'Snap2me helps you add the snap feature to your views.'

  s.description      = <<-DESC
    Your views need some guidance when users drag and drop things in it. Snap2me helps you implement these line guides into any view and its subviews are snapped once they are captured in a threshold.
                       DESC

  s.homepage         = 'https://github.com/erkekin/Snap2me'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'erkekin' => 'erkekin@gmail.com' }
  s.source           = { :git => 'https://github.com/erkekin/Snap2me.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/erkekin'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'Snap2me/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Snap2me' => ['Snap2me/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
