# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::CreateApplication do
  subject { described_class.new(payload: payload) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, post: {}) }

  let(:payload) do
    {
      id: '12345',
      status: 'submitted',
      client_details: { first_name: 'John', last_name: 'Doe' }
    }
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    context 'endpoint' do
      it 'posts to the correct endpoint' do
        expect(http_client).to receive(:post).with('/applications', any_args)
        subject.call
      end
    end

    context 'payload' do
      it 'posts the correct payload' do
        expect(http_client).to receive(:post).with(any_args, application: payload)
        subject.call
      end
    end
  end
end
