
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nest_connect/version"

Gem::Specification.new do |spec|
  spec.name          = "nest_connect"
  spec.version       = NestConnect::VERSION
  spec.authors       = ["Karl Entwistle"]
  spec.email         = ["karl@entwistle.com"]

  spec.summary       = %q{Simple API Wrapper for Nest Thermostats}
  spec.homepage      = "https://github.com/karlentwistle/nest_connect"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.15'
  spec.add_dependency 'faraday_middleware', '~> 0.12'
  spec.add_dependency 'thor', '~> 0.20'

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
end
