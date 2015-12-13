module Accidents
  module Services
    module PushAccidentCreated
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
            event:       'accident_happened',
            accident_id: accident.id,
            station_id:  accident.station_id,
            user_id:     accident.user_id,
            lat:         accident.lat,
            lng:         accident.lng,
            kind:        accident.kind,
          }
        end
      end
    end
  end
end
