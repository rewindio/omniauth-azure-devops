# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-azure-devops/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rewind Software Inc."]
  gem.email         = ["integration@rewind.io"]
  gem.description   = %q{An Azure Devops OAuth strategy for OmniAuth 2.0}
  gem.summary       = %q{An Azure Devops OAuth strategy for OmniAuth 2.0}
  gem.homepage      = "https://github.com/rewind/omniauth-azure-devops"

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-azure-devops"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::AzureDevops::VERSION
end
