root 'root#index'

get 'api' => proc { [200, {}, [`rake routes`]] }