Pod::Spec.new do |spec|
  spec.name                = "FreestarAds-Ogury#{prerelease_tag}"
  spec.version             = "#{podspec_version}"
  spec.author              = 'Freestar'
  spec.license             =  {{ :type => 'Apache2.0', :file => 'LICENSE' }}
  spec.homepage            = 'http://www.freestar.com'
  spec.summary             = 'The Freestar Ogury adapter'
  spec.platform            = :ios, '11.0'

  spec.vendored_frameworks  = 'build/FreestarAds-Ogury.xcframework'
  spec.dependency "FreestarAds#{prerelease_tag}", "~> 5.15#{beta_tag}"
  spec.dependency 'OgurySdk', '~> 2.1.0'
  spec.dependency 'OguryChoiceManager'
  spec.dependency 'OguryAds'

  spec.source = {{ :git => '' }}

  spec.pod_target_xcconfig = {{
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }}

end
