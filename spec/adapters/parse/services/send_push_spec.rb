RSpec.describe Parse::Services::SendPush do
  let(:message) { 'message' }

  it 'should send iOS push' do
    expect_push_to_be_sent('ios')
    Parse::Services::SendIosPush.(message)
  end

  it 'should send Android push' do
    expect_push_to_be_sent('android')
    Parse::Services::SendAndroidPush.(message)
  end

  def expect_push_to_be_sent(device)
    expect(Parse.client)
      .to receive(:request)
      .with(
          '/1/push',
          :post,
          {
            data:    {
              message: message
            },
            channel: Parse::Services::SendPush::CHANNEL_NAME,
            type:    device
          }.to_json,
          nil
      )
  end
end
