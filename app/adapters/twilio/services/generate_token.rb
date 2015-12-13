module Twilio
  module Services
    module GenerateToken
      class << self
        def call
          { token: twilio_capability.generate }
        end

        private
        def twilio_capability
          Rails.application.config.twilio_capability
        end
      end
    end
  end
end
