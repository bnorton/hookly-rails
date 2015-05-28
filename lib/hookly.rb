##
# Dependencies
#
require 'json'
require 'typhoeus'

##
# Project files
#
require 'request'
require 'message'
require 'error'

module Hookly
  %i(token secret url).each do |name|
    define_singleton_method(name, &-> { instance_variable_get(:"@#{name}") })
    define_singleton_method("#{name}=", &->(v) { instance_variable_set(:"@#{name}", v) })
  end

  module Rails
    if defined?(::Rails)
      class Rails::Engine < ::Rails::Engine
        # this will enable the asset pipeline
      end
    end
  end
end

require 'hookly/version'

Hookly.url = 'https://hookly.herokuapp.com'
