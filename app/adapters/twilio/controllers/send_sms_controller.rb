module Twilio
  module Controllers
    class SendSmsController < ApplicationController
      def call(phone_number, message)
        Twilio::Services::SendSms.(phone_number, message)
        head :ok
      rescue Twilio::Services::SendSms::Error => e
        render_error(e.message)
      end
    end
  end
end
