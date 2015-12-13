RSpec.describe Sendgrid::Services::ReceiveEmail do
  let(:subject) { 'subject' }
  let(:body)    { 'body' }
  let(:to)      { 'to@email.com' }
  let(:from)    { 'from@email.com' }
  let(:image)   { 'http://example.com/image.png' }
  let(:thumb)   { 'http://example.com/thumbnail.png' }

  let(:email) do
    OpenStruct.new(
      subject:     subject,
      body:        body,
      from:        { email: from },
      to:          [
                     { email: to },
                   ],
      attachments: [
                     File.open('spec/fixtures/logo.png')
                   ]
    )
  end

  it 'should send an email' do
    allow(Pusher).to receive(:trigger)

    described_class.new(email).call.tap do |result|
      expect(::Pusher)
        .to have_received(:trigger)
        .with(
          Pusher::Services::BroadcastEvent::CHANNEL_NAME,
          Sendgrid::Services::PushEmailReceived::EVENT,
          {
            subject:     subject,
            body:        body,
            from:        from,
            to:          [to],
            attachments: [
                           {
                             standard:  result.first[:standard],
                             thumbnail: result.first[:thumbnail],
                           }
                         ]
          }
        )
    end
  end
end
