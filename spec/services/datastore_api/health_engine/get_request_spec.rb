# frozen_string_literal: true

require_relative '../../../../engines/app/services/datastore_api/health_engine/get_request'

RSpec.describe DatastoreApi::HealthEngine::GetRequest do
  let(:api_root) { 'http://datastore-service-test' }

  before do
    allow(DatastoreApi.configuration).to receive(:api_root).and_return(api_root)
  end

  describe '.call' do
    subject { described_class.call(:action) }

    let(:endpoint) { "#{api_root}/action" }

    context 'for a successful request' do
      before do
        allow(Faraday).to receive(:get).with(endpoint).and_return(response)
      end

      context 'with a successful response' do
        let(:response) { double(success?: true, body: '{}') }

        it 'has a response' do
          expect(subject.response).to eq({})
        end

        it 'has a status' do
          expect(subject.status).to eq(:ok)
        end
      end

      context 'with a failure response' do
        let(:response) { double(success?: false, body: '{}') }

        it 'has a response' do
          expect(subject.response).to eq({})
        end

        it 'has a status' do
          expect(subject.status).to eq(:service_unavailable)
        end
      end
    end

    context 'for an unsuccessful request' do
      before do
        allow(Faraday).to receive(:get).with(endpoint).and_raise(StandardError.new('boom!'))
      end

      it 'has a response' do
        expect(subject.response).to eq({ error: 'boom!' })
      end

      it 'has a status' do
        expect(subject.status).to eq(:service_unavailable)
      end
    end
  end
end
