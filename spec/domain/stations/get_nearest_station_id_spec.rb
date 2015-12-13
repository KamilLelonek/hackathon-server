RSpec.describe Stations::Queries::GetNearestStationId do

=begin
  +      +
  |
  |
  |
  +------+

=end

  let(:stations_in_memory_repository) do
    DataStruct.new(
      all: [
             DataStruct.new(id: 1, lat: 0,  lng: 0),
             DataStruct.new(id: 2, lat: 0,  lng: 50),
             DataStruct.new(id: 3, lat: 50, lng: 0),
             DataStruct.new(id: 4, lat: 50, lng: 50),
           ]
    )
  end

  it 'should find the nearest station ID' do
    expect_to_find_nearest_station_id(1,  1,  1)
    expect_to_find_nearest_station_id(1,  49, 2)
    expect_to_find_nearest_station_id(49, 1,  3)
    expect_to_find_nearest_station_id(49, 49, 4)
  end

  def expect_to_find_nearest_station_id(lat, lng, id)
    expect(
      described_class.(lat, lng, repository: stations_in_memory_repository)
    ).to eq id
  end
end
