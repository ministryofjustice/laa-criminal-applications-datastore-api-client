# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::Documents::PresignUpload do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, put: {}) }

  let(:args) {
    { usn: 123, application_id: 'xyz', filename: 'payslip.pdf', expires_in: 15 }
  }

  describe '#action' do
    it { expect(subject.action).to eq('presign_upload') }
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

    context 'application_id is not provided' do
      let(:args) { super().merge(application_id: nil) }

      it 'raises an error if the application_id is nil' do
        expect {
          subject.call
        }.to raise_error(ArgumentError, '`application_id` cannot be nil')
      end
    end

    context 'filename is not provided' do
      let(:args) { super().merge(filename: nil) }

      it 'raises an error if the filename is nil' do
        expect {
          subject.call
        }.to raise_error(ArgumentError, '`filename` cannot be nil')
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
        expect(http_client).to receive(:put).with(
          '/documents/presign_upload', { object_key: '123/xyz/payslip.pdf', s3_opts: { expires_in: 15 } }
        )

        subject.call
      end
    end
  end
end
