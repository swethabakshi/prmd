# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nbmd_ps/version'

Gem::Specification.new do |spec|
  spec.name          = 'nbmd_ps'
  spec.version       = NbmdPs::VERSION
  spec.authors       = ['geemus']
  spec.email         = ['geemus@gmail.com']
  spec.description   = 'scaffold, verify and generate docs from JSON Schema'
  spec.summary       = 'JSON Schema tooling'
  spec.homepage      = 'TODO:put your homepage here'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'erubis',      '~> 2.7'
  spec.add_dependency 'json_schema', '~> 0.3', '>= 0.3.1'
  spec.add_dependency 'activesupport', '~> 4.2.1'
  spec.add_dependency 'colorize', '~> 0.7.5'
end
