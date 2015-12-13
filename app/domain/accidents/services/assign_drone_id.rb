module Accidents
  module Services
    module AssignDroneId
      class << self
        def call(id, drone_id, repository: Accidents::AccidentRepository)
          repository.update(
            id,
            update_params(drone_id)
          )
        end

        private
        def update_params(drone_id)
          {
            drone_id: drone_id,
            status:   Accidents::Accident.statuses[:active],
          }
        end
      end
    end
  end
end
