
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bil/version"

Gem::Specification.new do |spec|
  spec.name          = 'bil'
  spec.version       = BIL::VERSION
  spec.authors       = ["JP Hastings-Spital"]
  spec.email         = ["jphastings@gmail.com"]

  spec.summary       = %q{A codec for Big Integer Lists}
  spec.description   = %q{An encoder and decoder to turn arrays of arbitrarily large (non-negative) integers into web safe strings and back.}
  spec.homepage      = 'https://github.com/jphastings/bil'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
end
