module NestConnect
  class API
    class Authorize < API
      def initialize(auth_code:, client_id:, client_secret:, stdout: STDOUT)
        @auth_code = auth_code
        @client_id = client_id
        @client_secret = client_secret
        @stdout = stdout
      end

      def run
        response = connection.post do |request|
          request.url(url)
          request.headers.merge!(headers)
          request.body = body
        end

        if response.status == 200
          configuration.access_token = response.body[:access_token]
        else
          stdout.write response.body
        end
      end

        private

          attr_reader :auth_code, :client_id, :client_secret, :stdout

          def url
            'oauth2/access_token'
          end

          def headers
            { 'Content-Type' => 'application/x-www-form-urlencoded' }
          end

          def body
            URI.encode_www_form(data)
          end

          def data
            {
              code: auth_code,
              client_id: client_id,
              client_secret: client_secret,
              grant_type: 'authorization_code'
            }
          end

          def api_endpoint
            'https://api.home.nest.com'
          end
    end
  end
end
