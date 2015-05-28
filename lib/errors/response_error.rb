module Hookly
  class ResponseError < StandardError
    def initialize(response)
      super "The request failed with code: `#{response.response_code}`"
    end
  end
end
