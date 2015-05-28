module Hookly
  class Request
    def self.run(name, path, options, body={})
      request_options = {
        method: name,
        accept_encoding: :gzip,
        headers: { 'Content-Type' => 'application/json', 'User-Agent' => user_agent }
      }

      request_options[body_param(name)] = processed_body(name, options.merge( secret: Hookly.secret, :body => body ))

      response = Typhoeus::Request.new("#{Hookly.url}/#{path}", request_options).run

      if response.success?
        JSON.parse(response.response_body)['message']
      else
        raise ResponseError.new(response)
      end
    end

    private

    def self.user_agent
      "hookly-rails [language(ruby), lib-version(#{Hookly::VERSION}), platform(#{RUBY_PLATFORM}), platform-version(#{RUBY_VERSION})]"
    end

    def self.body_param(name)
      %w(get delete).include?(name.to_s) ? :params : :body
    end

    def self.processed_body(name, options)
      %w(get delete).include?(name.to_s) ? options : JSON.dump(options)
    end
  end
end
