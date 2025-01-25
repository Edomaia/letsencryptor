# frozen_string_literal: true

module Letsencryptor
  class Configuration
    attr_accessor :certificate_renewal_threshold_in_days

    def initialize
      @certificate_renewal_threshold_in_days = 30
    end
  end
end
