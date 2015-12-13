module Pusher
  module Controllers
    class SendPushController < ApplicationController
      def call
        Pusher::Services::BroadcastEvent.(params)
        head :no_content
      end
    end
  end
end
