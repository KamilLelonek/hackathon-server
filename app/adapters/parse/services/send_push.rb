module Parse
  module Services
    module SendPush
      CHANNEL_NAME = 'battlehack'

      module ClassMethods
        def call(message)
          send_push create_push prepare_data message
        end

        private
        def prepare_data(message)
          { message: message }
        end

        def create_push(data)
          Parse::Push.new(data, CHANNEL_NAME).tap do |push|
            push.type = self::TYPE
          end
        end

        def send_push(push)
          push.save
        end
      end

      def self.included(other)
        other.extend(ClassMethods)
      end
    end
  end
end
