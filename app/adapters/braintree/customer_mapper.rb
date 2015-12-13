module Braintree
  module CustomerMapper
    class << self
      def call(customer)
        Braintree::CustomerEntity.new(
          id:         customer.id,
          first_name: customer.first_name,
          last_name:  customer.last_name,
          phone:      customer.phone,
          email:      customer.email,
        )
      end
    end
  end
end
