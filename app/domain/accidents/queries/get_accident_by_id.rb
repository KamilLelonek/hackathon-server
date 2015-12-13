module Accidents
  module Queries
    module GetAccidentById
      class << self
        def call(id, repository: Accidents::AccidentRepository)
          repository.one(id)
        end
      end
    end
  end
end
