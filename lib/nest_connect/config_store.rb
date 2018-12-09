require 'yaml'

module NestConnect
  class ConfigStore
    def initialize(path)
      @path = path
    end

    def [](key)
      data[key]
    end

    def save(key, value)
      data[key] = value

      find_or_create_directory
      find_or_create_file
      persist_data

      value
    end

    private

      attr_reader :path

      def find_or_create_directory
        Dir.mkdir(pathname.dirname) unless Dir.exist?(pathname.dirname)
      end

      def find_or_create_file
        File.new(path, "w") unless File.exists?(path)
      end

      def persist_data
        File.open(path, "w") { |f| f.write(data.to_yaml) }
      end

      def pathname
        Pathname.new(path)
      end

      def data
        @_data ||= load_data
      end

      def load_data
        YAML.load(File.read(path)) || {}
      rescue
        {}
      end
  end
end
