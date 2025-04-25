# frozen_string_literal: true

module Ebay
  module Config
    class << self
      def app_id
        @app_id ||= ENV.fetch("EBAY_APP_ID", nil)
      end

      def dev_id
        @dev_id ||= ENV.fetch("EBAY_DEV_ID", nil)
      end

      def cert_id
        @cert_id ||= ENV.fetch("EBAY_CERT_ID", nil)
      end

      attr_writer :app_id, :dev_id, :cert_id
    end
  end
end

Ebay.configure do |config|
  config.app_id = Rails.application.credentials.ebay_app_id
  config.dev_id = Rails.application.credentials.ebay_dev_id
  config.cert_id = Rails.application.credentials.ebay_cert_id
end
