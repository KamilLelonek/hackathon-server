module Accidents
  module Services
    module PushDroneAssigned
      class << self
        def call(accident)
          broadcast_event accident_params(accident)
        end

        private
        def broadcast_event(params)
          Pusher::Services::BroadcastEvent.(params)
        end

        def accident_params(accident)
          {
            event:       'dron_took_off',
            accident_id: accident.id,
            drone_id:    accident.drone_id,
          }
        end
      end
    end
  end
end
