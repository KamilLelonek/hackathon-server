module Accidents
  module Services
    module CreateAccident
      InvalidParams = Class.new(StandardError)

      class << self
        def call(params, repository: Accidents::AccidentRepository)
          create_accident(
            repository,
            params_with_station_id(params)
          )
        rescue ActiveRecord::StatementInvalid, ArgumentError => e
          fail InvalidParams, e.message
        end

        private
        def params_with_station_id(params)
          create_params(params).merge({ station_id: nearest_station_id(params) })
        end

        def nearest_station_id(params)
          Stations::Queries::GetNearestStationId.(*location(params))
        end

        def location(params)
          [
            Float(params[:lat]),
            Float(params[:lng]),
          ]
        end

        def create_accident(repository, params)
          repository.create params
        end

        def create_params(params)
          params.permit(
            :user_id,
            :station_id,
            :kind,
          )
        end
      end
    end
  end
end
