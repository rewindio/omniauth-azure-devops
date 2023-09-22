# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-azure-devops/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "omniauth-azure-devops"
  gem.version       = Omniauth::AzureDevops::VERSION
  gem.authors       = ['Rewind Software Inc. | Parth Chandgadhiya']
  gem.email         = ['team@rewind.io']

  gem.summary       = %q{An Azure Devops OAuth strategy for OmniAuth 2.0}
  gem.description   = %q{An Azure Devops OAuth strategy for OmniAuth 2.0}
  gem.homepage      = "https://github.com/rewind/omniauth-azure-devops"
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|.github|examples)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'bundler', '2.0.1'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rewind-ruby-style'
  gem.add_development_dependency 'rspec', '~> 3.9.0'
  gem.add_development_dependency 'rubocop', '~> 0.87.0'
  gem.add_development_dependency 'simplecov', '~> 0.19'
  gem.add_development_dependency 'simplecov-console', '~> 0.4'
end
