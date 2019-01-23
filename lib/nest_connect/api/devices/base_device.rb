module NestConnect
  class API
    module Devices
      class BaseDevice < API
       def initialize(resource_id: nil, access_token: nil)
          @resource_id = resource_id
          @access_token = access_token
        end

        def put(body)
          connection.put do |request|
            request.url(resource)
            request.headers.merge!(headers)
            request.body = body
          end
        end

        def get
          connection.get do |request|
            request.url(resource)
            request.headers.merge!(headers)
          end
        end

        def all
          connection.get do |request|
            request.url(resources)
            request.headers.merge!(headers)
          end
        end

        private

          attr_reader :resource_id

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
