module NestConnect
  class API
    module Devices
      class Camera < BaseDevice
        private

          def resource
            "devices/cameras/#{resource_id}"
          end

          def resources
            "devices/cameras"
          end
      end
    end
  end
end
