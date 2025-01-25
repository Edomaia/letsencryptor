# frozen_string_literal: true

require 'letsencryptor'

RSpec.describe 'Configuration' do
  it 'has a configuration' do
    expect(Letsencryptor.config).to be_a(Letsencryptor::Configuration)
  end

  describe 'default configuration' do
    it 'has a default certificate_renewal_threshold_in_days' do
      expect(Letsencryptor.config.certificate_renewal_threshold_in_days).to eq(30)
    end
  end

  describe 'configuration' do
    it 'can be configured' do
      Letsencryptor.configure do |config|
        config.certificate_renewal_threshold_in_days = 10
      end

      expect(Letsencryptor.config.certificate_renewal_threshold_in_days).to eq(10)
    end
  end
end
