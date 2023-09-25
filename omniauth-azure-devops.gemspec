# frozen_string_literal: true

require File.expand_path('lib/omniauth-azure-devops/version', __dir__)

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-azure-devops'
  gem.version       = Omniauth::AzureDevops::VERSION
  gem.authors       = ['Rewind Software Inc. | Parth Chandgadhiya']
  gem.email         = ['team@rewind.io']

  gem.summary       = 'An Azure Devops OAuth strategy for OmniAuth 2.0'
  gem.description   = 'An Azure Devops OAuth strategy for OmniAuth 2.0'
  gem.homepage      = 'https://github.com/rewind/omniauth-azure-devops'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|.github|examples)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 3.2'

  gem.add_runtime_dependency 'omniauth', '>= 1', '< 3'
  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.metadata['rubygems_mfa_required'] = 'true'
end
