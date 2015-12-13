RSpec.describe RootController, type: :controller do
  it 'has success respnse with json type' do
    get :index
    expect(response).to be_success
    expect(response).to have_http_status :ok
    expect(response.content_type).to eq 'application/json'
  end

  it 'routes / to root#index' do
    expect(get: '/').to route_to(
                            controller: 'root',
                            action:     'index',
                        )
  end

  it 'renders API urls' do
    xhr :get, :index
    expect(response.body).to be_json_eql current_api
  end

  it 'provides routable paths' do
    expect_to_have_base_routes
    expect_to_have_pusher_routes
    expect_to_have_twilio_routes
    expect_to_have_braintree_routes
    expect_to_have_users_routes
    expect_to_have_stations_routes
    expect_to_have_accidents_routes
  end

  private
  def current_api
    {
        root:                 "#{request.url}",
        api:                  "#{request.url}api",
        'twilio-token':       "#{request.url}twilio/token",
        'braintree-token':    "#{request.url}braintree/customers/:id/token",
        subscription:         "#{request.url}braintree/subscriptions/:id",
        payment:              "#{request.url}braintree/payments/:id",
        users:                "#{request.url}users",
        user:                 "#{request.url}users/:id",
        stations:             "#{request.url}stations",
        station:              "#{request.url}stations/:id",
        accidents:            "#{request.url}accidents",
        'accidents-heat-map': "#{request.url}accidents/heat-map",
        accident:             "#{request.url}accidents/:id",
    }.to_json
  end

  def expect_to_have_base_routes
    expect(get: '/').to be_routable
  end

  def expect_to_have_twilio_routes
    expect(get:  '/twilio/token').to be_routable
    expect(post: '/twilio/sms')  .to be_routable
    expect(post: '/twilio/voice').to be_routable
  end

  def expect_to_have_braintree_routes
    expect(get:  '/braintree/customers/:id/token').to be_routable
    expect(post: '/braintree/subscriptions')      .to be_routable
    expect(get:  '/braintree/subscriptions/:id')  .to be_routable
    expect(post: '/braintree/payments')           .to be_routable
    expect(get:  '/braintree/payments/:id')       .to be_routable
  end

  def expect_to_have_users_routes
    expect(get:  '/users')    .to be_routable
    expect(post: '/users')    .to be_routable
    expect(get:  '/users/:id').to be_routable
    expect(put:  '/users/:id').to be_routable
  end

  def expect_to_have_pusher_routes
    expect(post: '/pusher/push').to be_routable
  end

  def expect_to_have_stations_routes
    expect(get: '/stations')    .to be_routable
    expect(get: '/stations/:id').to be_routable
  end

  def expect_to_have_accidents_routes
    expect(get:  '/accidents')         .to be_routable
    expect(get:  '/accidents/heat-map').to be_routable
    expect(post: '/accidents')         .to be_routable
    expect(get:  '/accidents/:id')     .to be_routable
    expect(put:  '/accidents/:id')     .to be_routable
  end
end
