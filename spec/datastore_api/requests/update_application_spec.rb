# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::UpdateApplication do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, put: {}) }

  let(:args) do
    { application_id: 'xyz-123', payload: payload }
  end

  let(:payload) do
    { status: 'returned' }
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in an ApplicationResult' do
      expect(subject.call).to be_a(DatastoreApi::Responses::ApplicationResult)
    end

    context 'endpoint' do
      it 'puts to the correct endpoint' do
        expect(http_client).to receive(:put).with('/applications/xyz-123', any_args)
        subject.call
      end
    end

    context 'payload' do
      it 'puts the correct payload' do
        expect(http_client).to receive(:put).with(any_args, payload)
        subject.call
      end
    end
  end
end
