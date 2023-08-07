# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Documents::Upload do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, post: {}) }

  let(:args) {
    { usn: 123, file: file, filename: 'test.pdf' }
  }

  let(:file) { instance_double(File) }

  describe '.new' do
    context 'usn is not provided' do
      let(:args) { super().merge(usn: nil) }

      it 'raises an error if the usn is nil' do
        expect {
          subject.call
        }.to raise_error(ArgumentError, '`usn` cannot be nil')
      end
    end

    context 'file is not provided' do
      let(:file) { nil }

      it 'raises an error if the file is nil' do
        expect {
          subject.call
        }.to raise_error(ArgumentError, '`file` cannot be nil')
      end
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in an DocumentResult' do
      expect(subject.call).to be_a(DatastoreApi::Responses::DocumentResult)
    end

    context 'endpoint' do
      it 'uses the correct endpoint' do
        expect(http_client).to receive(:post).with(
          '/documents/123', { file: file, payload: "{\"filename\":\"test.pdf\"}" }, { multipart: true }
        )

        subject.call
      end
    end
  end
end
