# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3vs/version'

Gem::Specification.new do |spec|
  spec.name          = "s3vs"
  spec.version       = S3VS::VERSION
  spec.authors       = ["Yoriki Yamaguchi"]
  spec.email         = ["email@y13i.com"]

  spec.summary       = "S3 as Key-Value Store."
  spec.homepage      = "https://github.com/y13i/s3vs.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie", "~> 3.4"
  spec.add_dependency "aws-sdk", "~> 2.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
