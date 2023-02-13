# frozen_string_literal: true

RSpec.describe DatastoreApi::Configuration do
  let(:config) { DatastoreApi.configuration }

  describe '#logger' do
    context 'when no logger is specified' do
      it 'defaults to nil' do
        expect(config.logger).to be_nil
      end
    end

    context 'when an logger is specified' do
      let(:custom_value) { Object.new }

      before do
        DatastoreApi.configure { |config| config.logger = custom_value }
      end

      it 'returns configured value' do
        expect(config.logger).to eq(custom_value)
      end
    end
  end

  describe '#api_root' do
    context 'when no api_root is specified' do
      it 'defaults to nil' do
        expect(config.api_root).to be_nil
      end
    end

    context 'when a custom api_root is specified' do
      let(:custom_value) { 'http://example.com' }

      before do
        DatastoreApi.configure { |config| config.api_root = custom_value }
      end

      it 'returns configured value' do
        expect(config.api_root).to eq(custom_value)
      end
    end
  end

  describe '#api_path' do
    context 'when no api_path is specified' do
      it 'defaults to API v1' do
        expect(config.api_path).to eq('/api/v1')
      end
    end

    context 'when a custom api_path is specified' do
      let(:custom_value) { '/api/v2' }

      before do
        DatastoreApi.configure { |config| config.api_root = custom_value }
      end

      it 'returns configured value' do
        expect(config.api_root).to eq(custom_value)
      end
    end
  end

  describe '#auth_type' do
    context 'when no auth_type is specified' do
      it 'defaults to `basic`' do
        expect(config.auth_type).to eq(:basic)
      end
    end

    context 'when a custom auth_type is specified' do
      let(:custom_value) { :jwt }

      before do
        DatastoreApi.configure { |config| config.auth_type = custom_value }
      end

      it 'returns configured value' do
        expect(config.auth_type).to eq(custom_value)
      end
    end
  end

  describe '#basic_auth_username' do
    context 'when no basic_auth_username is specified' do
      it 'defaults to nil' do
        expect(config.basic_auth_username).to be_nil
      end
    end

    context 'when a custom basic_auth_username is specified' do
      let(:custom_value) { 'username' }

      before do
        DatastoreApi.configure { |config| config.basic_auth_username = custom_value }
      end

      it 'returns configured value' do
        expect(config.basic_auth_username).to eq(custom_value)
      end
    end
  end

  describe '#basic_auth_password' do
    context 'when no basic_auth_password is specified' do
      it 'defaults to nil' do
        expect(config.basic_auth_password).to be_nil
      end
    end

    context 'when a custom basic_auth_password is specified' do
      let(:custom_value) { 'secret' }

      before do
        DatastoreApi.configure { |config| config.basic_auth_password = custom_value }
      end

      it 'returns configured value' do
        expect(config.basic_auth_password).to eq(custom_value)
      end
    end
  end

  describe '#open_timeout' do
    context 'when no open_timeout is specified' do
      it 'has a default timeout' do
        expect(config.open_timeout).to eq(10)
      end
    end

    context 'when a custom open_timeout is specified' do
      let(:custom_value) { 123 }

      before do
        DatastoreApi.configure { |config| config.open_timeout = custom_value }
      end

      it 'returns configured value' do
        expect(config.open_timeout).to eq(custom_value)
      end
    end
  end

  describe '#read_timeout' do
    context 'when no read_timeout is specified' do
      it 'has a default timeout' do
        expect(config.read_timeout).to eq(20)
      end
    end

    context 'when a custom read_timeout is specified' do
      let(:custom_value) { 555 }

      before do
        DatastoreApi.configure { |config| config.read_timeout = custom_value }
      end

      it 'returns configured value' do
        expect(config.read_timeout).to eq(custom_value)
      end
    end
  end

  describe '#request_headers' do
    context 'when no request_headers are specified' do
      it 'has default request_headers' do
        expect(
          config.request_headers
        ).to eq({
          'User-Agent' => "laa-criminal-applications-datastore-api-client v#{DatastoreApi::VERSION}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        })
      end
    end

    context 'when custom request_headers are specified' do
      let(:custom_value) { { 'User-Agent' => 'Test Agent' } }

      before do
        DatastoreApi.configure { |config| config.request_headers = custom_value }
      end

      it 'returns configured value' do
        expect(config.request_headers).to eq(custom_value)
      end
    end
  end

  describe '#http_client_class' do
    context 'when no http_client_class is specified' do
      it 'defaults to the gem built-in client' do
        expect(config.http_client_class).to eq(DatastoreApi::HttpClient)
      end
    end

    context 'when an http_client_class is specified' do
      let(:custom_value) { double('SuperClient') }

      before do
        DatastoreApi.configure { |config| config.http_client_class = custom_value }
      end

      it 'returns configured value' do
        expect(config.http_client_class).to eq(custom_value)
      end
    end
  end
end
