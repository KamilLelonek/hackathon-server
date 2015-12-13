describe Braintree::Controllers::SubscriptionsController, type: :controller do
  let(:customer_id) { Braintree::Services::CreateCustomer.({})[:customer_id] }
  let(:payment_method_token) do
    Braintree::Services::AssignMethodNonce.({
      id:                   customer_id,
      payment_method_nonce: 'fake-valid-nonce'
    })[:payment_method_token]
  end
  let(:params) do
    { payment_method_token: payment_method_token }
  end

  context '#create' do
    specify do
      bill_subscription
      expect_subscription_billed
    end

    def bill_subscription
      xhr :post, :create, params
      expect(json_response)
        .to match('subscription_id' => a_string_matching(/\w+/))
    end

    def expect_subscription_billed
      xhr :get, :show, { id: json_response['subscription_id'] }
      expect(json_response)
        .to match('subscribed' => true)
    end

    context 'invalid subscription' do
      it 'should not bill a subscription with invalid subscription method nonce' do
        xhr :post, :create, params.merge({ payment_method_token: 'invalid' })
    
        expect(response).not_to be_ok
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
