# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ebics_credentials"
  spec.version       = "0.1.1"
  spec.authors       = ["Roman Lehnert"]
  spec.email         = ["roman.lehnert@googlemail.com"]

  spec.summary       = %q{A ruby container for ebics credentials}
  spec.description   = %q{Encapsulates and validates the completeness of ebics credentials}
  spec.homepage      = "http://github.com/romanlehnert/ebics_credentials"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency "byebug", '~> 5'
end
