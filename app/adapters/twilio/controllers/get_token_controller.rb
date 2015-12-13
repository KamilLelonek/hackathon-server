module Twilio
  module Controllers
    class GetTokenController < ApplicationController
      def call
        render_json Twilio::Services::GenerateToken.()
      end
    end
  end
end
