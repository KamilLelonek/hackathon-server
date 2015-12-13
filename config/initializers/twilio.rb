Twilio.configure do |config|
  config.account_sid = Rails.application.secrets.twilio_account_sid
  config.auth_token  = Rails.application.secrets.twilio_auth_token
end

Rails.application.config.twilio_client     = Twilio::REST::Client.new
Rails.application.config.twilio_capability = Twilio::Util::Capability.new.tap do |capability|
  capability.allow_client_outgoing Rails.application.secrets.twilio_app_sid
end
