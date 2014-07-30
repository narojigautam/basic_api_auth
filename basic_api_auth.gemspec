# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'basic_api_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "basic_api_auth"
  spec.version       = BasicApiAuth::VERSION
  spec.authors       = ["Gautam Naroji"]
  spec.email         = ["gautam@appyantra.com"]
  spec.summary       = %q{Basic authentication for simple API implementations}
  spec.description   = %q{SHA1 Hashkey based authentication for simple API engine}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", "~> 3.0.0"
end
