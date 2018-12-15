module NestConnect
  class Device
    class Thermostat < OpenStruct
      def self.from_hash(json)
        json.values.map do |value|
          new(**value)
        end
      end
    end
  end
end
