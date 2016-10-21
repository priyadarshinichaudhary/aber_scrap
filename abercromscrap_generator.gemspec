require 'rails/generators'
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "abercromscrap-generator"
  s.version     = "0.1"
  s.platform    = "ruby"
  s.authors     = ["priyadarshini Chaudhary"]
  s.email       = ["priyadarshanimini@gmail.com"]
  s.homepage    = "https://github.com/priyadarshinichaudhary/aber_scrap.git."
  s.license     = "MIT"
  s.summary     = %q{A rails generator for abercromscrap.}
  s.description = %q{This generator will generate your migration}
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.add_development_dependency "rails", "~> 1.8"
  #s.add_development_dependency 'rails', '~> 3.2.0'
end