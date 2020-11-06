# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'GNBTrades' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GNBTrades
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'

  target 'GNBTradesTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'GNBTradesUITests' do
    # Pods for testing
    
  end

  post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end

end
