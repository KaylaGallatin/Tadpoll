# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tadpoll/version'

Gem::Specification.new do |spec|
  spec.name          = "tadpoll"
  spec.version       = Tadpoll::VERSION
  spec.authors       = ["Kayla"]
  spec.email         = ["kaylacgallatin@gmail.com"]

  spec.summary       = %q{Simple vote system}
  spec.description   = %q{Ruby Gem designed to easily create polls with mutually exclusive options for voters to vote on.}
  spec.homepage      = "https://github.com/KaylaGallatin/Tadpoll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "sqlite3", '~> 1.3.9'
  spec.add_development_dependency "activerecord"
end
