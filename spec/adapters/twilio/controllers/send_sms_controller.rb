RSpec.describe Twilio::Controllers::SendSmsController, type: :controller do
  let(:phone_no) { '+48 500 600 700' }
  let(:message)  { 'Example body' }

  it 'should send an SMS' do
    xhr :post, :call, { phone_number: phone_no, message: message }
    expect(response).to be_ok
    expect(response).to have_http_status(:ok)
  end

  it 'should not send an SMS for an invalid phone number' do
    expect(Twilio::Common::Constants).to receive(:phone_number).and_return('+15005550001')

    xhr :post, :call, { phone_number: phone_no, message: message }
    expect(response).not_to be_ok
    expect(response).to have_http_status(:bad_request)
    expect(json_response)
      .to match('error' => a_string_matching(/\w+/))
  end
end
