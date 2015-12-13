RSpec.describe Pusher::Controllers::SendPushController, type: :controller do
  let(:channel_name) { Pusher::Services::BroadcastEvent::CHANNEL_NAME }
  
  describe 'general message' do
    let(:event) { 'event' }

    it 'should route any event without a message' do
      expect(::Pusher)
        .to receive(:trigger)
        .with(channel_name, event, {})

      xhr :post, :call, {event: event}
    end

    let(:message) { { param: 'param' } }
    it 'should route any event without a message' do
      expect(::Pusher)
        .to receive(:trigger)
        .with(channel_name, event, message)

      xhr :post, :call, {event: event}.merge(message)
    end
  end
end
