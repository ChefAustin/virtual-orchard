lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "virtual-orchard/version"

Gem::Specification.new do |s|
  s.name          = "virtual-orchard"
  s.version       = VirtualOrchard::VERSION
  s.authors       = ["Chef Austin Culter"]
  s.email         = ["austinculter@gmail.com"]

  s.summary       = "It's my mac in a box."
  s.homepage      = "https://github.com/chefaustin/virtual-orchard"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"

  s.required_ruby_version = '~> 2.6'

  s.requirements << "Vagrant"

end
