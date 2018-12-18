module NestConnect
  class Device
    class Camera
      def self.from_hash_collection(hash)
        hash.values.map { |value| new(value) }
      end

      def initialize(api_class: NestConnect::API::Devices::Camera, **args)
        @api_class = api_class
        args.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def reload
        api_runner.get.body.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      attr_reader(
        :device_id,
        :software_version,
        :structure_id,
        :where_id,
        :where_name,
        :name,
        :name_long,
        :is_online,
        :is_audio_input_enabled,
        :last_is_online_change,
        :is_video_history_enabled,
        :web_url,
        :app_url,
        :is_public_share_enabled,
        :activity_zones,
        :public_share_url,
        :snapshot_url,
        :last_event
      )

      attr_reader :is_streaming

      def is_streaming=(value)
        normalized_value = !!value

        api_runner.put({is_streaming: normalized_value})
        @is_streaming = normalized_value
      end

      private

        attr_reader :api_class

        def api_runner
          api_class.new(device_id)
        end
    end
  end
end
