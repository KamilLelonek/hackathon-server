RSpec.describe Twilio::Controllers::GetTokenController, type: :controller do
  it 'should generate twilio token' do
    xhr :get, :call
    expect(json_response)
      .to match('token' => a_string_matching(/\w+/))
  end
end
