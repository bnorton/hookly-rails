module Hookly
  class Message
    attr_reader :id, :slug, :uid, :body

    def self.create(slug, *args)
      body = args.pop

      new(Request.run(:post, :messages, { slug: slug, :uid => args.last }, body))
    end

    def initialize(options)
      @id = options['id']
      @slug = options['slug']
      @uid = options['uid']
      @body = options['body']
    end
  end
end
