module NestConnect
  class ChunkParser
    EVENT = -'event: '
    DATA = -'data: '

    def self.write(chunk)
      unless chunk.empty?
        new(chunk)
      end
    end

    def initialize(chunk)
      @raw_event_line, @raw_data_line = chunk.split("\n")
    end

    def event
      event_line
    end

    def data
      JSON.parse(data_line, symbolize_names: true) || {}
    end

    def thermostats
      Device::Thermostat.from_hash_collection(thermostats_hash)
    end

    private

      def data_hash
        data.fetch(:data, {})
      end

      def devices_hash
        data_hash.fetch(:devices, {})
      end

      def thermostats_hash
        devices_hash.fetch(:thermostats, {})
      end

      def data_line
        @raw_data_line.gsub(DATA, "")
      end

      def event_line
        @raw_event_line.gsub(EVENT, "")
      end
  end
end
