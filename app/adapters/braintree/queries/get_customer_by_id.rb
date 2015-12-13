module Braintree
  module Queries
    module GetCustomerById
      Error    = Class.new(StandardError)
      NotFound = Class.new(StandardError)

      class << self
        def call(id)
          map_customer get_customer_by_id(id)
        end

        private
        def map_customer(customer)
          Braintree::CustomerMapper.(customer)
        end

        private
        def get_customer_by_id(customer_id)
          Braintree::Customer.find(customer_id)
        rescue ArgumentError => e
          fail Error, e.message
        rescue Braintree::NotFoundError => e
          fail NotFound, e.message
        end
      end
    end
  end
end
