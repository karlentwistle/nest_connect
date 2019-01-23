module NestConnect
  module Device
    class BaseDevice
      def self.from_hash_collection(hash)
        hash.values.map { |value| new(value) }
      end

      def self.all(api_class: self.api_class, access_token: nil)
        remote_hash = api_class.new(access_token: access_token).all.body
        from_hash_collection(remote_hash)
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
