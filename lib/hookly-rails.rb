require 'hookly-rails/version'

module Hookly
  module Rails
    if defined?(::Rails)
      class Rails::Engine < ::Rails::Engine
        # this will enable the asset pipeline
      end
    end
  end
end
