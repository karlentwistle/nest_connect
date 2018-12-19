require 'faraday'
require 'faraday_middleware'
require_relative 'adapter/streaming_net_http'

module NestConnect
  class API

    private

      def api_endpoint
        'https://developer-api.nest.com'
      end

      def connection
        Faraday.new(url: api_endpoint) do |faraday|
          faraday.response :json, :content_type => 'application/json'
          faraday.request :json
          faraday.use FaradayMiddleware::FollowRedirects
          faraday.use NestConnect::Adapter::StreamingNetHttp
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
require_relative 'devices/camera'
require_relative 'devices/protect'
require_relative 'devices/thermostat'
require_relative 'devices/structure'
