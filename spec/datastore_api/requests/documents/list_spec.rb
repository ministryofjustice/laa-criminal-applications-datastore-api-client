# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Documents::List do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, get: [{}]) }

  let(:args) {
    { usn: 123 }
  }

  describe '.new' do
    context 'usn is not provided' do
      let(:args) { { usn: nil } }

      it 'raises an error if the usn is nil' do
        expect {
          subject.call
        }.to raise_error(ArgumentError, '`usn` cannot be nil')
      end
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in an DocumentResult' do
      expect(subject.call).to all(be_an(DatastoreApi::Responses::DocumentResult))
    end

    context 'endpoint' do
      it 'uses the correct endpoint' do
        expect(http_client).to receive(:get).with('/documents/123')
        subject.call
      end
    end
  end
end
