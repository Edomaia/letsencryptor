# frozen_string_literal: true

require_relative 'letsencryptor/version'
require_relative 'letsencryptor/aws_route53/client'
require_relative 'letsencryptor/heroku/client'

module Letsencryptor
  class Error < StandardError; end
  # Your code goes here...

  # class Configure
  #   mattr_accessor :heroku_app_name, :heroku_token
  # end

  # TODO: add configuration to this gem!
  # require heroku_client
  # require aws_route_53_client
end
