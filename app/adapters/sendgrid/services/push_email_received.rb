module Sendgrid
  module Services
    module PushEmailReceived
      EVENT = 'email_received'

      class << self
        def call(email, attachments)
          broadcast_event email_params(email, attachments)
        end

        private
        def broadcast_event(params)
          Pusher::Services::BroadcastEvent.(params)
        end

        def email_params(email, attachments)
          {
            event:       EVENT,
            subject:     email.subject,
            body:        email.body,
            from:        email.from[:email],
            to:          email.to.map { |e| e[:email] },
            attachments: attachments
          }
        end
      end
    end
  end
end
