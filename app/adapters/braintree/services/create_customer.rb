module Braintree
  module Services
    module CreateCustomer
      Error = Class.new(StandardError)

      class << self
        def call(params)
          { customer_id: created_customer_id(customer_params(params)) }
        end

        private
        def created_customer_id(customer_params)
          create_customer(customer_params).id
        end

        def create_customer(customer_params)
          Braintree::Customer.create! customer_params
        rescue Braintree::ValidationsFailed => e
          fail Error, e
        end

        def customer_params(params)
          params.slice(
            *%i(
              id
              first_name
              last_name
              email
              phone
            )
          )
        end
      end
    end
  end
end
