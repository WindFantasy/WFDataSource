Pod::Spec.new do |spec|
  spec.name         = "WFDataSource"
  spec.version      = "1.0.1"
  spec.summary      = "WFDataSource is for doing SQLite easier."

  spec.homepage     = "https://github.com/WindFantasy/WFDataSource"
  spec.license      = "MIT"
  spec.author       = { "Jerry" => "windfant@sina.com" }
  spec.source       = { :git => "https://github.com/WindFantasy/WFDataSource.git", :tag => "#{spec.version}" }

  spec.source_files  = "WFDataSource/**/*.{h,m}"
  spec.exclude_files = "WFDataSourceDemo", "WFDataSourceTests"

  spec.public_header_files = "**/WFDSDaoManager.h", "**/WFDataSource.h", "**/WFDSConnection.h"

end
