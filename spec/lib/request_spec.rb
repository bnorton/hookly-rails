require 'spec_helper'

describe Hookly::Request do
  describe '.run' do
    let(:method) { %w(get post patch delete).sample }
    let(:options) { { option1: 1, option2: 2  } }
    let(:body) { double('Hash[body]') }
    let(:run) { described_class.run(method, 'pathname', options, body) }

    let!(:request) { double(:request, :run => response) }
    let!(:response) { double(:response, :success? => true, :response_body => { response: 'body' }.to_json, :response_code => 900) }

    before do
      allow(Typhoeus::Request).to receive(:new).and_return(request)
    end

    it 'should send the url + path' do
      expect(Typhoeus::Request).to receive(:new).with('http://test.host:1234/pathname', anything).and_return(request)

      run
    end

    it 'should send the method' do
      expect(Typhoeus::Request).to receive(:new).with(anything, hash_including(method: method)).and_return(request)

      run
    end

    it 'should be json' do
      expect(Typhoeus::Request).to receive(:new).with(anything, hash_including(headers: { 'Content-Type' => 'application/json', 'User-Agent' => "hookly-rails [language(ruby), lib-version(#{Hookly::VERSION}), platform(#{RUBY_PLATFORM}), platform-version(#{RUBY_VERSION})]" })).and_return(request)

      run
    end

    it 'should run the request' do
      expect(request).to receive(:run)

      run
    end

    it 'should return the response body' do
      expect(run).to eq({ 'response' => 'body' })
    end

    describe 'with a body' do
      let(:method) { %w(post patch).sample }

      it 'should send the auth + options + body' do
        expected_body = { option1: 1, option2: 2, secret: 'test-config-secret', body: body }.to_json
        expect(Typhoeus::Request).to receive(:new).with(anything, hash_including(body: expected_body)).and_return(request)

        run
      end
    end

    describe 'with url parameters' do
      let(:method) { %w(get delete).sample }

      it 'should send the auth + options + body' do
        expected_params = { secret: 'test-config-secret', option1: 1, option2: 2, body: body }
        expect(Typhoeus::Request).to receive(:new).with(anything, hash_including(params: expected_params)).and_return(request)

        run
      end

      describe 'without a body' do
        let(:run) { described_class.run(method, 'pathname', options) }

        it 'should send the auth + options' do
          expected_params = { secret: 'test-config-secret', option1: 1, option2: 2, body: {} }
          expect(Typhoeus::Request).to receive(:new).with(anything, hash_including(params: expected_params)).and_return(request)

          run
        end
      end
    end

    describe 'on error' do
      before do
        allow(response).to receive(:success?).and_return(false)
      end

      it 'should error' do
        expect {
          run
        }.to raise_error(Hookly::ResponseError, /failed with code: `900`/)
      end
    end
  end
end
