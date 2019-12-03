# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

flutter_application_path = '../flutter_pages/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'QRReader' do
  install_all_flutter_pods(flutter_application_path)
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'WeScan', '>= 0.9'
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'RxDataSources', '~> 3.0'
  pod 'SVProgressHUD'
  pod 'SnapKit', '~> 4.2.0'
  pod 'RealmSwift', '~> 3.17.3'
  # Pods for QRReader
  # for test edit in webside
#  eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
  
  target 'QRReaderTests' do
    install_all_flutter_pods(flutter_application_path)
    inherit! :search_paths
    # Pods for testing
  end

end


