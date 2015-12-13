module Sendgrid
  module Services
    module UploadEmailAttachments
      class << self
        def call(attachments)
          attachments.map &method(:upload_and_map)
        end

        private
        def upload_and_map(attachment)
          map_attachment cloudinary_upload(attachment)
        end

        def map_attachment(uploaded_attachment)
          {
            standard:  uploaded_attachment['secure_url'],
            thumbnail: uploaded_attachment['eager'].first['secure_url'],
          }
        end

        def cloudinary_upload(attachment)
          Cloudinary::Uploader.upload(
            attachment,
            params
          )
        end

        def params
          {
            crop:   :limit,
            width:  500,
            height: 500,
            format: 'png',
            eager:  {
              width:  50,
              height: 50,
              crop:   :fit,
              format: 'png'
            }
          }
        end
      end
    end
  end
end
