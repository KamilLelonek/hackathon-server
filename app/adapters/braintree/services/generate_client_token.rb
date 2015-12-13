module Braintree
  module Services
    module GenerateClientToken
      Error = Class.new(StandardError)

      class << self
        def call(id)
          { token: generate_token(id) }
        end

        private
        def generate_token(customer_id)
          Braintree::ClientToken
            .generate(customer_id: customer_id)
        rescue ArgumentError => e
          fail Error, e.message
        end
      end
    end
  end
end
