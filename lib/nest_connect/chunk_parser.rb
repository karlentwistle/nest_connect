module NestConnect
  module ChunkParser
    class << self
      EVENT = -'event: '
      DATA = -'data: '

      def write(chunk)
        return if chunk.empty?

        event_line, data_line = chunk.split("\n")
        event = event_line.gsub(EVENT, "")
        data = data_line.gsub(DATA, "")

        JSON.parse(data, symbolize_names: true)
      end
    end
  end
end
