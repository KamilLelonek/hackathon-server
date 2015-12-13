module Twilio
  module Services
    module MakeCall
      Error = Class.new(StandardError)

      class << self
        def call(phone_number)
          twilio_response do |response|
            dial(response) do |dial|
              text(dial, phone_number)
            end
          end.text
        end

        def twilio_response
          Twilio::TwiML::Response.new { |response| yield response }
        end

        def dial(twilio_response)
          twilio_response.Dial(callerId: Twilio::Common::Constants.phone_number) { |dial| yield dial }
        end

        def text(dial, phone_number)
          dial.text!(phone_number) { fail Error, 'No caller phone number!' }
        end
      end
    end
  end
end
