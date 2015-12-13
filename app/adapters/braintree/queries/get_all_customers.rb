module Braintree
  module Queries
    module GetAllCustomers
      class << self
        def call
          all_customers.map &customer_mapper
        end

        private
        def customer_mapper
          Braintree::CustomerMapper.method(:call)
        end

        def all_customers
          Braintree::Customer.all
        end
      end
    end
  end
end
