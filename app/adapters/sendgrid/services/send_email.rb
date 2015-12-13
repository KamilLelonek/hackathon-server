module Sendgrid
  module Services
    module SendEmail
      EMAIL_FROM = '2015@battlehack.org'

      class << self
        def call(params)
          send_email create_email(
                       to:       params[:to],
                       subject:  params[:subject],
                       contents: params[:contents]
                     )
        end

        private
        def send_email(email)
          client.send email
        end

        def client
          Rails.application.config.sendgrid_client
        end

        def create_email(to:, subject:, contents:)
          SendGrid::Mail.new do |m|
            m.to      = to
            m.from    = EMAIL_FROM
            m.subject = subject
            m.html    = contents
          end
        end
      end
    end
  end
end
