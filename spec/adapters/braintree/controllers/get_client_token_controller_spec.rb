describe Braintree::Controllers::GetClientTokenController, type: :controller do
  context 'valid ID' do
    let(:customer_id) { Braintree::Services::CreateCustomer.({})[:customer_id] }
    
    it 'should generate a valid token when user ID is provided' do
      xhr :get, :call, { id: customer_id }
      expect(json_response)
        .to match('token' => a_string_matching(/\w+/))
    end
  end

  context 'invalid ID' do
    it 'should return an error for an invalid user ID' do
      xhr :get, :call, { id: 123 }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:not_found)
    end
  end
end
