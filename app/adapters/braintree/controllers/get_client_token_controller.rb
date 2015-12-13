module Braintree
  module Controllers
    class GetClientTokenController < ApplicationController
      def call(id)
        render_json Braintree::Services::GenerateClientToken.(id)
      rescue Braintree::Services::GenerateClientToken::Error => e
        render_error e.message, :not_found
      end
    end
  end
end
