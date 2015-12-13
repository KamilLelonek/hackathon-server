RSpec.describe Twilio::Controllers::DialNumberController, type: :controller do
  let(:phone_no) { '+48 500 600 700' }

  it 'should generate TwiML call response' do
    xhr :post, :call, { phone_number: phone_no }
    expect(xml_response['Response']['Dial']).to eq phone_no
  end
end
