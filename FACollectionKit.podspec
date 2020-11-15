#
#  Be sure to run `pod spec lint SessionKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "FACollectionKit"
  spec.version      = "1.0.12"
  spec.summary      = "Easy configuration for bidirectionally scrolling UICollectionView's"

  spec.description  = "Easy configuration for bidirectionally scrolling UICollectionView's."

  spec.homepage     = "https://github.com/ferhatabd/FACollectionKit.git"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  spec.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  spec.author             = { "Ferhat Abdullahoglu" => "abdullahoglu@sabanciuniv.edu" }
  # Or just: spec.author    = "Ferhat Abdullahoglu"
  # spec.authors            = { "Ferhat Abdullahoglu" => "abdullahoglu@sabanciuniv.edu" }
  # spec.social_media_url   = "https://twitter.com/Ferhat Abdullahoglu"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #
  #  When using multiple platforms
   
    spec.ios.deployment_target = "11.0"
  
  

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/ferhatabd/FACollectionKit.git", :branch => "master" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "Sources/**/*.{swift,h,xib,strings}"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #


end
