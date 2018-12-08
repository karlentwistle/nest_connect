require 'faraday'
require 'faraday_middleware'
require 'json'

module NestConnect
  class API

    private

      def api_endpoint
        'https://developer-api.nest.com'
      end

      def connection
        Faraday.new(url: api_endpoint) do |faraday|
          faraday.use FaradayMiddleware::FollowRedirects
          faraday.adapter Faraday.default_adapter
          faraday.response :json, :content_type => 'application/json'
        end
      end

      def configuration
        GlobalConfig.new
      end

      def access_token
        configuration.access_token
      end
  end
end

require_relative 'authorize'
require_relative 'stream'
