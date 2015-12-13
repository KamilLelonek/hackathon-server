module Stations
  class StationsController < ApplicationController
    def index
      render_json Stations::Queries::GetAllStations.()
    end

    def show(id:)
      render_json Stations::Queries::GetStationById.(id)
    rescue Stations::StationRepository::NotFound => e
      render_error e.message, :not_found
    end
  end
end
