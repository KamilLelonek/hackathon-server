module Braintree
  module Services
    module PayForTransaction
      Error = Class.new(StandardError)

      class << self
        def call(params)
          {
            transaction_id: payment_id(
                              params[:amount],
                              params[:payment_method_nonce],
                              params[:customer_id],
                            )
          }
        end

        private
        def payment_id(amount, payment_method_nonce, customer_id)
          create_payment(amount, payment_method_nonce, customer_id).id
        end

        def create_payment(amount, payment_method_nonce, customer_id)
          Braintree::Transaction.sale!(
            amount:               amount,
            payment_method_nonce: payment_method_nonce,
            customer_id:          customer_id,
          )
        rescue Braintree::ValidationsFailed => e
          fail Error, e
        end
      end
    end
  end
end
