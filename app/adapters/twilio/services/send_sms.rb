module Twilio
  module Services
    module SendSms
      Error = Class.new(StandardError)

      class << self
        def call(phone_number, message)
          create_message(phone_number, message)
        rescue Twilio::REST::RequestError => e
          fail Error, e.message
        end

        private
        def create_message(phone_number, message_contents)
          Rails.application.config
            .twilio_client
            .messages
            .create(
              to:   phone_number,
              from: Twilio::Common::Constants.phone_number,
              body: message_contents
            )
        end
      end
    end
  end
end
