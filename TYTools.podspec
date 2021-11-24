#
# Be sure to run `pod lib lint TYTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TYTools'
  s.version          = '0.1.5'
  s.summary          = 'a tools set.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A tools set.
                       DESC

  s.homepage         = 'https://github.com/FlameTinary/TYTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sheldon' => 'tinarychina@gmail.com' }
  s.source           = { :git => 'https://github.com/FlameTinary/TYTools.git', :tag => s.version.to_s }
  s.social_media_url = 'https://sheldon.top'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TYTools/Classes/**/*'
  
  s.subspec 'TYCategories' do |ss|
      ss.source_files = 'TYTools/Classes/TYCategories/**/*'
  end
  s.subspec 'TYDeviceInfo' do |ss|
      ss.source_files = 'TYTools/Classes/TYDeviceInfo/**/*'
  end
  s.subspec 'TYMacros' do |ss|
      ss.source_files = 'TYTools/Classes/TYMacros/**/*'
  end
  s.subspec 'TYPhotoPicker' do |ss|
      ss.source_files = 'TYTools/Classes/TYPhotoPicker/**/*'
  end
  s.subspec 'TYViews' do |ss|
      ss.source_files = 'TYTools/Classes/TYViews/**/*'
  end
  # s.resource_bundles = {
  #   'TYTools' => ['TYTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
