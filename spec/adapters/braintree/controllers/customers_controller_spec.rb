describe Braintree::Controllers::CustomersController, type: :controller do
  let(:first_name) { 'Joe' }
  let(:last_name)  { 'Nash' }
  let(:email)      { 'joe.nash@braintreepayments.com' }
  let(:phone)      { '+44(0)7730 605 305' }
  let(:params) do
    { first_name: first_name, last_name: last_name, email: email, phone: phone }
  end

  context '#create' do
    it 'should create a new user and return their id' do
      xhr :post, :create, params
      expect(json_response)
        .to match('customer_id' => a_string_matching(/\w+/))
    end
  end

  context '#show' do
    it 'should render all users' do
      xhr :post, :create, params
      xhr :get, :index

      expect(json_response).to have_at_least(1).item
    end
  end

  context '#index' do
    it 'should find a user by their id' do
      xhr :post, :create, params
      xhr :get, :show, { id: json_response['customer_id'] }

      match_customer(json_response)
    end

    it 'should not find a user with an invalid id' do
      xhr :get, :show, { id: 123 }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:not_found)
    end
  end

  context '#update' do
    let(:customer_id) do
      xhr :post, :create, params
      json_response['customer_id']
    end

    let(:payment_method_nonce) { 'fake-valid-nonce' }

    it 'should update a customer with payment_method_nonce' do
      xhr :put, :update, { id: customer_id, payment_method_nonce: payment_method_nonce }

      expect(json_response)
        .to match('payment_method_token' => a_string_matching(/\w+/))
    end

    it 'should not update an inexisting customer' do
      xhr :put, :update, { id: 123 }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:not_found)
    end

    it 'should not update a customer with invalid payment method nonce' do
      xhr :put, :update, { id: customer_id, payment_method_nonce: 'invalid' }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:bad_request)
    end
  end

  def match_customer(customer)
    expect(customer['first_name']).to eq first_name
    expect(customer['last_name']) .to eq last_name
    expect(customer['email'])     .to eq email
    expect(customer['phone'])     .to eq phone
    expect(customer['fax'])       .to be_nil
  end
end
