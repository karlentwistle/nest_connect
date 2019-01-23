module NestConnect
  class API
    module Devices
      class Protect < API
        def initialize(device_id, access_token: nil)
          @device_id = device_id
          @access_token = access_token
        end

        def get
          connection.get do |request|
            request.url(url)
            request.headers.merge!(headers)
          end
        end

        def all
          connection.get do |request|
            request.url("devices/smoke_co_alarms")
            request.headers.merge!(headers)
          end
        end

        private

          attr_reader :device_id

          def url
            "devices/smoke_co_alarms/#{device_id}"
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
