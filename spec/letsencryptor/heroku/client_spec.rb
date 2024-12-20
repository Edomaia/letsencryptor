# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Letsencryptor::Heroku::Client do
  let(:app_name) { 'test-app' }
  let(:platform_token) { 'fake-token' }
  let(:platform_api_client) { instance_double(PlatformAPI::Client) }

  subject(:client) { described_class.new(app_name) }

  before do
    ENV['HEROKU_PLATFORM_TOKEN'] = platform_token
    allow(PlatformAPI).to receive(:connect_oauth)
      .with(platform_token)
      .and_return(platform_api_client)
  end

  after do
    ENV.delete('HEROKU_PLATFORM_TOKEN')
  end

  describe '#initialize' do
    it 'sets up client with correct app name' do
      expect(client.app_name).to eq(app_name)
    end

    it 'initializes platform API client' do
      client
      expect(PlatformAPI).to have_received(:connect_oauth).with(platform_token)
    end
  end
end
