module Braintree
  module Controllers
    class SubscriptionsController < ApplicationController
      def show(id)
        render_json(subscribed: Braintree::Specifications::Subscribed.(id))
      end

      def create(payment_method_token)
        render_json Braintree::Services::BillSubscription.(payment_method_token)
      rescue Braintree::Services::BillSubscription::Error => e
        render_error e.message
      end
    end
  end
end
