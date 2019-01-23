module NestConnect
  class API
    module Devices
      class Thermostat < BaseDevice
        private

          def resource
            "devices/thermostats/#{resource_id}"
          end

          def resources
            "devices/thermostats"
          end
      end
    end
  end
end
