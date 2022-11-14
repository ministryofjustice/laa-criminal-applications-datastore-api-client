shared_examples 'an API request' do
  describe '#http_client' do
    before do
      allow(subject).to receive(:http_client).and_call_original
    end

    it 'gets the client from the configuration' do
      expect(
        DatastoreApi.configuration
      ).to receive(:http_client_class).and_return(double.as_null_object)

      subject.call
    end
  end
end
