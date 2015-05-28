module Hookly
  MAJOR = 0
  MINOR = 1
  PATCH = 2
  PRE   = nil

  VERSION = [MAJOR, MINOR, PATCH, PRE].map(&:freeze).compact.join('.').freeze
end
