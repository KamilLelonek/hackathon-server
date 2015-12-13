RSpec.describe Accidents::AccidentsController, type: :controller do
  let(:user_id) { Braintree::Services::CreateCustomer.({ phone: '+48 530 855 875' })[:customer_id] }

  let(:params_create) do
    {
      user_id: user_id,
      lat:     37.376638,
      lng:     -121.922478,
      kind:    'flic'
    }
  end

  context '#create' do
    it 'should create a new accident and push a corresponding event' do
      expect_push_will_be_sent
      create_accident
      expect_accident_created
    end

    def expect_push_will_be_sent
      expect(Pusher)
        .to receive(:trigger)
              .with(
                'battlehack-finals-2015',
                'accident_happened',
                hash_including(params_create)
              )
              .once
    end

    def create_accident
      xhr :post, :create, params_create
    end

    def expect_accident_created
      xhr :get, :index
      json_response.first.tap do |accident|
        expect(accident).to include params_create.stringify_keys
        expect(accident['drone_id']).to be_nil
        expect(accident['id']).not_to be_nil
        expect(accident['station_id']).not_to be_nil
        expect(accident['status']).to eq Accidents::Accident.statuses.keys.first
      end
    end

    context 'invalid params' do
      it 'should fali for invalid kind' do
        fail_with_invalid_params({ kind: 'invalid' })
      end

      it 'should fali for invalid location' do
        fail_with_invalid_params({ lat: 'invalid' })
      end

      it 'should fali for invalid user id' do
        fail_with_invalid_params({ user_id: nil })
      end

      def fail_with_invalid_params(invalid_params)
        xhr :post, :create, params_create.merge(invalid_params)
        expect(response).not_to be_ok
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context '#update' do
    let(:accident_id) do
      xhr :post, :create, params_create
      json_response['id']
    end

    let(:params_update) do
      {
        id:       accident_id,
        drone_id: 'DRN001',
      }
    end

    it 'should update an existing accident and push a corresponding event' do
      expect_push_will_be_sent
      update_accident
      expect_accident_updated
    end

    def expect_push_will_be_sent
      expect(Pusher)
        .to receive(:trigger)
              .with(
                'battlehack-finals-2015',
                'dron_took_off',
                {
                  accident_id: accident_id,
                  drone_id:    params_update[:drone_id],
                }
              )
              .once
    end

    def update_accident
      xhr :put, :update, params_update
    end

    def expect_accident_updated
      xhr :get, :show, { id: accident_id }
      expect(json_response).to include params_update.stringify_keys
      expect(json_response['drone_id']).not_to be_nil
      expect(json_response['status']).to eq Accidents::Accident.statuses.keys.second
    end

    context 'invalid params' do
      it 'should fali for invalid id' do
        fail_with_invalid_params({ id: 'invalid' })
      end

      def fail_with_invalid_params(invalid_params)
        xhr :put, :update, params_update.merge(invalid_params)
        expect(response).not_to be_ok
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context '#show' do
    it 'should fail for invalid id' do
      xhr :get, :show, { id: 123 }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:not_found)
    end
  end

  context '#index' do
    it 'should return an empty array for no data in a database' do
      xhr :get, :index
      expect(json_response).to eq []
    end

    it 'should return accidents array' do
      xhr :post, :create, params_create
      xhr :get, :index
      expect(json_response).to have_exactly(1).item
      expect(json_response.first).to include params_create.except(:user_id).stringify_keys
    end
  end

  context '#index/heat-map' do
    it 'should not render heatmap for no accidents' do
      xhr :get, :heat_map
      expect(json_response).to eq []
    end

    it 'should render heatmap array' do
      xhr :post, :create, params_create
      xhr :get, :heat_map
      expect(json_response).to eq [{
                                     'lat' => params_create[:lat],
                                     'lng' => params_create[:lng],
                                   }]
    end
  end
end
