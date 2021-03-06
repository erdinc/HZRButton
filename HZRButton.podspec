#
# Be sure to run `pod lib lint HZRButton.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HZRButton"
  s.version          = "0.1.1"
  s.summary          = "Stylish button with loading indicator."
  s.homepage         = "https://github.com/erdincakkaya/HZRButton"
  s.license          = 'MIT'
  s.author           = { "Erdinc Akkaya" => "hz.root@gmail.com" }
  s.source           = { :git => "git@github.com:erdincakkaya/HZRButton.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hzroot'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes'
  s.resources = ['Pod/Assets/**/*.png']
end
