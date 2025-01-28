# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/letsencryptor/aws_route53/client'

# Mock AWS SDK
module Aws
  module Route53
    class Client
      def initialize(*); end
      def change_resource_record_sets(*); end
    end

    module Errors
      class InvalidInput < StandardError
        def initialize(message)
          super
        end
      end
    end
  end
end

# Ensure module structure exists
module Letsencryptor
  module AwsRoute53
  end
end

RSpec.describe Letsencryptor::AwsRoute53::Client do
  let(:hosted_zone_id) { 'Z123456789ABCD' }
  let(:aws_credentials) do
    {
      access_key_id: 'test_access_key',
      secret_access_key: 'test_secret_key',
      region: 'us-east-1'
    }
  end
  let(:route53_client) { instance_double(Aws::Route53::Client, change_resource_record_sets: nil) }

  before do
    # Stub ENV variables
    allow(ENV).to receive(:fetch).with('AWS_ACCESS_KEY_ID').and_return(aws_credentials[:access_key_id])
    allow(ENV).to receive(:fetch).with('AWS_SECRET_ACCESS_KEY').and_return(aws_credentials[:secret_access_key])
    allow(ENV).to receive(:fetch).with('AWS_REGION', 'us-east-1').and_return(aws_credentials[:region])

    # Stub AWS client initialization
    allow(Aws::Route53::Client).to receive(:new).and_return(route53_client)
  end

  describe '#initialize' do
    subject { described_class.new(hosted_zone_id: hosted_zone_id) }

    it 'initializes with the provided hosted zone ID' do
      expect(subject.hosted_zone_id).to eq(hosted_zone_id)
    end

    it 'creates an AWS Route53 client with correct credentials' do
      expect(Aws::Route53::Client).to receive(:new).with(
        access_key_id: aws_credentials[:access_key_id],
        secret_access_key: aws_credentials[:secret_access_key],
        region: aws_credentials[:region]
      )
      subject
    end

    context 'when environment variables are missing' do
      before do
        allow(ENV).to receive(:fetch).with('AWS_ACCESS_KEY_ID').and_raise(KeyError)
      end

      it 'raises an error' do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end

  describe '#create_txt_record' do
    let(:record_name) { '_acme-challenge.example.com' }
    let(:record_value) { 'validation-token' }
    let(:client) { described_class.new(hosted_zone_id: hosted_zone_id) }

    it 'sends correct request to AWS' do
      expected_params = {
        hosted_zone_id: hosted_zone_id,
        change_batch: {
          changes: [{
            action: 'UPSERT',
            resource_record_set: {
              name: record_name,
              type: 'TXT',
              ttl: 60,
              resource_records: [{
                value: %("#{record_value}")
              }]
            }
          }]
        }
      }

      expect(route53_client).to receive(:change_resource_record_sets).with(expected_params)
      client.create_txt_record(record_name, record_value)
    end

    context 'when AWS request fails' do
      before do
        allow(route53_client).to receive(:change_resource_record_sets)
          .and_raise(Aws::Route53::Errors::InvalidInput.new('Invalid input'))
      end

      it 'raises the error' do
        expect { client.create_txt_record(record_name, record_value) }
          .to raise_error(Aws::Route53::Errors::InvalidInput)
      end
    end
  end

  describe '#delete_txt_record' do
    let(:record_name) { '_acme-challenge.example.com' }
    let(:record_value) { 'validation-token' }
    let(:client) { described_class.new(hosted_zone_id: hosted_zone_id) }

    it 'sends correct request to AWS' do
      expected_params = {
        hosted_zone_id: hosted_zone_id,
        change_batch: {
          changes: [{
            action: 'DELETE',
            resource_record_set: {
              name: record_name,
              type: 'TXT',
              ttl: 60,
              resource_records: [{
                value: %("#{record_value}")
              }]
            }
          }]
        }
      }

      expect(route53_client).to receive(:change_resource_record_sets).with(expected_params)
      client.delete_txt_record(record_name, record_value)
    end

    context 'when AWS request fails' do
      before do
        allow(route53_client).to receive(:change_resource_record_sets)
          .and_raise(Aws::Route53::Errors::InvalidInput.new('Invalid input'))
      end

      it 'raises the error' do
        expect { client.delete_txt_record(record_name, record_value) }
          .to raise_error(Aws::Route53::Errors::InvalidInput)
      end
    end
  end
end
