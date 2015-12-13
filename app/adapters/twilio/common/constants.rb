module Twilio
  module Common
    module Constants
      class << self
        def phone_number
          Rails.application.secrets.twilio_phone_number
        end
      end
    end
  end
end
