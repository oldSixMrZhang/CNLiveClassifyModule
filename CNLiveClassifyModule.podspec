#
# Be sure to run `pod lib lint CNLiveClassifyModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CNLiveClassifyModule'
  s.version          = '0.0.2'
  s.summary          = '分类模块组件.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://bj.gitlab.cnlive.com/ios-team/CNLiveClassifyModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cnliveJunBo' => 'wangjunbo@cnlive.com' }
  s.source           = { :git => 'http://bj.gitlab.cnlive.com/ios-team/CNLiveClassifyModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CNLiveClassifyModule/Classes/**/*.{h,m}'

  # s.resource_bundles = {
  #   'CNLiveClassifyModule' => ['CNLiveClassifyModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
 
  s.subspec 'JXCategoryView' do |ss|
      ss.source_files = 'CNLiveClassifyModule/Classes/JXCategoryView/**/*.{h,m}'
      ss.dependency 'CNLiveCommonCategory'
      ss.dependency 'CNLiveBaseKit'
  end
  
  s.dependency 'CNLiveCommonCategory'
  s.dependency 'CNLiveBaseKit'
  
end
