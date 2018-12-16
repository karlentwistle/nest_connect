module NestConnect
  class RangeError < StandardError; end

  class Device
    class Thermostat
      def self.from_hash_collection(hash)
        hash.values.map { |value| new(value) }
      end

      def initialize(api_class: NestConnect::API::Devices::Thermostat, **args)
        @api_class = api_class
        args.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      TARGET_TEMPERATURE_F_RANGE = (50..90)

      attr_reader :target_temperature_f

      def target_temperature_f=(value)
        normalized_value = value.round

        unless (50..90).include?(normalized_value)
          raise RangeError.new("target_temperature_f must be between #{TARGET_TEMPERATURE_F_RANGE}")
        end

        api_runner.run({target_temperature_f: normalized_value})
        @target_temperature_f = normalized_value
      end

      TARGET_TEMPERATURE_C_RANGE = (9..30)

      attr_reader :target_temperature_c

      def target_temperature_c=(value)
        normalized_value = (value * 2).round / 2.0

        unless (9..30).include?(normalized_value)
          raise RangeError.new("target_temperature_c must be between #{TARGET_TEMPERATURE_C_RANGE}")
        end

        api_runner.run({target_temperature_c: normalized_value})
        @target_temperature_c = normalized_value
      end

      attr_reader :fan_timer_active

      def fan_timer_active=(value)
        normalized_value = !!value

        api_runner.run({fan_timer_active: normalized_value})
        @fan_timer_active = normalized_value
      end

      attr_accessor(
        :fan_timer_duration,
        :hvac_mode,
        :label,
        :target_temperature_high_c,
        :target_temperature_high_f,
        :target_temperature_low_c,
        :target_temperature_low_f,
        :temperature_scale
      )

      attr_reader(
        :ambient_temperature_c,
        :ambient_temperature_f,
        :can_cool,
        :can_heat,
        :device_id,
        :eco_temperature_high_c,
        :eco_temperature_high_f,
        :eco_temperature_low_c,
        :eco_temperature_low_f,
        :fan_timer_duration,
        :fan_timer_timeout,
        :has_fan,
        :has_leaf,
        :humidity,
        :hvac_state,
        :is_locked,
        :is_online,
        :is_using_emergency_heat,
        :last_connection,
        :locale,
        :locked_temp_max_c,
        :locked_temp_max_f,
        :locked_temp_min_c,
        :locked_temp_min_f,
        :name,
        :name_long,
        :previous_hvac_mode,
        :software_version,
        :structure_id,
        :sunlight_correction_active,
        :sunlight_correction_enabled,
        :time_to_target,
        :time_to_target_training,
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
