# frozen_string_literal: true

require_relative 'lib/letsencryptor/version'

Gem::Specification.new do |spec|
  spec.name = 'letsencryptor'
  spec.version = Letsencryptor::VERSION
  spec.authors = ['edoardo maraia', 'eugen mueller']
  spec.email = ['edoardo.maraia@gmail.com', 'eugen.mllr@gmail.com']

  spec.summary = 'This is a gem that allows you to manage your letsencrypt certificates'
  spec.description = 'This is a gem that allows you to manage your letsencrypt certificates'
  spec.homepage = 'https://github.com/Edomaia/letsencryptor'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Edomaia/letsencryptor'
  spec.metadata['changelog_uri'] = 'https://github.com/Edomaia/letsencryptor'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  File.basename(__FILE__)
  spec.files = Dir.glob('**/*') - Dir.glob('*.gem')
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'platform-api', '~> 3.5'

  # Uncomment to register a new development dependency of your gem

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
