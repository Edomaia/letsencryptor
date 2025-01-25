# frozen_string_literal: true

require_relative 'letsencryptor/version'
require_relative 'letsencryptor/aws_route53/client'
require_relative 'letsencryptor/heroku/client'
require_relative 'letsencryptor/configuration'

module Letsencryptor
  class Error < StandardError; end

  class << self
    # Initialize the configuration
    #
    def config
      @config ||= Configuration.new
    end

    # Configure the gem
    def configure
      yield(config)
    end
  end

  # TODO: add configuration to this gem!
  # require heroku_client
  # require aws_route_53_client
  #
  # How to use this in a Rails app:
  #
  # Letsencryptor.configure do |config|
  #  config.certificate_renewal_threshold_in_days = 10
  # end
  #
  # How to use the configuration in the gem:
  #
  # Letsencryptor.config.certificate_renewal_threshold_in_days
end
