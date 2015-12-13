module Braintree
  module Controllers
    class CustomersController < ApplicationController
      def create
        render_json Braintree::Services::CreateCustomer.(params)
      end

      def index
        render_json Braintree::Queries::GetAllCustomers.()
      end

      def update(id, payment_method_nonce)
        render_json Braintree::Services::AssignMethodNonce.(id, payment_method_nonce)
      rescue Braintree::Services::AssignMethodNonce::NotFound => e
        render_error e.message, :not_found
      rescue Braintree::Services::AssignMethodNonce::InvalidMethodNonce => e
        render_error e.message
      end

      def show(id)
        render_json Braintree::Queries::GetCustomerById.(id)
      rescue Braintree::Queries::GetCustomerById::Error => e
        render_error e.message
      rescue Braintree::Queries::GetCustomerById::NotFound => e
        render_error e.message, :not_found
      end
    end
  end
end
