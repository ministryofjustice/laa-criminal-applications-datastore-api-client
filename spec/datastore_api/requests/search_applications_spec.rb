# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::SearchApplications do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, post: response) }

  let(:args) do
    {
      search_text: 'John',
      pagination: { per_page: 5 }
    }
  end

  let(:response) { { 'pagination' => { limit: 10 }, 'records' => [{}, {}] } }

  describe '.new' do
    let(:args) { {} }

    it 'raises an error if there is no criteria' do
      expect {
        subject.call
      }.to raise_error(ArgumentError, 'search criteria is required')
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in a PaginatedCollection' do
      expect(subject.call).to be_a(DatastoreApi::Decorators::PaginatedCollection)
    end

    it 'returns applications' do
      expect(subject.call.size).to eq(2)
    end

    it 'returns the pagination metadata' do
      expect(subject.call.pagination).to eq({ limit: 10 })
    end

    context 'endpoint' do
      it 'posts to the correct endpoint' do
        expect(http_client).to receive(:post).with('/searches', any_args)
        subject.call
      end
    end

    context 'payload' do
      it 'posts the correct payload' do
        expect(http_client).to receive(:post).with(
          any_args, { search: { search_text: 'John' }, pagination: { per_page: 5 } }
        )
        subject.call
      end
    end
  end
end
