# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
deployment_target = '9.0'

target 'Nutrition-Analysis' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Nutrition-Analysis
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'ObjectMapper'
  pod 'MBProgressHUD'
  pod 'SwiftLint'
  pod 'Swinject'
  target 'Nutrition-AnalysisTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Nutrition-AnalysisUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
