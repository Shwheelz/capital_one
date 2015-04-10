# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capital_one/version'

Gem::Specification.new do |spec|
  spec.name          = "capital_one"
  spec.version       = CapitalOne::VERSION
  spec.authors       = ["Shane Besong", "Tom Pazamickas"]
  spec.email         = ["sfbesong@gmail.com", "tpazamickas@gmail.com"]

  spec.summary       = %q{Connects to the Capital One API}
  spec.description   = %q{Simply require 'capital_one' to work with the API}
  spec.homepage      = "https://github.com/Shwheelz/capital_one"
  spec.license       = "MIT"

  spec.files         = Dir['lib/capital_one.rb', 'lib/capital_one/*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "json"
  spec.add_development_dependency "rspec", "> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"

end
