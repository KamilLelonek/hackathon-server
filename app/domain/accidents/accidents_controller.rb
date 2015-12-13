module Accidents
  class AccidentsController < ApplicationController
    def index
      render_json Accidents::Queries::GetAllAccidents.()
    end

    def show(id)
      render_json Accidents::Queries::GetAccidentById.(id)
    rescue Accidents::AccidentRepository::NotFound => e
      render_error e.message, :not_found
    end

    def heat_map
      render_json Accidents::Queries::GetAccidentsHeatMap.()
    end

    def create
      render_json(
        Accidents::Services::CreateAccident.(params).tap do |accident|
          Accidents::Services::PushAccidentCreated.(accident)
          Accidents::Services::SmsAccidentCreated.(accident)
        end
      )
    rescue Accidents::Services::CreateAccident::InvalidParams => e
      render_error e.message
    end

    def update(id, drone_id)
      render_json(
        Accidents::Services::AssignDroneId.(id, drone_id).tap do |accident|
          Accidents::Services::PushDroneAssigned.(accident)
        end
      )
    rescue Accidents::AccidentRepository::NotFound => e
      render_error e.message
    end
  end
end
