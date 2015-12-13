module Stations
  module StationRepository
    NotFound = Class.new(StandardError)

    DATA = [
      DataStruct.new(
        id:  'STA001',
        lat: 37.396638,
        lng: -121.902478
      ),
      DataStruct.new(
        id:  'STA002',
        lat: 37.446638,
        lng: -121.965478
      ),
      DataStruct.new(
        id:  'STA003',
        lat: 37.366638,
        lng: -121.982478
      ),
      DataStruct.new(
        id:  'STA004',
        lat: 37.316638,
        lng: -121.922478
      ),
      DataStruct.new(
        id:  'STA005',
        lat: 37.356638,
        lng: -121.837478
      ),
      DataStruct.new(
        id:  'STA006',
        lat: 37.296638,
        lng: -122.022478
      ),
      DataStruct.new(
        id:  'STA007',
        lat: 37.406638,
        lng: -122.056478
      ),
      DataStruct.new(
        id:  'STA008',
        lat: 37.336638,
        lng: -122.076478
      ),
      DataStruct.new(
        id:  'STA009',
        lat: 37.286638,
        lng: -121.836478
      ),
    ]

    class << self
      def all
        DATA
      end

      def find(id)
        DATA.find(not_found_error(id)) do |station|
          station.id == id
        end
      end

      private
      def not_found_error(id)
        -> { raise NotFound, "Station with the given id: '#{id}' not found." }
      end
    end
  end
end
