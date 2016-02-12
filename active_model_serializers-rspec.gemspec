# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_model_serializers/rspec/version"

Gem::Specification.new do |spec|
  spec.name          = "active_model_serializers-rspec"
  spec.version       = ActiveModelSerializers::RSpec::VERSION
  spec.authors       = ["Benjamin Fleischer"]
  spec.email         = ["dev@benjaminfleischer.com"]

  spec.summary       = %q{RSpec Matchers for ActiveModelSerializers}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/bf4/active_model_serializers-rspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "active_model_serializers", [">= 0.10.0.rc4", "<= 0.11"]
  spec.add_runtime_dependency "json-schema"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
