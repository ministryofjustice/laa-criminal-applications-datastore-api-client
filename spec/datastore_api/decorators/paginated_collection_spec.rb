# frozen_string_literal: true

RSpec.describe DatastoreApi::Decorators::PaginatedCollection do
  subject { described_class.new(collection, pagination) }

  let(:collection) { [1, 2, 3] }
  let(:pagination) { { limit: 10 } }

  context 'delegation' do
    it 'delegates methods to the collection' do
      expect(collection).to receive(:size)
      subject.size
    end

    it 'pagination method is not delegated' do
      expect(collection).not_to receive(:pagination)
      expect(subject.pagination).to be(pagination)
    end
  end
end
