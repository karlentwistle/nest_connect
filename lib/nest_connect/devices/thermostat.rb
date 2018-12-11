module NestConnect
  class Device
    class Thermostat < OpenStruct
      def self.from_json_collection(json)
        JSON.parse(json, symbolize_names: true).values.map do |value|
          new(**value)
        end
      end
    end
  end
end
