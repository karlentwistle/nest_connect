module NestConnect
  class RangeError < StandardError; end

  class Device
    class Thermostat
      def self.from_hash(hash)
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

      attr_accessor(
        :humidity,
        :locale,
        :temperature_scale,
        :is_using_emergency_heat,
        :has_fan,
        :software_version,
        :has_leaf,
        :where_id,
        :device_id,
        :name,
        :can_heat,
        :can_cool,
        :target_temperature_high_c,
        :target_temperature_high_f,
        :target_temperature_low_c,
        :target_temperature_low_f,
        :ambient_temperature_c,
        :ambient_temperature_f,
        :away_temperature_high_c,
        :away_temperature_high_f,
        :away_temperature_low_c,
        :away_temperature_low_f,
        :eco_temperature_high_c,
        :eco_temperature_high_f,
        :eco_temperature_low_c,
        :eco_temperature_low_f,
        :is_locked,
        :locked_temp_min_c,
        :locked_temp_min_f,
        :locked_temp_max_c,
        :locked_temp_max_f,
        :sunlight_correction_active,
        :sunlight_correction_enabled,
        :structure_id,
        :fan_timer_active,
        :fan_timer_timeout,
        :fan_timer_duration,
        :previous_hvac_mode,
        :hvac_mode,
        :time_to_target,
        :time_to_target_training,
        :where_name,
        :label,
        :name_long,
        :is_online,
        :hvac_state
      )

      private

        attr_reader :api_class

        def api_runner
          api_class.new(device_id)
        end
    end
  end
end
