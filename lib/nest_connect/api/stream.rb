module NestConnect
  class API
    class Stream < API
      def initialize(stdout: STDOUT)
        @stdout = stdout
      end

      def run
        connection.get do |request|
          request.headers['Accept'] = 'text/event-stream'
          request.headers['Authorization'] = "Bearer #{access_token}"
          request.headers['Cache-Control'] = 'no-cache'

          request.options.on_data = Proc.new do |chunk, overall_received_bytes|
            stdout.write chunk
          end
        end
      end

      private

        attr_reader :stdout
    end
  end
end
