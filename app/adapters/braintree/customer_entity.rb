module Braintree
  class CustomerEntity
    include Virtus.model

    attribute :id,         String
    attribute :first_name, String
    attribute :last_name,  String
    attribute :phone,      String
    attribute :email,      String
    end
end
