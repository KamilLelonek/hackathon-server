scope module: :accidents do
  resources :accidents,
            only: [:index, :show, :create, :update] do
    collection do
      get 'heat-map'
    end
  end
end
