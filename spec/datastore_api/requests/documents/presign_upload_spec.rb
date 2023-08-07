# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Documents::PresignUpload do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, put: {}) }

  let(:args) {
    { usn: 123, expires_in: 15 }
  }

  describe '#action' do
    it { expect(subject.action).to eq('presign_upload') }
  end

  describe '#object_key' do
    it 'is composed of the USN and 10 random alphanumeric chars, joined by forward slash' do
      expect(subject.object_key).to match(/\A123\/[[:alnum:]]{10}\z/)
    end

    it 'does not change `object_key` while using the same instance' do
      expect(subject.object_key).to eq(subject.object_key)
    end
  end

  describe '.new' do
    context 'usn is not provided' do
      let(:args) { super().merge(usn: nil) }

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
      expect(subject.call).to be_a(DatastoreApi::Responses::DocumentResult)
    end

    context 'endpoint' do
      before do
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('abcdef1234')
      end

      it 'uses the correct endpoint' do
        expect(http_client).to receive(:put).with(
          '/documents/presign_upload', { object_key: '123/abcdef1234', s3_opts: { expires_in: 15 } }
        )

        subject.call
      end
    end
  end
end
