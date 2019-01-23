module NestConnect
  class API
    module Devices
      class Structure < BaseDevice
        private

          def resource
            "structures/#{resource_id}"
          end

          def resources
            "structures"
          end
      end
    end
  end
end
