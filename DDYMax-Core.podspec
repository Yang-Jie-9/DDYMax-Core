#
# Be sure to run `pod lib lint DDYMax-Core.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDYMax-Core'
  s.version          = '0.1.1'
  s.summary          = 'A short description of DDYMax-Core.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  DDYMax-Core
                       DESC

  s.homepage         = 'https://github.com/Yang-Jie-9/DDYMax-Core'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yang-Jie-9' => 'yangjie@pointone.tech' }
  s.source           = { :git => 'https://github.com/Yang-Jie-9/DDYMax-Core.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDYMax-Core/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DDYMax-Core' => ['DDYMax-Core/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'StoreKit'
   s.dependency 'DDYMax-JSONModel'
end
