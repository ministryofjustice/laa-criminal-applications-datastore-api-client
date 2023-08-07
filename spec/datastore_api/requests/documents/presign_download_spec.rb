# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Documents::PresignDownload do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, put: {}) }

  let(:args) {
    { object_key: '123/payslip.pdf', expires_in: 15 }
  }

  describe '#action' do
    it { expect(subject.action).to eq('presign_download') }
  end

  describe '#object_key' do
    it { expect(subject.object_key).to eq(args[:object_key]) }
  end

  describe '.new' do
    let(:args) { { object_key: nil } }

    it 'raises an error if the object_key is nil' do
      expect {
        subject.call
      }.to raise_error(ArgumentError, '`object_key` cannot be nil')
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
        expect(http_client).to receive(:put).with(
          '/documents/presign_download', { object_key: '123/payslip.pdf', s3_opts: { expires_in: 15 } }
        )

        subject.call
      end
    end
  end
end
