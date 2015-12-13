scope module: :braintree do
  scope module: :controllers do
    resources :users,
              only:       [:create, :index, :update, :show],
              controller: :customers
  end
end

namespace :braintree do
  scope module: :controllers do
    get  'customers/:id/token', to: 'get_client_token#call'

    resources :subscriptions, only: [:create, :show]
    resources :payments,      only: [:create, :show]
  end
end
