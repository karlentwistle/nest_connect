module NestConnect
  class API
    class Stream < API
      def initialize(output: STDOUT, access_token: nil)
        @output = output
        @access_token = access_token
      end

      def run
        connection.get do |request|
          request.headers['Accept'] = 'text/event-stream'
          request.headers['Authorization'] = "Bearer #{access_token}"
          request.headers['Cache-Control'] = 'no-cache'

          request.options.on_data = Proc.new do |chunk, overall_received_bytes|
            output.write chunk
          end
        end
      end

      private

        attr_reader :output
    end
  end
end
