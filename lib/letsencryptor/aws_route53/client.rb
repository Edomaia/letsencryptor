# frozen_string_literal: true

module Letsencryptor
  module AwsRoute53
    class Client
      attr_reader :hosted_zone_id, :client

      def initialize(hosted_zone_id: nil)
        @hosted_zone_id = hosted_zone_id
        initialize_client
      end

      def create_txt_record(name, value)
        client.change_resource_record_sets({
                                             hosted_zone_id: hosted_zone_id,
                                             change_batch: {
                                               changes: [{
                                                 action: 'UPSERT',
                                                 resource_record_set: {
                                                   name: name,
                                                   type: 'TXT',
                                                   ttl: 60,
                                                   resource_records: [{
                                                     value: %("#{value}")
                                                   }]
                                                 }
                                               }]
                                             }
                                           })
      end

      def delete_txt_record(name, value)
        client.change_resource_record_sets({
                                             hosted_zone_id: hosted_zone_id,
                                             change_batch: {
                                               changes: [{
                                                 action: 'DELETE',
                                                 resource_record_set: {
                                                   name: name,
                                                   type: 'TXT',
                                                   ttl: 60,
                                                   resource_records: [{
                                                     value: %("#{value}")
                                                   }]
                                                 }
                                               }]
                                             }
                                           })
      end

      private

      def initialize_client
        @client = Aws::Route53::Client.new(
          access_key_id: aws_access_key_id,
          secret_access_key: aws_secret_access_key,
          region: aws_region
        )
      end

      def aws_access_key_id
        ENV.fetch('AWS_ACCESS_KEY_ID')
      end

      def aws_secret_access_key
        ENV.fetch('AWS_SECRET_ACCESS_KEY')
      end

      def aws_region
        ENV.fetch('AWS_REGION', 'us-east-1')
      end
    end
  end
end
