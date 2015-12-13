module Stations
  module Queries
    module GetAllStations
      class << self
        def call(repository: Stations::StationRepository)
          repository.all
        end
      end
    end
  end
end
