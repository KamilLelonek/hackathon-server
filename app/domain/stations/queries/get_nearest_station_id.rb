module Stations
  module Queries
    module GetNearestStationId
      class << self
        def call(lat, lng, repository: Stations::StationRepository)
          select_nearest_station(
            lat,
            lng,
            repository.all
          ).id
        end

        private
        def select_nearest_station(lat, lng, all_stations)
          all_stations.min_by do |station|
            distance(lat, lng, station.lat, station.lng)
          end
        end

        def distance(lat, lng, station_lat, station_lng)
          sum_of_squares(
            length(station_lat, lat),
            length(station_lng, lng)
          )
        end

        def length(coordinate1, coordinate2)
          coordinate1 - coordinate2
        end

        def sum_of_squares(val1, val2)
          square(val1) + square(val2)
        end

        def square(value)
          value ** 2
        end
      end
    end
  end
end
