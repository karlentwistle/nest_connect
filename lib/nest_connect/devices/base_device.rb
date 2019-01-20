module NestConnect
  module Device
    class BaseDevice
      def self.from_hash_collection(hash)
        hash.values.map { |value| new(value) }
      end

      def reload
        api_runner.get.body.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      attr_accessor :access_token

      private

        attr_reader :api_class
    end
  end
end
