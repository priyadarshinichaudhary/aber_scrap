# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'abercromscrap/version'

Gem::Specification.new do |spec|
  spec.name          = "abercromscrap"
  spec.version       = Abercromscrap::VERSION
  spec.authors       = ["priyadarshini"]
  spec.email         = ["priyadarshanimini@gmail.com"]

  spec.summary       = %q{scrap the data.}
  spec.description   = %q{Scrap the data using nokogiri}
  spec.homepage      = "https://github.com/priyadarshinichaudhary/aber_scrap.git."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'https://github.com/priyadarshinichaudhary/aber_scrap.git'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files          ='lib/abercromscrap/be_test.rb'
  #spec.files         = `git ls-files -z`.split("\x0")#.reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  # spec.add_development_dependency "sqlite3"
  # spec.add_development_dependency "mysql2", '<= 0.3.20'
  # spec.add_development_dependency "pg"
end
