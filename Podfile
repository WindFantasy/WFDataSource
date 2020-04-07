# Uncomment this line to define a global platform for your project
platform :ios, '10.0'

# ignore all warnings from all pods
inhibit_all_warnings!

# repo source
source 'https://github.com/CocoaPods/Specs.git'

target 'WFDataSourceDemo' do
    pod 'WFStream', :git => 'https://github.com/WindFantasy/WFStream.git'
end

# 解决依赖的pod与xcode support的deployment版本不一致的warning问题
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            end
        end
    end
end
