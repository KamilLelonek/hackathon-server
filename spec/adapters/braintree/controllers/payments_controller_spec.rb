describe Braintree::Controllers::PaymentsController, type: :controller do
  let(:customer_id) { Braintree::Services::CreateCustomer.({})[:customer_id] }
  let(:params) do
    { amount: 100_000, payment_method_nonce: 'fake-valid-nonce', customer_id: customer_id }
  end

  context '#create' do
    it 'should pay for a service' do
      pay_for_transaction
      expect_transaction_paid
    end

    def pay_for_transaction
      xhr :post, :create, params
      expect(json_response)
        .to match('transaction_id' => a_string_matching(/\w+/))
    end

    def expect_transaction_paid
      xhr :get, :show, { id: json_response['transaction_id'] }
      expect(json_response)
        .to match('paid' => true)
    end

    context 'invalid payment' do
      it 'should not pay for a service with invalid payment method nonce' do
        xhr :post, :create, params.merge({ payment_method_nonce: 'fake-valid-no-indicators-noncee' })

        expect(response).not_to be_ok
        expect(response).to have_http_status(:bad_request)
      end

      it 'should not pay for a service with invalid amount' do
        xhr :post, :create, params.merge({ amount: 0 })

        expect(response).not_to be_ok
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
