namespace :pusher do
  scope module: :controllers do
    post :push, to: 'send_push#call'
  end
end
