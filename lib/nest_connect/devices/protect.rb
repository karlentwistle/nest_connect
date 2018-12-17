module NestConnect
  class Device
    class Protect
      def self.from_hash_collection(hash)
        hash.values.map { |value| new(value) }
      end

      def initialize(api_class: NestConnect::API::Devices::Protect, **args)
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

        attr_reader :api_class

        def api_runner
          api_class.new(device_id)
        end
    end
  end
end
