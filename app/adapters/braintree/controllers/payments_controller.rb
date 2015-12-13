module Braintree
  module Controllers
    class PaymentsController < ApplicationController
      def show(id)
        render_json(paid: Braintree::Specifications::Paid.(id))
      end

      def create
        render_json Braintree::Services::PayForTransaction.(params)
      rescue Braintree::Services::PayForTransaction::Error => e
        render_error e.message
      end
    end
  end
end
