module NestConnect
  class API
    class Stream < API
      def start
        connection.get do |request|
          request.headers['Accept'] = 'text/event-stream'
          request.headers['Authorization'] = "Bearer #{access_token}"
          request.headers['Cache-Control'] = 'no-cache'

          request.options.on_data = Proc.new do |chunk, overall_received_bytes|
            puts chunk
          end
        end
      end
    end
  end
end
