#
# Be sure to run `pod lib lint SALAttributedStringExtentions.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SALAttributedStringExtentions"
  s.version          = "0.1.1"
  s.summary          = "High performance/optimized conversion from HTML to NSAttributedString"
  s.description      = <<-DESC
                       Improves NSAttributedString functionalities, starting with the convertion from HTML to attributed string
* Asynchrounsly download images.
* Adds placeholder.
* Auto Resize image to fit in line. 
                       DESC
  s.homepage         = "https://github.com/SeekingAlpha/SALAttributedStringExtentions"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Marcio Klepacz" => "marcioklepacz@gmail.com" }
  s.source           = { :git => "https://github.com/SeekingAlpha/SALAttributedStringExtentions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marciok'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SALAttributedStringExtentions' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'hpple', '~> 0.2'
  s.dependency 'SDWebImage', '~> 3.7'
end
