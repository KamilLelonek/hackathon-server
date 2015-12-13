module Accidents
  module AccidentRepository
    NotFound = Class.new(StandardError)

    class << self
      def all(adapter: Accidents::Accident)
        adapter.all
      end

      def one(accident_id, adapter: Accidents::Accident)
        adapter.find(accident_id)
      rescue ActiveRecord::RecordNotFound => e
        raise NotFound, e.message
      end

      def select(*keys, adapter: Accidents::Accident)
        adapter
          .pluck(*keys)
          .map do |lat, lng|
            { lat: lat, lng: lng }
          end
      end

      def update(id, params, adapter: Accidents::Accident)
        adapter.update(id, params)
      rescue ActiveRecord::RecordNotFound => e
        raise NotFound, e.message
      end

      def create(params, adapter: Accidents::Accident)
        adapter.create params
      end
    end
  end
end
