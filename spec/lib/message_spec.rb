require 'spec_helper'

describe Hookly::Message do
  describe '.create' do
    let(:options) { { id: 5, text: 'Thanks for the information!' } }
    let(:create) { described_class.create('#updates', options) }

    let!(:response) { run_response(id: 1440, slug: '#updates', body: options) }

    before do
      allow(Hookly::Request).to receive(:run).and_return(response)
    end

    it 'should post to messages' do
      expect(Hookly::Request).to receive(:run).with(:post, :messages, anything, anything).and_return(response)

      create
    end

    it 'should specify the slug' do
      expect(Hookly::Request).to receive(:run).with(anything, anything, hash_including(slug: '#updates'), anything).and_return(response)

      create
    end

    it 'should send the body' do
      expect(Hookly::Request).to receive(:run).with(anything, anything, anything, id: 5, text: 'Thanks for the information!').and_return(response)

      create
    end

    it 'should return the message' do
      expect(create).to be_a(Hookly::Message)
      expect(create.id).to eq(1440)
      expect(create.slug).to eq('#updates')
      expect(create.uid).to eq(nil)
      expect(create.body).to eq('id' => 5, 'text' => 'Thanks for the information!')
    end

    describe 'when given a user identifier' do
      let(:create) { described_class.create('#updates', '5a17b-124f5', id: 5, text: 'Thanks for the information!' ) }

      it 'should specify the uid' do
        expect(Hookly::Request).to receive(:run).with(anything, anything, hash_including(uid: '5a17b-124f5'), anything).and_return(response)

        create
      end
    end
  end
end
