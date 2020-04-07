Pod::Spec.new do |spec|
  spec.name         = "WFDataSource"
  spec.version      = "1.0.0"
  spec.summary      = "WFDataSource is for doing SQLite easier."

  spec.homepage     = "https://bitbucket.org/windfantasy/wfdatasource"
  spec.license      = "MIT"
  spec.author       = { "Jerry" => "windfant@sina.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://windfantasy@bitbucket.org/windfantasy/wfdatasource.git", :tag => "#{spec.version}" }

  spec.source_files  = "**/*.{h,m}"
  spec.exclude_files = "WFDataSourceDemo", "WFDataSourceTests"

  spec.public_header_files = "**/WFDSDaoManager.h", "**/WFDataSource.h", "**/WFDSConnection.h"

end
