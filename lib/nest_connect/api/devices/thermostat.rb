module NestConnect
  class API
    module Devices
      class Thermostat < API
        def initialize(device_id, access_token: nil)
          @device_id = device_id
          @access_token = access_token
        end

        def put(body)
          connection.put do |request|
            request.url(url)
            request.headers.merge!(headers)
            request.body = body
          end
        end

        def get
          connection.get do |request|
            request.url(url)
            request.headers.merge!(headers)
          end
        end

        private

          attr_reader :device_id

          def url
            "devices/thermostats/#{device_id}"
          end

          def headers
            {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{access_token}"
            }
          end
      end
    end
  end
end
