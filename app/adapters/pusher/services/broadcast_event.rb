module Pusher
  module Services
    module BroadcastEvent
      CHANNEL_NAME = 'battlehack-finals-2015'
      EVENT_KEY    = :event

      class << self
        def call(params)
          event_and_message(params).tap do |event, message|
            trigger_pusher(event, message)
          end
        end

        private
        def event_and_message(params)
          [
            extract_event(params),
            build_message(params),
          ]
        end

        def extract_event(params)
          params.fetch(EVENT_KEY) { self.class::EVENT_NAME }
        end

        def build_message(params)
          params.except(
            EVENT_KEY,
            :controller,
            :action
          )
        end

        def trigger_pusher(event, message)
          ::Pusher.trigger(
            CHANNEL_NAME,
            event,
            message
          )
        end
      end
    end
  end
end
