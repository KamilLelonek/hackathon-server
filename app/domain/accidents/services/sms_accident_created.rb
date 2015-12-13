module Accidents
  module Services
    module SmsAccidentCreated
      class << self
        def call(accident)
          send_sms sms_params(accident)
        end

        private
        def send_sms(params)
          Twilio::Services::SendSms.(params)
        end

        def sms_params(accident)
          {
            phone_number: user_phone_number(accident),
            message:      sms_body
          }
        end

        def sms_body
          <<-MESSAGE.delete("\n").squeeze
            Your request has been reported.
            A police officer will contact you shortly.
          MESSAGE
        end

        def user_phone_number(accident)
          user(accident.user_id).phone
        end

        def user(user_id)
          Braintree::Queries::GetCustomerById.(id: user_id)
        end
      end
    end
  end
end
