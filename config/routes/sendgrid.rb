mount_griddler '/sendgrid/email'

Griddler.configure do |config|
  config.processor_class  = Sendgrid::Services::ReceiveEmail
  config.processor_method = :call
  config.reply_delimiter  = ''
end
