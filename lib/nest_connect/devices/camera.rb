module NestConnect
  module Device
    class Camera < BaseDevice
      def self.api_class
        NestConnect::API::Devices::Camera
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

        def api_runner
          api_class.new(device_id, access_token: access_token)
        end
    end
  end
end
