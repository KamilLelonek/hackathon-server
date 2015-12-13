module Accidents
  module Queries
    module GetAllAccidents
      class << self
        def call(repository: Accidents::AccidentRepository)
          repository.all
        end
      end
    end
  end
end
