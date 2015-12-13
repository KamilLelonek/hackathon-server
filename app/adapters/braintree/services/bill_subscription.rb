module Braintree
  module Services
    module BillSubscription
      SUBSCRIPTION_PLAN_ID = 'battlehack'

      Error = Class.new(StandardError)

      class << self
        def call(payment_method_token)
          { subscription_id: subscription_id(payment_method_token) }
        end

        private
        def subscription_id(payment_method_token)
          create_subscription(payment_method_token).id
        end

        def create_subscription(payment_method_token)
          Braintree::Subscription.create!(
            plan_id:              SUBSCRIPTION_PLAN_ID,
            payment_method_token: payment_method_token
          )
        rescue Braintree::ValidationsFailed => e
          fail Error, e
        end
      end
    end
  end
end
