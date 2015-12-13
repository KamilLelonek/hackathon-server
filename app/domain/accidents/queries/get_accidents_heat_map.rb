module Accidents
  module Queries
    module GetAccidentsHeatMap
      class << self
        def call(repository: Accidents::AccidentRepository)
          repository.select(:lat, :lng)
        end
      end
    end
  end
end
