# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Healthcheck do
  subject { described_class.new }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, get: {}) }

  describe '.call' do
    it 'delegates to the instance' do
      expect(described_class).to receive(:new).and_return(double.as_null_object)
      described_class.call
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in an HealthcheckResult' do
      expect(subject.call).to be_a(DatastoreApi::Responses::HealthcheckResult)
    end

    context 'endpoint' do
      it 'gets the correct endpoint' do
        expect(http_client).to receive(:get).with('/health')
        subject.call
      end
    end
  end
end
