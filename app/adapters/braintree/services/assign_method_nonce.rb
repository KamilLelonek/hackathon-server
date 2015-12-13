module Braintree
  module Services
    module AssignMethodNonce
      NotFound           = Class.new(StandardError)
      InvalidMethodNonce = Class.new(StandardError)

      class << self
        def call(id, payment_method_nonce)
          {
            payment_method_token: payment_method_token_for_customer(id, payment_method_nonce)
          }
        end

        def payment_method_token_for_customer(customer_id, payment_method_nonce)
          payment_method_token update_customer(customer_id, payment_method_nonce)
        end

        def payment_method_token(customer)
          customer.payment_methods.first.token
        end

        private
        def update_customer(customer_id, payment_method_nonce)
          Braintree::Customer.update!(
            customer_id,
            payment_method_nonce: payment_method_nonce,
          )
        rescue Braintree::NotFoundError => e
          fail NotFound, e.message
        rescue Braintree::ValidationsFailed => e
          fail InvalidMethodNonce, e.message
        end
      end
    end
  end
end
