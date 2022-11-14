# frozen_string_literal: true

RSpec.describe DatastoreApi::Errors do
  subject { Class.new { extend DatastoreApi::Errors } }

  describe '#raise_error!' do
    let(:dummy_body) { OpenStruct.new({ 'body' => 'foobar' }) }
    let(:expected_msg) { dummy_body.to_h.merge(http_code: status).to_s }

    context 'BadRequest error' do
      let(:status) { 400 }

      it 'raises the exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::BadRequest, expected_msg)
      end
    end

    context 'Unauthorized error' do
      let(:status) { 401 }

      it 'raises the exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::Unauthorized, expected_msg)
      end
    end

    context 'NotFoundError error' do
      let(:status) { 404 }

      it 'raises the exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::NotFoundError, expected_msg)
      end
    end

    context 'InvalidRequest error' do
      let(:status) { 422 }

      it 'raises the exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::InvalidRequest, expected_msg)
      end
    end

    context 'ServerError error' do
      let(:status) { 500 }

      it 'raises the exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::ServerError, expected_msg)
      end
    end

    context 'Any other status code' do
      let(:status) { 502 }

      it 'raises a generic ApiError exception' do
        expect {
          subject.raise_error!(dummy_body, status)
        }.to raise_error(DatastoreApi::Errors::ApiError, expected_msg)
      end
    end
  end

  context 'Error subclasses' do
    it 'ApiError is a subclass of StandardError' do
      expect(DatastoreApi::Errors::ApiError).to be < StandardError
    end

    it 'ClientError is a subclass of ApiError' do
      expect(DatastoreApi::Errors::ClientError).to be < DatastoreApi::Errors::ApiError
    end

    it 'ServerError is a subclass of ApiError' do
      expect(DatastoreApi::Errors::ServerError).to be < DatastoreApi::Errors::ApiError
    end

    it 'ConnectionError is a subclass of ApiError' do
      expect(DatastoreApi::Errors::ConnectionError).to be < DatastoreApi::Errors::ApiError
    end
  end
end
