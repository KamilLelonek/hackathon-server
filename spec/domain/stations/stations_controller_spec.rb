RSpec.describe Stations::StationsController, type: :controller do
  context '#index' do
    it 'should render all stations' do
      xhr :get, :index

      expect(json_response).to have_at_least(1).item
      expect(response.body).to be_json_eql Stations::StationRepository.all.to_json
    end
  end

  context '#show' do
    let(:station_id) { Stations::StationRepository.all.sample.id }

    specify 'valid id' do
      xhr :get, :show, { id: station_id }
      expect(json_response['id']).to eq station_id
    end

    specify 'invalid id' do
      xhr :get, :show, { id: 123 }
      expect(response).not_to be_ok
      expect(response).to have_http_status(:not_found)
    end
  end
end
