# Rails.application.routes.routes.to_a

class RootController < ApplicationController
  def index
    render_json(
      root:                 root_url,
      api:                  "#{root_url}api",
      'twilio-token':       "#{root_url}twilio/token",
      'braintree-token':    "#{root_url}braintree/customers/:id/token",
      subscription:         "#{root_url}braintree/subscriptions/:id",
      payment:              "#{root_url}braintree/payments/:id",
      users:                "#{root_url}users",
      user:                 "#{root_url}users/:id",
      stations:             "#{root_url}stations",
      station:              "#{root_url}stations/:id",
      accidents:            "#{root_url}accidents",
      'accidents-heat-map': "#{root_url}accidents/heat-map",
      accident:             "#{root_url}accidents/:id",
    )
  end
end
