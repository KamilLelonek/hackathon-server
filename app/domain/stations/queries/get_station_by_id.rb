module Stations
  module Queries
    module GetStationById
      class << self
        def call(id, repository: Stations::StationRepository)
          repository.find id
        end
      end
    end
  end
end
