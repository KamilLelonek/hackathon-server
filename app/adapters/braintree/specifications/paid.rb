module Braintree
  module Specifications
    module Paid
      class << self
        def call(id)
          Braintree::Transaction.find(id)
          true
        rescue Braintree::NotFoundError, ArgumentError
          false
        end
      end
    end
  end
end
