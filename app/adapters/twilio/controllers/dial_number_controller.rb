module Twilio
  module Controllers
    class DialNumberController < ApplicationController
      def call(phone_number)
        render xml: Twilio::Services::MakeCall.(phone_number)
      rescue Twilio::Services::MakeCall::Error => e
        render_error(e.message)
      end
    end
  end
end
