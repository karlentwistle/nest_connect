module NestConnect
  module Device
    class Protect < BaseDevice
      def self.api_class
        NestConnect::API::Devices::Protect
      end

      attr_reader(
        :battery_health,
        :co_alarm_state,
        :device_id,
        :is_manual_test_active,
        :is_online,
        :last_connection,
        :last_manual_test_time,
        :locale,
        :name,
        :name_long,
        :smoke_alarm_state,
        :software_version,
        :structure_id,
        :ui_color_state,
        :where_id,
        :where_name
      )

      private

        def api_runner
          api_class.new(resource_id: device_id, access_token: access_token)
        end
    end
  end
end
