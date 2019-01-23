module NestConnect
  class API
    module Devices
      class Protect < BaseDevice
        def put(*args); end
        private

          def resource
            "devices/smoke_co_alarms/#{resource_id}"
          end

          def resources
            "devices/smoke_co_alarms"
          end
      end
    end
  end
end
