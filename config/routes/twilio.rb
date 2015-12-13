namespace :twilio do
  scope module: :controllers do
    get  :token, to: 'get_token#call'
    post :sms,   to: 'send_sms#call'
    post :voice, to: 'dial_number#call'
  end
end
