Rails.application.config.sendgrid_client = SendGrid::Client.new do |c|
  c.api_user = Rails.application.secrets.sendgrid_username
  c.api_key  = Rails.application.secrets.sendgrid_password
end
