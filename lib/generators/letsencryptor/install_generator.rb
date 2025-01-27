# frozen_string_literal: true

require 'rails/generators'

module Letsencryptor
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc 'Creates a Letsencryptor initializer file at config/initializers/letsencryptor.rb'

    def create_initializer_file
      template 'letsencryptor.rb', 'config/initializers/letsencryptor.rb'
    end
  end
end
