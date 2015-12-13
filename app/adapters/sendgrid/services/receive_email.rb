module Sendgrid
  module Services
    class ReceiveEmail
      def initialize(email)
        @email = email
      end

      def call
        upload_attachments(email.attachments).tap do |attachments|
          Sendgrid::Services::PushEmailReceived.(email, attachments)
        end
      end

      private
      def upload_attachments(attachments)
        Sendgrid::Services::UploadEmailAttachments.(attachments)
      end

      attr_reader :email
    end
  end
end
