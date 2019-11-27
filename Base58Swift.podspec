Pod::Spec.new do |s|
  s.name         = "Base58Swift"
  s.version      = "2.1.9"
  s.summary      = "A pure swift implementation of base58 string encoding and decoding."
  s.description  = <<-DESC
  A pure swift implementation of base58 string encoding and decoding. Based off of https://github.com/jbenet/go-base58.
                   DESC

  s.homepage      = "https://github.com/keefertaylor/Base58Swift"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Keefer Taylor" => "keefer@keefertaylor.com" }
  s.source        = { :git => "https://github.com/keefertaylor/Base58Swift.git", :tag => "2.1.9" }
  s.source_files  = "Base58Swift/*.swift"
  s.swift_version = "4.2"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"

  s.dependency "BigInt", "~> 3.1"

  s.test_spec "Tests" do |test_spec|
    test_spec.source_files = "Base58SwiftTests/*.swift"
  end
end
