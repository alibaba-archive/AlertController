#
#  Be sure to run `pod spec lint AlertController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "TBMAlertController"
  spec.version      = "0.0.10"
  spec.summary      = "TBMAlertController is a replacement of UIAlertController."
  spec.description  = "TBMAlertController is a replacement of UIAlertController in Swift, It's is like UIAlertController but more powerful."

  spec.homepage     = "https://github.com/teambition/AlertController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "bruce" => "liangming@teambition.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/teambition/AlertController.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "AlertController/AlertController/*.swift"
  spec.frameworks   = "Foundation", "UIKit"

end
