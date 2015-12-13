module Braintree
  module Specifications
    module Subscribed
      class << self
        def call(id)
          Braintree::Subscription.find(id)
          true
        rescue Braintree::NotFoundError, ArgumentError
          false
        end
      end
    end
  end
end
