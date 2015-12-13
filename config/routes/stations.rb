scope module: :stations do
  resources :stations,
            only: [:index, :show]
end
